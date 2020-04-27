import 'package:delipuerta/src/models/detalle_producto_model.dart';
import 'package:delipuerta/src/models/evento_model.dart';
import 'package:http/http.dart' as http;

class EventoServices {
  static const URL = 'https://api-pollo.herokuapp.com';

  Future<String> registrarEvento(EventoModel eventoModel) async {
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
  }

  void insertarDetalle(List<ProductoModel> lproducto) {
    lproducto.forEach((producto) {
      insertarDetalleEvento(producto);
    });
  }

  Future<bool> insertarDetalleEvento(ProductoModel productoModel) async {
    final urlTemp = '$URL/insertarProducto';
    productoModel.productoImagen = '';
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
}

final eventoServices = EventoServices();