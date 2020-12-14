// To parse this JSON data, do
//
//     final venta = ventaFromJson(jsonString);

import 'dart:convert';

Venta ventaFromJson(String str) => Venta.fromJson(json.decode(str));

String ventaToJson(Venta data) => json.encode(data.toJson());

class Venta {
    Venta({
        this.cantidad,
        this.pelicula,
        this.usuario,
        this.valor,
    });

    String cantidad;
    String pelicula;
    String usuario;
    String valor;

    factory Venta.fromJson(Map<String, dynamic> json) => Venta(
        cantidad: json['cantidad'],
        pelicula: json['pelicula'],
        usuario: json['usuario'],
        valor: json['valor'],
    );

    Map<String, dynamic> toJson() => {
        'cantidad': cantidad,
        'pelicula': pelicula,
        'usuario': usuario,
        'valor': valor,
    };
}