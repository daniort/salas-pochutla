import 'package:flutter/material.dart';
import 'package:sigea/models/models.dart';
import 'package:sigea/services/user_services.dart';

class AppState with ChangeNotifier {
  int _indexBody = 1;
  bool _login = false;
  bool _loading = false;
  UserModel? _user;
  ResModel resfail = ResModel(success: false, mensaje: 'Algo salió mal.');

  int get indexBody => this._indexBody;
  UserModel get isUser => this._user!;
  bool get isLoading => this._loading;

  bool get isLogin => this._login;

  void changeIndexBody(int i) {
    this._indexBody = i;
    notifyListeners();
  }

  void onLoading() {
    this._loading = true;
    notifyListeners();
  }

  void offLoading() {
    this._loading = false;
    notifyListeners();
  }

  Future<ResModel> login(String text, String text2) async {
    onLoading();
    try {
      ResModel _res = await UserServices().login(text, text2);
      if (_res.success!) {
        this._login = true;
        this._user = _res.data;
        notifyListeners();
      }
      offLoading();
      return _res;
    } catch (e) {
      offLoading();
      return resfail;
    }
  }

  void logout() {
    this._user = null;
    this._login = false;
    notifyListeners();
  }

  Future<List<SalaModel>> getSalas() async {
    try {
      ResModel _res = await UserServices().getSalas();
      if (_res.success!)
        return _res.data;
      else
        return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<AreaModel>> getAreas() async {
    try {
      ResModel _res = await UserServices().getAreas();
      if (_res.success!)
        return _res.data;
      else
        return [];
    } catch (e) {
      return [];
    }
  }

  Future<ResModel> solicitarArea(Map info) async {
    try {
      onLoading();
      ResModel _res = await UserServices().solicitarSala(info);
      offLoading();
      return _res;
    } catch (e) {
      offLoading();
      return resfail;
    }
  }
}
