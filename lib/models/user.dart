// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

class UserModel {
  UserModel({
    this.cargo,
    this.nombre,
    this.contrasea,
    this.user,
    this.key,
  });

  String? cargo;
  String? nombre;
  String? contrasea;
  String? user;
  String? key;

  factory UserModel.fromJson(Map<dynamic, dynamic> json) => UserModel(
      cargo: json["cargo"],
      nombre: json["nombre"],
      contrasea: json["contraseña"],
      user: json['user'],
      key: json['key']);

  Map<dynamic, dynamic> toJson() => {
        "cargo": cargo,
        "nombre": nombre,
        "contraseña": contrasea,
        "user": user,
        "key": key,
      };
}
