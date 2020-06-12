import 'package:delipuerta/src/models/registrar/condominio_model.dart';
import 'package:delipuerta/src/models/registrar/edificio_model.dart';
import 'package:delipuerta/src/models/registrar/registro_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistrarServices {
  static const url = 'https://api-pollo.herokuapp.com';

  static Future<List<CondominioModel>>mostrarCondominios() async {
    final urlTemp = '$url/Condominio/mostrarCondominios';
    final response = await http.get(urlTemp);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    List<CondominioModel> listCondominio = condominioModelFromJson(response.body);    
    if (response.statusCode == 200) {
      return listCondominio;
    }else{return List<CondominioModel>();}
  }
  static Future<List<EdificioModel>>mostrarEdificio(int idcondo) async {
    final urlTemp = '$url/Condominio/mostrarEdificioXCondominio/$idcondo';
    final response = await http.get(urlTemp);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    List<EdificioModel> listEdificio = edificioModelFromJson(response.body);    
    if (response.statusCode == 200) {
      return listEdificio;
    }else{return List<EdificioModel>();}
  }
  static Future<String> registrarUsuario(RegistrarUsuarioModel _usuario) async {
    final urlTemp = '$url/Usuario/registrarUsuario';
    final a=registrarUsuarioModelToJson(_usuario);
    final response = await http.post(urlTemp,headers: {
        "Content-Type"  : "application/json",

      }, body: a);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    final decodedResp = json.decode(response.body);
    final respuesta = obtenerRespuesta(decodedResp);
    return respuesta;
  }
  static obtenerRespuesta(decodedResp) {
    List temp = decodedResp;
    Map map = temp[0];
    return map['resultado'];
  }
}
