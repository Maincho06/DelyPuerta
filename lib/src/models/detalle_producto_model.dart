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

    ProductoModel({
        this.productoNombre,
        this.productoDescripcion,
        this.productoCosto,
    });

    factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        productoNombre: json["productoNombre"],
        productoDescripcion: json["productoDescripcion"],
        productoCosto: json["productoCosto"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "productoNombre": productoNombre,
        "productoDescripcion": productoDescripcion,
        "productoCosto": productoCosto,
    };
}
