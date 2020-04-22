// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    String usuarioDni;
    String usuarioNombre;
    String usuarioApellido;
    String usuarioTelefono;
    String usuarioCorreo;
    String usuarioContrasea;
    String condominioNombre;
    String condominioDescripcion;
    String edificioNombre;
    String edificioDescripcion;
    String departamentoNombre;
    String departamentoDescripcion;

    Usuario({
        this.usuarioDni,
        this.usuarioNombre,
        this.usuarioApellido,
        this.usuarioTelefono,
        this.usuarioCorreo,
        this.usuarioContrasea,
        this.condominioNombre,
        this.condominioDescripcion,
        this.edificioNombre,
        this.edificioDescripcion,
        this.departamentoNombre,
        this.departamentoDescripcion,
    });

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        usuarioDni: json["usuarioDni"],
        usuarioNombre: json["usuarioNombre"],
        usuarioApellido: json["usuarioApellido"],
        usuarioTelefono: json["usuarioTelefono"],
        usuarioCorreo: json["usuarioCorreo"],
        usuarioContrasea: json["usuarioContraseña"],
        condominioNombre: json["condominioNombre"],
        condominioDescripcion: json["condominioDescripcion"],
        edificioNombre: json["edificioNombre"],
        edificioDescripcion: json["edificioDescripcion"],
        departamentoNombre: json["departamentoNombre"],
        departamentoDescripcion: json["departamentoDescripcion"],
    );

    Map<String, dynamic> toJson() => {
        "usuarioDni": usuarioDni,
        "usuarioNombre": usuarioNombre,
        "usuarioApellido": usuarioApellido,
        "usuarioTelefono": usuarioTelefono,
        "usuarioCorreo": usuarioCorreo,
        "usuarioContraseña": usuarioContrasea,
        "condominioNombre": condominioNombre,
        "condominioDescripcion": condominioDescripcion,
        "edificioNombre": edificioNombre,
        "edificioDescripcion": edificioDescripcion,
        "departamentoNombre": departamentoNombre,
        "departamentoDescripcion": departamentoDescripcion,
    };
}
