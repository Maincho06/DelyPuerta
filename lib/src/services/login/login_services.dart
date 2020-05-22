

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:delipuerta/src/share_prefs/preferencias.dart';

class Login{
  final url='https://api-pollo.herokuapp.com';
    PreferenciasUsuario _prefs = new PreferenciasUsuario();
    final prefs = new PreferenciasUsuario();
      login(String email,String password) async{
    
    
    final cuerpo = {
    "correo": email,
    "password": password,
    };
    final url2='$url/Usuario/login';
    final resp = await http.post(
      url2,
      body: jsonEncode(cuerpo),
      headers: {
        "Content-Type"  : "application/json",
       
      }
    );


    final decodedResp= jsonDecode(resp.body);
   
    
    if(resp.statusCode==200){

    if(decodedResp.containsKey('Status'))
    { 
      print(decodedResp);
      return { 'ok':false , 'mensaje':decodedResp['Status']};
    }
    else if(decodedResp.containsKey('token'))
    { final id = decodedResp['datos']['usuarioId'];
      final token = decodedResp['token'];
      final tipous = decodedResp['datos']['tipoUsuarioId'];
      
       prefs.usuarioId = id;
       prefs.tipoUsuario = tipous;
       prefs.token=token;
    //  await _registertoken(token, id);
    //  await _session.set(prefs.token, 86400);
    //  await guardartoken(id, prefs.celtoken);
    //  print(prefs.celtoken);
      return { 'ok':true , 'mensaje':'Ingreso exitoso'};
    }


    }
    else{
      return { 'ok':false , 'mensaje':'error al ingresar datos'};
    }
  }
}