import 'package:flutter/material.dart';

class ProductoProvider with ChangeNotifier {
  String _prueba;
  String get prueba => this._prueba;

  set prueba(String nombre) {
    this._prueba = prueba;
    print(prueba);
    notifyListeners();
  }
}