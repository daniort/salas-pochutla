// // To parse this JSON data, do
// //
// //     final salaModel = salaModelFromJson(jsonString);

// import 'dart:convert';

// SalaModel salaModelFromJson(String str) => SalaModel.fromJson(json.decode(str));

// String salaModelToJson(SalaModel data) => json.encode(data.toJson());

class SalaModel {
  SalaModel({
    this.numero,
    this.url,
    this.key,
  });

  int? numero;
  String? url;
  String? key;

  factory SalaModel.fromJson(Map<dynamic, dynamic> json) => SalaModel(
        numero: json["numero"],
        url: json["url"],
        key: json["key"],
      );

  Map<dynamic, dynamic> toJson() => {
        "numero": numero,
        "url": url,
        "key": key,
      };
}
