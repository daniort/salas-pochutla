import 'package:flutter/material.dart';
import 'package:sigea/screens/screens.dart';

Map<String, Widget Function(BuildContext)> rutas(BuildContext context) {
  return {
    // "/": (BuildContext context) {
    //   final _state = Provider.of<LoginState>(context, listen: true);
    //   if (_state.isSplash()) {
    //     return SplashScreen();
    //   } else if (_state.islogin()) {
    //     return MyHomePage(id: _state.isidUser());
    //   } else {
    //     return HomePageInvitado();
    //     // return LoginScreen();
    //   }
    // },
    'add_user': (_) => AddUserPage(),
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
