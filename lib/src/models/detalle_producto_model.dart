// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
    int productoId;
    String productoNombre;
    String productoDescripcion;
    double productoCosto;
    String productoImagen;
    int empresaId;

    ProductoModel({
      this.productoId,
        this.productoNombre,
        this.productoDescripcion,
        this.productoCosto,
        this.productoImagen,
        this.empresaId,
    });

    factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        productoId: json["productoId"],
        productoNombre: json["productoNombre"],
        productoDescripcion: json["productoDescripcion"],
        productoCosto: json["productoCosto"].toDouble(),
        productoImagen: json["productoImagen"],
        empresaId: json["empresaId"],
    );

    Map<String, dynamic> toJson() => {
        "productoId": productoId,
        "productoNombre": productoNombre,
        "productoDescripcion": productoDescripcion,
        "productoCosto": productoCosto,
        "productoImagen": productoImagen,
        "empresaId": empresaId,
    };

     getPostImg(){
       
      if( productoImagen==null){
        return 'https://image.shutterstock.com/image-vector/no-image-available-icon-flat-600w-1240855801.jpg';
      }
      return productoImagen;
    }
}
