import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sigea/models/models.dart';
import 'package:sigea/models/res.dart';
import 'package:sigea/models/user.dart';

class UserServices {
  // final _db = new DataBase();
  final FirebaseDatabase realDB = new FirebaseDatabase();
  DataSnapshot? snap;
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
    try {
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
    } catch (e) {
      print('ERROR EN LOGIN USER SERVICES');
      print(e);
      return resfail;
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

  Future<ResModel> solicitarSala(
      Map info, DateTime date, TimeOfDay ini, TimeOfDay fin) async {
    try {
      this.snap = await realDB
          .reference()
          .child('solicitudes')
          .orderByChild('idsala')
          .equalTo(info['idsala'])
          .once();

      List<SolicitudModel> _sol = [];

      this.snap!.value.forEach((key, val) {
        Map _data = Map.from(val);
        _data['key'] = key;
        _sol.add(SolicitudModel.fromJson(_data));
      });

      bool _permiso = false;
      TimeOfDay fini = ini;
      TimeOfDay ffin = fin;

      for (SolicitudModel soli in _sol) {
        if (soli.fecha!.year == date.year &&
            soli.fecha!.month == date.month &&
            soli.fecha!.day == date.month) {
          fini = TimeOfDay(
              hour: int.parse(soli.horaInicial!.split(":")[0]),
              minute: int.parse(soli.horaInicial!.split(":")[1]));
          ffin = TimeOfDay(
              hour: int.parse(soli.horaFinal!.split(":")[0]),
              minute: int.parse(soli.horaFinal!.split(":")[1]));

          if (fini.hour > ini.hour) {
            if (ffin.hour > fin.hour) {
              _permiso = true;
            } else {
              _permiso = false;
            }
          } else if (ffin.hour > ini.hour) {
            _permiso = false;
          } else {
            _permiso = true;
          }

          if (fini.hour == ini.hour) {
            _permiso = false;
          }
        }
      }

      if (_permiso) {
        await realDB.reference().child('solicitudes').push().set(info);
        return ResModel(
          mensaje: 'Solicitud realizada',
          success: true,
        );
      } else {
        return ResModel(
            success: false,
            mensaje: 'Esta sala estará ocupada en la hora seleccionada.');
      }
    } catch (e) {
      return resfail;
    }
  }

  Future<ResModel> getSalasRegistradas() async {
    try {
      List<SolicitudModel> _solicitudes = [];
      this.snap = await realDB.reference().child('solicitudes').once();

      if (this.snap!.exists) {
        this.snap!.value.forEach((key, val) {
          Map _data = Map.from(val);
          _data['key'] = key;
          _solicitudes.add(SolicitudModel.fromJson(_data));
        });
        return ResModel(
          success: true,
          data: _solicitudes,
        );
      } else {
        return ResModel(
          success: false,
          mensaje: 'Áreas no encontradas',
        );
      }
    } catch (e) {
      print('NO SE ENCUENTRAN SOLICITUDES');
      print(e);
      return resfail;
    }
  }

  Future<ResModel> getUserData(String keyr) async {
    try {
      this.snap = await realDB.reference().child('users').child(keyr).once();

      if (this.snap!.exists) {
        Map data = {};
        this.snap!.value.forEach((key, val) {
          data = Map.from(val);
          data['key'] = keyr;
        });

        return ResModel(
          success: true,
          data: data,
        );
      } else {
        return ResModel(
          success: false,
          data: null,
        );
      }
    } catch (e) {
      return resfail;
    }
  }

  Future<ResModel> addNuevaSala(Map info) async {
    try {
      DataSnapshot asi = await realDB
          .reference()
          .child('salas')
          .orderByChild('numero')
          .equalTo(info['numero'])
          .once();
      if (asi.exists) {
        return ResModel(
          mensaje: "Ya existe una Sala ${info['numero']}",
          success: false,
        );
      } else {
        await realDB.reference().child('salas').push().set(info);
        return ResModel(
          mensaje: 'Sala agregada',
          success: true,
        );
      }
    } catch (e) {
      return resfail;
    }
  }

  Future<ResModel> getUsers() async {
    try {
      DataSnapshot asi = await realDB.reference().child('users').once();
      if (asi.exists) {
        List<UserModel> usaurios = [];
        asi.value.forEach((key, val) {
          Map _data = Map.from(val);
          _data['key'] = key;
          usaurios.add(UserModel.fromJson(_data));
        });
        return ResModel(
          success: true,
          data: usaurios,
        );
      } else {
        return ResModel(
          success: false,
          mensaje: 'Usuarios no encontrados',
        );
      }
    } catch (e) {
      print(e);
      return resfail;
    }
  }

  Future<ResModel> removeUser(String s) async {
    try {
      await realDB.reference().child('users').child(s).remove();
      return ResModel(success: true, mensaje: "Usuario eliminado");
    } catch (e) {
      return resfail;
    }
  }

  Future<ResModel> addNuevaUser(Map info) async {
    try {
      await realDB.reference().child('users').push().set(info);
      return ResModel(
        mensaje: 'Usuario agregado',
        success: true,
      );
    } catch (e) {
      return resfail;
    }
  }

  Future<ResModel> updateUser(Map<String, dynamic> info, String key) async {
    try {
      await realDB.reference().child('users').child(key).update(info);
      return ResModel(
        mensaje: 'Usuario actualizado',
        success: true,
      );
    } catch (e) {
      return resfail;
    }
  }

  Future<ResModel> removeSala(String s) async {
    try {
      await realDB.reference().child('salas').child(s).remove();
      return ResModel(success: true, mensaje: "Sala eliminada");
    } catch (e) {
      return resfail;
    }
  }
}
