import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:delipuerta/src/models/items_model.dart';
import 'package:delipuerta/src/models/pedido_model.dart';
import 'package:delipuerta/src/share_prefs/preferencias.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class PerdidosServices {
  static const url = 'https://api-pollo.herokuapp.com';
  PreferenciasUsuario _prefs = new PreferenciasUsuario();

  subirfoto(int idpedido, String foto) async {
    final urlTemp = '$url/Eventos/enviarFotoFactura';
    final body = {"pedidoId": idpedido, "url": foto};
    final response = await http.put(urlTemp, body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
      "authorization": _prefs.token
    });

    final decodedResponse = json.decode(response.body);
    print(decodedResponse);
    if (response.statusCode == 202) {
      return 1;
    } else {
      return 0;
    }
  }

  agregarimagen(int idpedido, File picture) async {
    String hola;
    if (picture != null) {
      var imageName = Uuid().v1();
      var imagePath = "/users/$idpedido/$imageName.jpg";

      final StorageReference storageReference =
          FirebaseStorage().ref().child(imagePath);

      final StorageUploadTask uploadTask = storageReference.putFile(picture);

      var imageurl = await (await uploadTask.onComplete).ref.getDownloadURL();
      print('holasa $imageurl');
      hola = imageurl;
//final agregarnombre=await subirfoto(idpedido, imageurl);

      final StreamSubscription<StorageTaskEvent> streamSubscription =
          uploadTask.events.listen((event) {
        // You can use this to notify yourself or your user in any kind of way.
        // For example: you could use the uploadTask.events stream in a StreamBuilder instead
        // to show your user what the current status is. In that case, you would not need to cancel any
        // subscription as StreamBuilder handles this automatically.

        // Here, every StorageTaskEvent concerning the upload is printed to the logs.
        print('EVENT ${event.type}');
      });

// Cancel your subscription when done.
      await uploadTask.onComplete;
      streamSubscription.cancel();

      return hola;
    }
  }

  mostrarPedidos(int id, int estado) async {
    final pedidos = new List();
    //print(id);
    final urlTemp = '$url/Pedido/mostrarPedido/$id/$estado';
    final response = await http.get(urlTemp, headers: {
      "Content-Type": "application/json",
      "authorization": _prefs.token
    });

    final decodeResp = jsonDecode(response.body);

    if (decodeResp == null) return [];
    if (response.statusCode == 200 && decodeResp != null) {
      decodeResp.forEach((id) {
        final prodTemp = PedidosModel.fromJson(id);
        pedidos.add(prodTemp);
      });
      print(pedidos);
      return pedidos;
    }
  }

  mostrarEmpresaPorPedido(int eventoid) async {
    final urlTemp = '$url/Pedido/obtenerEmpresaPorEvento/$eventoid';
    final response = await http.get(urlTemp, headers: {
      "Content-Type": "application/json",
      "authorization": _prefs.token
    });
    final decodeResp = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return decodeResp;
    } else {
      return "error";
    }
  }

  retornartotal(int id) async {
    final items = new List();
    double hola = 0;
    print(id);
    final urlTemp = '$url/Pedido/obtenerItems/$id';
    final response = await http.get(urlTemp, headers: {
      "Content-Type": "application/json",
      "authorization": _prefs.token
    });

    final decodeResp = jsonDecode(response.body);

    if (decodeResp == null) return [];
    if (response.statusCode == 200 && decodeResp != null) {
      decodeResp.forEach((id) {
        final prodTemp = ItemsModel.fromJson(id);
        // print('${id['cantidad']}');
        double pre;
        pre = double.parse(
            (id['productoCosto'] * id['cantidad']).toStringAsFixed(2));

        hola = hola + pre;
        items.add(prodTemp);
      });
      // print(items);
      return hola;
    }
    if (response.statusCode == 500) {
      return 'error';
    }
  }

  mostrarItems(int id) async {
    final items = new List();
    print(id);
    final urlTemp = '$url/Pedido/obtenerItems/$id';
    final response = await http.get(urlTemp, headers: {
      "Content-Type": "application/json",
      "authorization": _prefs.token
    });

    final decodeResp = jsonDecode(response.body);

    if (decodeResp == null) return [];
    if (response.statusCode == 200 && decodeResp != null) {
      decodeResp.forEach((id) {
        final prodTemp = ItemsModel.fromJson(id);
        //  print('${id['cantidad']}');
        items.add(prodTemp);
      });
      // print(items);
      return items;
    }
  }

  insertarItem(int id, int cantidad, int idPedido) async {
    final items = new List();
    print(id);
    final urlTemp = '$url/Pedido/InsertarItem';
    final response = await http.get(urlTemp, headers: {
      "Content-Type": "application/json",
      "authorization": _prefs.token
    });

    final decodeResp = jsonDecode(response.body);

    if (decodeResp == null) return [];
    if (response.statusCode == 200 && decodeResp != null) {
      decodeResp.forEach((id) {
        final prodTemp = ItemsModel.fromJson(id);
        items.add(prodTemp);
      });
      return items;
    }
  }

  Future actualizarItemsPedido(int id, int cantidad) async {
    final items = new List();
    print(id);
    final cuerpo = {
      "itemId": id,
      "cantidad": cantidad,
    };

    final urlTemp = '$url/Pedido/actualizarItemsPedido';
    final response =
        await http.put(urlTemp, body: jsonEncode(cuerpo), headers: {
      "Content-Type": "application/json",
      "authorization": _prefs.token,
    });

    final decodeResp = jsonDecode(response.body);
    // print(decodeResp);
    if (decodeResp == null) return [];
    if (response.statusCode == 200 && decodeResp != null) {
      decodeResp.forEach((id) {
        final prodTemp = ItemsModel.fromJson(id);
        items.add(prodTemp);
      });
      return items;
    }
  }
}
