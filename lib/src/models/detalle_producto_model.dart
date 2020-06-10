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
    int eventoId;

    ProductoModel({
      this.productoId,
        this.productoNombre,
        this.productoDescripcion,
        this.productoCosto,
        this.productoImagen,
        this.eventoId,
    });

    factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        productoId: json["productoId"],
        productoNombre: json["productoNombre"],
        productoDescripcion: json["productoDescripcion"],
        productoCosto: json["productoCosto"].toDouble(),
        productoImagen: json["productoImagen"],
        eventoId: json["empresaId"],
    );

    Map<String, dynamic> toJson() => {
        "productoId": productoId,
        "productoNombre": productoNombre,
        "productoDescripcion": productoDescripcion,
        "productoCosto": productoCosto,
        "productoImagen": productoImagen,
        "empresaId": eventoId,
    };
}
