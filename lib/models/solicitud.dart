// To parse this JSON data, do
//
//     final solicitudModel = solicitudModelFromJson(jsonString);

import 'dart:convert';

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
  String? horaFinal;
  String? idarea;
  int? sala;
  String? horaInicial;
  String? idsala;
  String? urlSala;
  String? nombre;
  String? key;

// final timestamp1 = 1627510285; // timestamp in seconds
//   final DateTime date1 = DateTime.fromMillisecondsSinceEpoch(timestamp1 * 1000);
//   print(date1);

  factory SolicitudModel.fromJson(Map<dynamic, dynamic> json) => SolicitudModel(
      area: json["area"],
      descripcion: json["descripcion"],
      fecha: DateTime.fromMillisecondsSinceEpoch(json["fecha"]),
      horaFinal: json["hora_final"],
      idarea: json["idarea"],
      sala: json["sala"],
      horaInicial: json["hora_inicial"],
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
