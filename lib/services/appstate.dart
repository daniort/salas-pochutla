import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigea/models/models.dart';
import 'package:sigea/services/user_services.dart';

class AppState with ChangeNotifier {
  int _indexBody = 1;
  bool _login = false;
  bool _loading = false;
  String _tipeUser = 'invitado';
  UserModel? _user;
  SharedPreferences? _prefs;
  ResModel resfail = ResModel(success: false, mensaje: 'Algo salió mal.');

  int get indexBody => this._indexBody;
  String get tipoUser => this._tipeUser;
  // ?? this._prefs!.getString('id_user');
  UserModel get isUser => this._user!;
  bool get isLoading => this._loading;
  bool get isLogin => this._login;

  AppState() {
    appLogin();
  }

  void appLogin() async {
    this._prefs = await SharedPreferences.getInstance();
    if (this._prefs!.containsKey('login')) {
      print('si existe LA KEY  LOGIN');
      this._user = await getUserData(this._prefs!.getString('id_user'));
      if (this._user != null) {
        this._login = true;
        notifyListeners();
      } else {
        print('NO LOGIN');
        this._login = false;
        notifyListeners();
      }
    } else {
      print('NO LOGIN');
      this._login = false;
      notifyListeners();
    }
  }

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
        this._prefs!.setBool('login', true);
        this._prefs!.setString('id_user', this._user!.key!);
        this._prefs!.setString('cargo', this._user!.cargo!);
        this._tipeUser = this._user!.cargo!;
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

  List<SolicitudModel> salasRegistradas = [];
  Future<List<SolicitudModel>> getSalasRegistradas() async {
    try {
      print('ahors que pasaY');
      ResModel _res = await UserServices().getSalasRegistradas();
      if (_res.success!) {
        print('SI HAY SI HAY');
        this.salasRegistradas = _res.data!;
        return this.salasRegistradas;
      } else {
        print('NO HAY, NO HAY');

        return this.salasRegistradas;
      }
    } catch (e) {
      offLoading();
      return this.salasRegistradas;
    }
  }

  getUserData(String? string) async {
    try {
      ResModel res = await UserServices().getUserData(string!);
      if (res.success!) {
        return res.data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ResModel> agregarNuevaSala(Map info) async {
    try {
      onLoading();
      ResModel _res = await UserServices().addNuevaSala(info);
      offLoading();
      return _res;
    } catch (e) {
      offLoading();
      return resfail;
    }
  }

  Future<List<UserModel>> getUsers() async {
    try {
      ResModel _res = await UserServices().getUsers();
      if (_res.success!)
        return _res.data;
      else
        return [];
    } catch (e) {
      return [];
    }
  }
}
