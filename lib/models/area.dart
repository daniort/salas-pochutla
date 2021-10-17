// To parse this JSON data, do
//
//     final areaModel = areaModelFromJson(jsonString);

// import 'dart:convert';

// AreaModel areaModelFromJson(String str) => AreaModel.fromJson(json.decode(str));

// String areaModelToJson(AreaModel data) => json.encode(data.toJson());

class AreaModel {
  AreaModel({
    this.area,
    this.key,
  });

  String? area;
  String? key;

  factory AreaModel.fromJson(Map<dynamic, dynamic> json) => AreaModel(
        area: json["area"],
        key: json["key"],
      );

  Map<dynamic, dynamic> toJson() => {
        "area": area,
        "key": key,
      };
}
