// To parse this JSON data, do
//
//     final pagosModal = pagosModalFromJson(jsonString);

import 'dart:convert';

PagosModal pagosModalFromJson(String str) =>
    PagosModal.fromJson(json.decode(str));

String pagosModalToJson(PagosModal data) => json.encode(data.toJson());

class PagosModal {
  PagosModal({
    this.id,
    this.idTipo,
    this.empresaId,
    this.pago,
    this.nombre,
  });

  int id;
  int idTipo;
  int empresaId;
  dynamic pago;
  String nombre;

  factory PagosModal.fromJson(Map<String, dynamic> json) => PagosModal(
        id: json["id"],
        idTipo: json["id_tipo"],
        empresaId: json["empresaId"],
        pago: json["pago"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_tipo": idTipo,
        "empresaId": empresaId,
        "pago": pago,
        "nombre": nombre,
      };
}
