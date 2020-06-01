// To parse this JSON data, do
//
//     final carritoModel = carritoModelFromJson(jsonString);

import 'dart:convert';

CarritoModel carritoModelFromJson(String str) => CarritoModel.fromJson(json.decode(str));

String carritoModelToJson(CarritoModel data) => json.encode(data.toJson());

class CarritoModel {
    int idUsuario;
    DateTime fecha;
    String descripcion;
    int idEvento;
    int idEstadoPedido;

    CarritoModel({
        this.idUsuario,
        this.fecha,
        this.descripcion,
        this.idEvento,
        this.idEstadoPedido,
    });

    factory CarritoModel.fromJson(Map<String, dynamic> json) => CarritoModel(
        idUsuario: json["idUsuario"],
        fecha: DateTime.parse(json["fecha"]),
        descripcion: json["descripcion"],
        idEvento: json["idEvento"],
        idEstadoPedido: json["idEstadoPedido"],
    );

    Map<String, dynamic> toJson() => {
        "idUsuario": idUsuario,
        "fecha": fecha.toIso8601String(),
        "descripcion": descripcion,
        "idEvento": idEvento,
        "idEstadoPedido": idEstadoPedido,
    };
}
