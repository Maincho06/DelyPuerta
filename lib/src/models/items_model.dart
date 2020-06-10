// To parse this JSON data, do
//
//     final itemsModel = itemsModelFromJson(jsonString);

import 'dart:convert';

ItemsModel itemsModelFromJson(String str) => ItemsModel.fromJson(json.decode(str));

String itemsModelToJson(ItemsModel data) => json.encode(data.toJson());

class ItemsModel {
    int productoId;
    String productoNombre;
    String productoDescripcion;
    double productoCosto;
    String productoImagen;
    int empresaId;
    int itemId;
    int eventoId;
    int cantidad;
    int pedidoId;

    ItemsModel({
        this.productoId,
        this.productoNombre,
        this.productoDescripcion,
        this.productoCosto,
        this.productoImagen,
        this.empresaId,
        this.itemId,
        this.eventoId,
        this.cantidad,
        this.pedidoId,
    });

    factory ItemsModel.fromJson(Map<String, dynamic> json) => ItemsModel(
        productoId: json["productoId"],
        productoNombre: json["productoNombre"],
        productoDescripcion: json["productoDescripcion"],
        productoCosto: json["productoCosto"].toDouble(),
        productoImagen: json["productoImagen"],
        empresaId: json["empresaId"],
        itemId: json["itemId"],
        eventoId: json["eventoId"],
        cantidad: json["cantidad"],
        pedidoId: json["pedidoId"],
    );

    Map<String, dynamic> toJson() => {
        "productoId": productoId,
        "productoNombre": productoNombre,
        "productoDescripcion": productoDescripcion,
        "productoCosto": productoCosto,
        "productoImagen": productoImagen,
        "empresaId": empresaId,
        "itemId": itemId,
        "eventoId": eventoId,
        "cantidad": cantidad,
        "pedidoId": pedidoId,
    };
}
