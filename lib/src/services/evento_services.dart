import 'dart:convert';

import 'package:delipuerta/src/models/detalle_producto_model.dart';
import 'package:delipuerta/src/models/evento_model.dart';
import 'package:delipuerta/src/share_prefs/preferencias.dart';
import 'package:http/http.dart' as http;

class EventoServices {
  static const URL = 'https://api-pollo.herokuapp.com';
  PreferenciasUsuario _prefs = new PreferenciasUsuario();

  Future<int> registrarEvento(EventoModel eventoModel) async {
    eventoModel.usuarioId = 1;
    final urlTemp = '$URL/Evento/agregarEvento';
    final response = await http.post(urlTemp,
        body: eventoModelToJson(eventoModel),
        headers: {
          "Content-Type": "application/json",
          "authorization": _prefs.token
        });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    final decodedResp = json.decode(response.body);
    final eventoId = obtenerEventoId(decodedResp);
    return eventoId;
  }

  void insertarDetalle(List<ProductoModel> lproducto, int eventoId) {
    lproducto.forEach((producto) {
      insertarDetalleEvento(producto, eventoId);
    });
  }

  mostrarEventos() async {
    final eventos = new List();

    final urlTemp = '$URL/Eventos/mostrarEventos';
    final response = await http.get(urlTemp, headers: {
      "Content-Type": "application/json",
      "authorization": _prefs.token
    });

    final decodeResp = jsonDecode(response.body);

    if (decodeResp == null) return [];
    if (response.statusCode == 200 && decodeResp != null) {
      decodeResp.forEach((id) {
        final prodTemp = EventoModel.fromJson(id);
        eventos.add(prodTemp);
      });
      print(eventos);
      return eventos;
    }
  }

  Future<bool> insertarDetalleEvento(
      ProductoModel productoModel, int eventoId) async {
    final urlTemp = '$URL/Producto/agregarProducto';
    productoModel.productoImagen = '';
    productoModel.empresaId = eventoId;
    final response = await http.post(urlTemp,
        body: productoModelToJson(productoModel),
        headers: {
          "Content-Type": "application/json",
          "authorization": _prefs.token
        });
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
