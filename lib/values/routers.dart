import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigea/main.dart';
import 'package:sigea/screens/home.dart';
import 'package:sigea/screens/screens.dart';
import 'package:sigea/services/services.dart';

Map<String, Widget Function(BuildContext)> rutas(BuildContext context) {
  return {
    "/": (BuildContext context) {
      final _state = Provider.of<AppState>(context, listen: true);
      print("ESTAMOS EN LOGIN????:::::");
      print(_state.isLogin);
      if (_state.isLogin) {
        return Home();
      } else {
        return LoginPage();
      }
    },
    'add_user': (_) => AddUserPage(),
    'edit_user': (_) => EditUserPage(),
    'add_sala': (_) => AddSalaPage(),
    'add_solicitud': (_) => AddSolicitudPage(),
    'login': (_) => LoginPage(),
    // 'recuperar-enviada': (_) => RecuperacionEnviada(),
    // 'nuevo-dispo': (_) => NuevoDispo(),
    // 'tutorial': (_) => TutorialPage(),
    // 'checkout': (_) => CheckOutPage(),
    // 'nueva-compra': (_) => NuevaCompra(),
  };
}
