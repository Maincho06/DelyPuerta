// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
    String productoNombre;
    String productoDescripcion;
    double productoCosto;
    String productoImagen;
    int eventoId;

    ProductoModel({
        this.productoNombre,
        this.productoDescripcion,
        this.productoCosto,
        this.productoImagen,
        this.eventoId,
    });

    factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        productoNombre: json["productoNombre"],
        productoDescripcion: json["productoDescripcion"],
        productoCosto: json["productoCosto"].toDouble(),
        productoImagen: json["productoImagen"],
        eventoId: json["empresaId"],
    );

    Map<String, dynamic> toJson() => {
        "productoNombre": productoNombre,
        "productoDescripcion": productoDescripcion,
        "productoCosto": productoCosto,
        "productoImagen": productoImagen,
        "empresaId": eventoId,
    };
}
