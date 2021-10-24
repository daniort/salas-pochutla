// To parse this JSON data, do
//
//     final solicitudModel = solicitudModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

SolicitudModel solicitudModelFromJson(String str) =>
    SolicitudModel.fromJson(json.decode(str));

String solicitudModelToJson(SolicitudModel data) => json.encode(data.toJson());

class SolicitudModel {
  SolicitudModel({
    this.area,
    this.descripcion,
    this.fecha,
    this.horaFinal,
    this.idarea,
    this.sala,
    this.horaInicial,
    this.idsala,
    this.nombre,
    this.key,
    this.urlSala,
  });

  String? area;
  String? descripcion;
  DateTime? fecha;
  String? idarea;
  int? sala;
  TimeOfDay? horaFinal;
  TimeOfDay? horaInicial;
  String? idsala;
  String? urlSala;
  String? nombre;
  String? key;

  factory SolicitudModel.fromJson(Map<dynamic, dynamic> json) => SolicitudModel(
      area: json["area"],
      descripcion: json["descripcion"],
      fecha: DateTime.fromMillisecondsSinceEpoch(json["fecha"]),
      idarea: json["idarea"],
      sala: json["sala"],
      horaInicial: TimeOfDay(
          hour: int.parse(json["hora_inicial"].split(":")[0]),
          minute: int.parse(json["hora_inicial"].split(":")[1])),
      horaFinal: TimeOfDay(
          hour: int.parse(json["hora_final"].split(":")[0]),
          minute: int.parse(json["hora_final"].split(":")[1])),
      idsala: json["idsala"],
      nombre: json["nombre"],
      key: json["key"],
      urlSala: json["urlsala"]);

  Map<dynamic, dynamic> toJson() => {
        "area": area,
        "descripcion": descripcion,
        "fecha": fecha,
        "hora_final": horaFinal,
        "idarea": idarea,
        "sala": sala,
        "hora_inicial": horaInicial,
        "idsala": idsala,
        "nombre": nombre,
        "key": key,
      };
}
