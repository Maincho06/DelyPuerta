import 'dart:convert';

import 'package:delipuerta/src/models/carrito_model.dart';
import 'package:delipuerta/src/models/detalle_producto_model.dart';
import 'package:delipuerta/src/models/item_model.dart';
import 'package:delipuerta/src/share_prefs/preferencias.dart';
import 'package:http/http.dart' as http;

class PedidoServices {
  static const URL = 'https://api-pollo.herokuapp.com';
  PreferenciasUsuario _prefs = new PreferenciasUsuario();
  CarritoModel carritoModel = new CarritoModel();
  
  Future<int> registrarPedido(int eventoId) async {
     int id=_prefs.usuarioId;
    carritoModel.idUsuario= id;
    carritoModel.fecha=DateTime.now();
    carritoModel.descripcion="por pagar";
    carritoModel.idEvento=eventoId;
    carritoModel.idEstadoPedido=3;

    final urlTemp = '$URL/Pedido/InsertarCarrito';
    final response = await http.post(urlTemp,
        body: carritoModelToJson(carritoModel),
        headers: {
          "Content-Type": "application/json",
          "authorization": _prefs.token
        });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    final decodedResp = json.decode(response.body);
    final pedidoId = obtenerPedidoId(decodedResp);
    return pedidoId;
  }
  obtenerPedidoId(decodedResp) {
    List temp = decodedResp;
    Map map = temp[0];
    return map['idPedido'];
  }

  void insertarItems(List<ProductoModel> producto, List<int> cant,int pedidoId) {
    int i=0;
    ItemModel itemModel = new ItemModel();
    producto.forEach((produc) {
      itemModel.idProducto=produc.productoId;
      itemModel.cantidad=cant[i];
      itemModel.idpedido=pedidoId;
      item(itemModel);
      i++;
    });
  }

  Future<bool> item(ItemModel itemModel) async {
    final urlTemp = '$URL/Pedido/InsertarItem';
    final response = await http.post(urlTemp,
        body: itemModelToJson(itemModel),
        headers: {
          "Content-Type": "application/json",
          "authorization": _prefs.token
        });
    print('Response status: ${response.statusCode}');
    print('Response status: ${response.body}');
  }
}

final pedidoServices = PedidoServices();