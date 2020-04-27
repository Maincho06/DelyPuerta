// To parse this JSON data, do
//
//     final eventoModel = eventoModelFromJson(jsonString);

import 'dart:convert';

EventoModel eventoModelFromJson(String str) => EventoModel.fromJson(json.decode(str));

String eventoModelToJson(EventoModel data) => json.encode(data.toJson());

class EventoModel {
    String eventoOrganizador;
    String eventoNombre;
    String eventoDescripcion;
    DateTime eventoFecha;
    int usuarioId;

    EventoModel({
        this.eventoOrganizador,
        this.eventoNombre,
        this.eventoDescripcion,
        this.eventoFecha,
        this.usuarioId,
    });

    factory EventoModel.fromJson(Map<String, dynamic> json) => EventoModel(
        eventoOrganizador: json["eventoOrganizador"],
        eventoNombre: json["eventoNombre"],
        eventoDescripcion: json["eventoDescripcion"],
        eventoFecha: DateTime.parse(json["eventoFecha"]),
        usuarioId: json["usuarioId"],
    );

    Map<String, dynamic> toJson() => {
        "eventoOrganizador": eventoOrganizador,
        "eventoNombre": eventoNombre,
        "eventoDescripcion": eventoDescripcion,
        "eventoFecha": eventoFecha.toIso8601String(),
        "usuarioId": usuarioId,
    };
}
