import 'dart:async';

import 'dart:io';

import 'package:delipuerta/src/share_prefs/preferencias.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class PushNotificationProvider{

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

final _mensajesStreamController = StreamController<String>.broadcast();
PreferenciasUsuario _prefs=new PreferenciasUsuario();

Stream<String> get mensajes =>_mensajesStreamController.stream;

  initNotifications(){
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then( (token){
      print('===== FCM Token =====');
      print(token);
      print(_prefs.token);
      _prefs.celtoken=token;

    });

_firebaseMessaging.configure(

onMessage: (ms) async {

print('onMessage');

print(ms);

String event;
print(event);
if(Platform.isAndroid){
event= ms['data']['data'];
}
//_mensajesStreamController.sink.add(event);
},
onLaunch: (ms) async {

print('onLaunch');
print(ms);


String event;
print(event);

event=await ms['data']['data'] ?? 'solicitud';

  _mensajesStreamController.sink.add(event);


},
onResume: (ms) async {
  
print('onResume');

String event;
print(event);
if(Platform.isAndroid){
event= await ms['data']['data'] ?? 'solicitud';
}
 _mensajesStreamController.sink.add(event);

}

);

  }


dispose(){
  _mensajesStreamController?.close();
}

}