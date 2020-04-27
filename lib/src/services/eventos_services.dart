import 'dart:convert';

import 'package:delipuerta/src/models/usuario_model.dart';
import 'package:http/http.dart' as http;

class UsuarioServices {
  final String url = 'https://api-pollo.herokuapp.com';

  mostrarEventos() async {
    final urlTemp = '$url/Eventos/mostrarEventos';
    final response = await http.get(
      urlTemp,
   
      headers: {
        "Content-Type"  : "application/json"
      }
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    final decodeResp=jsonDecode(response.body);
    if(response.statusCode==200 && decodeResp!=null){
      return decodeResp;
    }
  }


}

