import 'package:http/http.dart' as http;

class NotificacionesServices{

  Future<bool> mandarnoti(String token,String titulo,String mensaje,String data) async{

  final url='https://api-pollo.herokuapp.com/enviarNotificacion';

 final resp = await http.post(url,body: { 
                        'token':token,
                        'title':titulo,
                        'body':mensaje,
                        'data':data});

print('funciono');
  return true;
}

 }
}