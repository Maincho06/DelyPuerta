import 'dart:convert';

import 'package:delipuerta/src/models/detalle_producto_model.dart';
import 'package:delipuerta/src/models/evento_model.dart';
import 'package:delipuerta/src/share_prefs/preferencias.dart';
import 'package:http/http.dart' as http;

class ProductoService{
static const url = 'https://api-pollo.herokuapp.com';
   PreferenciasUsuario _prefs = new PreferenciasUsuario();


mostrarProducto(int id) async {
final eventos=new List();
    print(id);
    final urlTemp = 'https://api-pollo.herokuapp.com/Producto/mostrarProductoporEvento/$id';
    final response = await http.get(
      urlTemp,
   
      headers: {
        "Content-Type"  : "application/json",
        "authorization" : _prefs.token

      }
    );
    
    final decodeResp=jsonDecode(response.body);
    
    if(decodeResp==null)return [];
    if(response.statusCode==200 && decodeResp!=null){
    decodeResp.forEach((id){
      
      final prodTemp = ProductoModel.fromJson(id);
      eventos.add(prodTemp);
    });
    print(eventos);
      return eventos;
    }
  }

}