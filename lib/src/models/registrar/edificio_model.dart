// To parse this JSON data, do
//
//     final edificioModel = edificioModelFromJson(jsonString);

import 'dart:convert';

List<EdificioModel> edificioModelFromJson(String str) => List<EdificioModel>.from(json.decode(str).map((x) => EdificioModel.fromJson(x)));

String edificioModelToJson(List<EdificioModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EdificioModel {
    EdificioModel({
        this.edificioId,
        this.edificioNombre,
    });

    int edificioId;
    String edificioNombre;

    factory EdificioModel.fromJson(Map<String, dynamic> json) => EdificioModel(
        edificioId: json["edificioId"],
        edificioNombre: json["edificioNombre"],
    );

    Map<String, dynamic> toJson() => {
        "edificioId": edificioId,
        "edificioNombre": edificioNombre,
    };
}
