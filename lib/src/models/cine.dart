import 'dart:convert';

Cine cineFromJson(String str) => Cine.fromJson(json.decode(str));

String cineToJson(Cine data) => json.encode(data.toJson());

class Cine {
    Cine({
        this.id,
        this.nombre,
        this.direccion,
        this.salas,
    });

    String id;
    String nombre;
    String direccion;
    String salas;

    factory Cine.fromJson(Map<String, dynamic> json) => Cine(
        id: json["id"],
        nombre: json["nombre"],
        direccion: json["direccion"],
        salas: json["salas"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "direccion": direccion,
        "salas": salas,
    };
}