// To parse this JSON data, do
//
//     final itemModel = itemModelFromJson(jsonString);

import 'dart:convert';

ItemModel itemModelFromJson(String str) => ItemModel.fromJson(json.decode(str));

String itemModelToJson(ItemModel data) => json.encode(data.toJson());

class ItemModel {
    int idProducto;
    int cantidad;
    int idpedido;

    ItemModel({
        this.idProducto,
        this.cantidad,
        this.idpedido,
    });

    factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        idProducto: json["idProducto"],
        cantidad: json["cantidad"],
        idpedido: json["idpedido"],
    );

    Map<String, dynamic> toJson() => {
        "idProducto": idProducto,
        "cantidad": cantidad,
        "idpedido": idpedido,
    };
}
