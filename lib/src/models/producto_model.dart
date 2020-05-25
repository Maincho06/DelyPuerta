import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';

class ProductoFirebase{
  String key;
  String nombre;
  String imagen;
  dynamic precio;

  ProductoFirebase(this.key,this.nombre,this.imagen,this.precio);

  ProductoFirebase.getProducto(DataSnapshot snapshot) :
  key = snapshot.key,
  nombre = snapshot.value['nombre'],
  imagen = snapshot.value['imagen'],
  precio = snapshot.value['precio'];
    
}

// To parse this JSON data, do
//
//     final productoMysql = productoMysqlFromJson(jsonString);


ProductoMysql productoMysqlFromJson(String str) => ProductoMysql.fromJson(json.decode(str));

String productoMysqlToJson(ProductoMysql data) => json.encode(data.toJson());

class ProductoMysql {
    String nombreP;
    String descripcionP;
    int costoP;
    String imagenP;
    int idEmpresa;

    ProductoMysql({
        this.nombreP,
        this.descripcionP,
        this.costoP,
        this.imagenP,
        this.idEmpresa,
    });

    factory ProductoMysql.fromJson(Map<String, dynamic> json) => ProductoMysql(
        nombreP: json["nombreP"],
        descripcionP: json["descripcionP"],
        costoP: json["costoP"],
        imagenP: json["imagenP"],
        idEmpresa: json["idEmpresa"],
    );

    Map<String, dynamic> toJson() => {
        "nombreP": nombreP,
        "descripcionP": descripcionP,
        "costoP": costoP,
        "imagenP": imagenP,
        "idEmpresa": idEmpresa,
    };
}
