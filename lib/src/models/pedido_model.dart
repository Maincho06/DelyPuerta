// To parse this JSON data, do
//
//     final pedidosModel = pedidosModelFromJson(jsonString);

import 'dart:convert';

PedidosModel pedidosModelFromJson(String str) => PedidosModel.fromJson(json.decode(str));

String pedidosModelToJson(PedidosModel data) => json.encode(data.toJson());

class PedidosModel {
    int usuarioId;
    String usuarioDni;
    String usuarioNombre;
    String usuarioApellido;
    String usuarioTelefono;
    String usuarioCorreo;
    String usuarioContrasea;
    int tipoUsuarioId;
    String usuarioToken;
    String usuarioTokenCelular;
    int pedidoId;
    DateTime pedidoFecha;
    String pedidoDescripcion;
    int residenteId;
    int eventoId;
    int estadoPedidoId;
    String empresaRuc;
    String empresaRazonSocial;
    String eventoNombre;
    int estadoEventoId;
    double montoTotal;
    PedidosModel({
        this.usuarioId,
        this.usuarioDni,
        this.usuarioNombre,
        this.usuarioApellido,
        this.usuarioTelefono,
        this.usuarioCorreo,
        this.usuarioContrasea,
        this.tipoUsuarioId,
        this.usuarioToken,
        this.usuarioTokenCelular,
        this.pedidoId,
        this.pedidoFecha,
        this.pedidoDescripcion,
        this.residenteId,
        this.eventoId,
        this.estadoPedidoId,
        this.empresaRuc,
        this.empresaRazonSocial,
        this.eventoNombre,
        this.estadoEventoId,
        this.montoTotal,
    });

    factory PedidosModel.fromJson(Map<String, dynamic> json) => PedidosModel(
        usuarioId: json["usuarioId"],
        usuarioDni: json["usuarioDni"],
        usuarioNombre: json["usuarioNombre"],
        usuarioApellido: json["usuarioApellido"],
        usuarioTelefono: json["usuarioTelefono"],
        usuarioCorreo: json["usuarioCorreo"],
        usuarioContrasea: json["usuarioContraseña"],
        tipoUsuarioId: json["tipoUsuarioId"],
        usuarioToken: json["usuarioToken"],
        usuarioTokenCelular: json["usuarioTokenCelular"],
        pedidoId: json["pedidoId"],
        pedidoFecha: DateTime.parse(json["pedidoFecha"]),
        pedidoDescripcion: json["pedidoDescripcion"],
        residenteId: json["residenteId"],
        eventoId: json["eventoId"],
        estadoPedidoId: json["estadoPedidoId"],
        empresaRuc: json["empresaRuc"],
        empresaRazonSocial: json["empresaRazonSocial"],
        eventoNombre: json["eventoNombre"],
        estadoEventoId: json["estadoEventoId"],
    );

    Map<String, dynamic> toJson() => {
        "usuarioId": usuarioId,
        "usuarioDni": usuarioDni,
        "usuarioNombre": usuarioNombre,
        "usuarioApellido": usuarioApellido,
        "usuarioTelefono": usuarioTelefono,
        "usuarioCorreo": usuarioCorreo,
        "usuarioContraseña": usuarioContrasea,
        "tipoUsuarioId": tipoUsuarioId,
        "usuarioToken": usuarioToken,
        "usuarioTokenCelular": usuarioTokenCelular,
        "pedidoId": pedidoId,
        "pedidoFecha": pedidoFecha.toIso8601String(),
        "pedidoDescripcion": pedidoDescripcion,
        "residenteId": residenteId,
        "eventoId": eventoId,
        "estadoPedidoId": estadoPedidoId,
        "empresaRuc": empresaRuc,
        "empresaRazonSocial": empresaRazonSocial,
        "eventoNombre": eventoNombre,
        "estadoEventoId": estadoEventoId,

    };
}
