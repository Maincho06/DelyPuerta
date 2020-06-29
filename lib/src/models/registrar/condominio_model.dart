// To parse this JSON data, do
//
//     final condominioModel = condominioModelFromJson(jsonString);

import 'dart:convert';

List<CondominioModel> condominioModelFromJson(String str) => List<CondominioModel>.from(json.decode(str).map((x) => CondominioModel.fromJson(x)));

String condominioModelToJson(List<CondominioModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CondominioModel {
    CondominioModel({
        this.condominioId,
        this.codominioNombre,
    });

    int condominioId;
    String codominioNombre;

    factory CondominioModel.fromJson(Map<String, dynamic> json) => CondominioModel(
        condominioId: json["condominioId"],
        codominioNombre: json["condominioNombre"],
    );

    Map<String, dynamic> toJson() => {
        "condominioId": condominioId,
        "condominioNombre": codominioNombre,
    };
}
