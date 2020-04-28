import 'dart:convert';

import 'package:delipuerta/src/models/detalle_producto_model.dart';
import 'package:delipuerta/src/models/evento_model.dart';
import 'package:http/http.dart' as http;

class EventoServices {
  static const URL = 'https://api-pollo.herokuapp.com';

  Future<int> registrarEvento(EventoModel eventoModel) async {
    eventoModel.usuarioId = 1;
    final urlTemp = '$URL/Evento/agregarEvento';
    final response = await http.post(
      urlTemp,
      body: eventoModelToJson(eventoModel),
      headers: {
        "Content-Type"  : "application/json"
      }
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    final decodedResp = json.decode(response.body); 
    final eventoId = obtenerEventoId(decodedResp);
    return eventoId;
  }

  void insertarDetalle(List<ProductoModel> lproducto,int eventoId) {
    lproducto.forEach((producto) {
      insertarDetalleEvento(producto, eventoId);
    });
  }

  Future<bool> insertarDetalleEvento(ProductoModel productoModel, int eventoId) async {
    final urlTemp = '$URL/Producto/agregarProducto';
    productoModel.productoImagen = '';
    productoModel.eventoId = eventoId;
    final response = await http.post(
      urlTemp,
      body: productoModelToJson(productoModel),
      headers: {
        "Content-Type"  : "application/json"
      }
    );
    print('Response status: ${response.statusCode}');
    print('Response status: ${response.body}');
  }

  obtenerEventoId(decodedResp) {
    List temp = decodedResp;
    Map map = temp[0];
    return map['EventoId'];
  }
}

final eventoServices = EventoServices();