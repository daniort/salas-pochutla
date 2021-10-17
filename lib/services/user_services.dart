import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sigea/models/models.dart';
import 'package:sigea/models/res.dart';
import 'package:sigea/models/user.dart';

class UserServices {
  // final _db = new DataBase();
  final FirebaseDatabase realDB = new FirebaseDatabase();
  DataSnapshot? snap;

  // Future<void> crearNuevoUsuario(Map<String, Object> map) async {
  //   await realDB.reference().child('users').push().set(map);
  // }

  ResModel resfail = ResModel(success: false, mensaje: 'Algo salió mal.');

  Future<void> addUser(Map item) async {
    await realDB.reference().child('users').push().set(item);
  }

  Future<void> addSala(Map item) async {
    await realDB.reference().child('salas').push().set(item);
  }

  Future<void> addAreas(Map item) async {
    await realDB.reference().child('areas').push().set(item);
  }

  Future<ResModel> login(String text, String text2) async {
    this.snap = await realDB
        .reference()
        .child('users')
        .orderByChild('user')
        .equalTo(text)
        .once();
    if (this.snap!.exists) {
      Map data = {};
      this.snap!.value.forEach((key, val) {
        data = Map.from(val);
        data['key'] = key;
      });
      if (data['firma'] == text2) {
        return ResModel(success: true, data: UserModel.fromJson(data));
      } else {
        return ResModel(
          success: false,
          mensaje: 'Clave inválida.',
        );
      }
    } else {
      return ResModel(
        success: false,
        mensaje: 'Usuario inválido.',
      );
    }
  }

  Future<ResModel> getSalas() async {
    try {
      DataSnapshot asi = await realDB.reference().child('salas').once();
      if (asi.exists) {
        List<SalaModel> salas = [];
        asi.value.forEach((key, val) {
          Map _data = Map.from(val);
          _data['key'] = key;
          salas.add(SalaModel.fromJson(_data));
        });
        return ResModel(
          success: true,
          data: salas,
        );
      } else {
        return ResModel(
          success: false,
          mensaje: 'Salas no encontradas',
        );
      }
    } catch (e) {
      print("ERROR ");
      print(e);
      return resfail;
    }
  }

  Future<ResModel> getAreas() async {
    try {
      DataSnapshot asi = await realDB.reference().child('areas').once();

      if (asi.exists) {
        List<AreaModel> salas = [];
        asi.value.forEach((key, val) {
          Map _data = Map.from(val);
          _data['key'] = key;
          salas.add(AreaModel.fromJson(_data));
        });
        return ResModel(
          success: true,
          data: salas,
        );
      } else {
        return ResModel(
          success: false,
          mensaje: 'Áreas no encontradas',
        );
      }
    } catch (e) {
      return resfail;
    }
  }

  Future<ResModel> solicitarSala(Map info) async {
    try {
      // TRAEMOS TODOS LOS REGISTROS DE SOLICTUDES QUE SEAN DE LA MISMA SALA
      // COTEJAMOS QUE LA FECHA Y LA HORA NO SEA IGUAL

      // SI NO INTERFIERE, LO AGREGAMOS

      await realDB.reference().child('solicitudes').push().set(info);
      return ResModel(
        mensaje: 'Solicitud realizada',
        success: true,
      );
    } catch (e) {
      return resfail;
    }
  }
}