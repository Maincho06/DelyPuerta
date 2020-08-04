import 'dart:convert';

import 'package:delipuerta/src/models/items_model.dart';
import 'package:delipuerta/src/models/pedido_model.dart';
import 'package:delipuerta/src/share_prefs/preferencias.dart';
import 'package:http/http.dart' as http;

class PerdidosServices {
  static const url = 'https://api-pollo.herokuapp.com';
  PreferenciasUsuario _prefs = new PreferenciasUsuario();

  mostrarPedidos(int id, int estado) async {
    final pedidos = new List();
    print(id);
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

  actualizarItemsPedido(int id, int cantidad) async {
    final items = new List();
    print(id);
    final urlTemp = '$url/Pedido/actualizarItemsPedido';
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
}
