class ResModel {
  ResModel({
    this.mensaje,
    this.code,
    this.data,
    this.success,
  });

  String? mensaje;
  dynamic data;
  int? code;
  bool? success;
}
