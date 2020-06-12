// To parse this JSON data, do
//
//     final registrarUsuarioModel = registrarUsuarioModelFromJson(jsonString);

import 'dart:convert';

RegistrarUsuarioModel registrarUsuarioModelFromJson(String str) => RegistrarUsuarioModel.fromJson(json.decode(str));

String registrarUsuarioModelToJson(RegistrarUsuarioModel data) => json.encode(data.toJson());

class RegistrarUsuarioModel {
    RegistrarUsuarioModel({
        this.dni,
        this.nombre,
        this.apellido,
        this.telefono,
        this.correo,
        this.contrasena,
        this.edificio,
        this.departamento,
    });

    String dni;
    String nombre;
    String apellido;
    String telefono;
    String correo;
    String contrasena;
    int edificio;
    String departamento;

    factory RegistrarUsuarioModel.fromJson(Map<String, dynamic> json) => RegistrarUsuarioModel(
        dni: json["dni"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        telefono: json["telefono"],
        correo: json["correo"],
        contrasena: json["contraseña"],
        edificio: json["edificio"],
        departamento: json["departamento"],
    );

    Map<String, dynamic> toJson() => {
        "dni": dni,
        "nombre": nombre,
        "apellido": apellido,
        "telefono": telefono,
        "correo": correo,
        "contraseña": contrasena,
        "edificio": edificio,
        "departamento": departamento,
    };
}
