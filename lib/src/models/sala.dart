// To parse this JSON data, do
//
//     final sala = salaFromJson(jsonString);

import 'dart:convert';

import 'package:cinema/src/models/cine.dart';

Sala salaFromJson(String str) => Sala.fromJson(json.decode(str));

String salaToJson(Sala data) => json.encode(data.toJson());

class Sala {
  Sala({
    this.id,
    this.cine,
    this.libres,
    this.nombre,
    this.ocupadas,
    this.sillas,
  });

  String id;
  var cine;
  String libres;
  String nombre;
  String ocupadas;
  String sillas;

  factory Sala.fromJson(Map<String, dynamic> json) => Sala(
        id: json["id"],
        cine: json["cine"],
        libres: json["libres"],
        nombre: json["nombre"],
        ocupadas: json["ocupadas"],
        sillas: json["sillas"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cine": cine,
        "libres": libres,
        "nombre": nombre,
        "ocupadas": ocupadas,
        "sillas": sillas,
      };
}
