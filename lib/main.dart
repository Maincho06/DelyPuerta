import 'package:delipuerta/src/share_prefs/preferencias.dart';
import 'package:flutter/material.dart';
import 'package:delipuerta/src/app.dart';



void main() async{
   runApp(MyApp());
    final prefs = new PreferenciasUsuario();
   await prefs.initPrefs();
  
}

