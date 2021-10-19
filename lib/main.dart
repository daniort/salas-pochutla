import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sigea/screens/home.dart';
import 'package:sigea/screens/screens.dart';
import 'package:sigea/services/services.dart';
import 'package:sigea/values/themes.dart';
import 'package:sigea/values/values.dart';
import 'package:sigea/values/variables.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider<AppState>(
      create: (BuildContext context) => AppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Salas App',
        theme: primaryTheme(context),
        routes: rutas(context),
        initialRoute: '/',
        // home: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  AppState? state;
  @override
  Widget build(BuildContext context) {
    this.state = Provider.of<AppState>(context, listen: true);

    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(
            'SALAS',
            style: TextStyle(fontFamily: 'Roboto'),
          ),
          actions: [
            // IconButton(
            //     onPressed: () async {
            //       for (String item in areas) {
            //         await UserServices().addAreas({'area': item});
            //       }
            //     },
            //     icon: Icon(Icons.add)),
            if (this.state!.isLogin)
              Center(
                child: Text(this.state!.isUser.cargo ?? ''),
              ),
            if (this.state!.isLogin)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'assets/images/image.jpeg',
                    ),
                  ),
                ),
              ),
          ],
        ),
        body: MyBody());
  }
}

class MyBody extends StatefulWidget {
  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  Size? size;
  AppState? state;
  @override
  Widget build(BuildContext context) {
    this.state = Provider.of<AppState>(context, listen: true);
    this.size = MediaQuery.of(context).size;

    switch (this.state!.tipoUser.toUpperCase()) {
      case 'DOCENTE':
        return HomeDocentePage();
      case 'ALUMNO':
        return HomeAlumnoPage();
      case 'ADMIN':
        switch (this.state!.indexBody) {
          case 1:
            return HomeDocentePage();
          case 2:
            return UsuariosPage();
          case 3:
            return SalasPage();
          default:
            return HomeDocentePage();
        }
      default:
        return HomeDocentePage();
    }
  }
}

class MyDrawer extends StatelessWidget {
  static const TextStyle styleDrawer = TextStyle(color: Colors.white);
  Size? size;
  AppState? state;
  @override
  Widget build(BuildContext context) {
    this.state = Provider.of<AppState>(context, listen: true);
    this.size = MediaQuery.of(context).size;

    switch (this.state!.tipoUser.toUpperCase()) {
      case 'DOCENTE':
        return drawerDocente(context);
      case 'ALUMNO':
        return drawerAlumno(context);
      case 'ADMIN':
        return drawerAdmin(context);
      default:
        return drawerDocente(context);
    }
  }

  Widget drawerAdmin(BuildContext context) {
    return Drawer(
      child: Container(
        color: primaryRed,
        child: Column(
          children: [
            headerDrawer(),
            Divider(color: tercaryRed),
            ListTile(
              dense: true,
              focusColor: Colors.yellow,
              leading: Icon(Icons.home, color: tercaryRed),
              title: const Text(
                'Inicio',
                style: styleDrawer,
              ),
              onTap: () {
                Navigator.pop(context);
                this.state!.changeIndexBody(1);
              },
            ),
            Divider(color: tercaryRed),
            ListTile(
              dense: true,
              focusColor: Colors.yellow,
              leading: Icon(Icons.person, color: tercaryRed),
              title: const Text(
                'Usuarios',
                style: styleDrawer,
              ),
              onTap: () {
                Navigator.pop(context);
                this.state!.changeIndexBody(2);
              },
            ),
            ListTile(
              dense: true,
              focusColor: Colors.yellow,
              leading: Icon(Icons.location_city, color: tercaryRed),
              title: const Text(
                'Salas',
                style: styleDrawer,
              ),
              onTap: () {
                Navigator.pop(context);
                this.state!.changeIndexBody(3);
              },
            ),
            Divider(color: tercaryRed),
            tileCerrarSesion(),
            Expanded(child: SizedBox()),
            btnClose(context),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  InkWell btnClose(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: tercaryRed,
        ),
        // margin: EdgeInsets.only(bottom: 50),
        padding: EdgeInsets.all(10),
        child: Icon(
          Icons.keyboard_arrow_left,
          color: Colors.white,
        ),
      ),
    );
  }

  ListTile tileCerrarSesion() {
    return ListTile(
      dense: true,
      focusColor: Colors.yellow,
      leading: Icon(Icons.exit_to_app, color: tercaryRed),
      title: const Text(
        'Cerrar Sesíon',
        style: styleDrawer,
      ),
      onTap: () {
        this.state!.logout();
      },
    );
  }

  Widget drawerDocente(BuildContext context) {
    return Drawer(
      child: Container(
        color: primaryRed,
        child: Column(
          children: [
            headerDrawer(),
            Divider(color: tercaryRed),
            ListTile(
              dense: true,
              focusColor: Colors.yellow,
              leading: Icon(Icons.home, color: tercaryRed),
              title: const Text(
                'Inicio',
                style: styleDrawer,
              ),
              onTap: () {
                this.state!.changeIndexBody(1);
                Navigator.pop(context);
              },
            ),
            Divider(color: tercaryRed),
            ListTile(
              dense: true,
              focusColor: Colors.yellow,
              leading: Icon(Icons.login, color: tercaryRed),
              title: const Text(
                'Iniciar Sesíon',
                style: styleDrawer,
              ),
              onTap: () {
                Navigator.pushNamed(context, 'login');
                // Naviagr
                //   Navigator.pushNamedAndRemoveUntil(
                //       context, 'add_user', (route) => false);
              },
            ),
            Expanded(child: SizedBox()),
            btnClose(context),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Container headerDrawer() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 50),
          Image.asset(
            'assets/images/logotec.png',
            height: this.size!.height * 0.1,
          ),
          SizedBox(height: 20),
          Text(
            // "SIGEA",
            'SISTEMA DE GESTIÓN DE SALAS VIRTUALES',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Roboto',
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget drawerAlumno(BuildContext context) {
    return Drawer(
      child: Container(
        color: primaryRed,
        child: Column(
          children: [
            headerDrawer(),
            Divider(color: tercaryRed),
            ListTile(
              dense: true,
              focusColor: Colors.yellow,
              leading: Icon(Icons.home, color: tercaryRed),
              title: const Text(
                'Inicio',
                style: styleDrawer,
              ),
              onTap: () {
                this.state!.changeIndexBody(1);
              },
            ),
            Divider(color: tercaryRed),
            ListTile(
              dense: true,
              focusColor: Colors.yellow,
              leading: Icon(Icons.add, color: tercaryRed),
              title: const Text(
                'Agregar Solicitud',
                style: styleDrawer,
              ),
              onTap: () {
                print('object');
              },
            ),
            ListTile(
              dense: true,
              focusColor: Colors.yellow,
              leading: Icon(Icons.history, color: tercaryRed),
              title: const Text(
                'Solicitudes realizadas',
                style: styleDrawer,
              ),
              onTap: () {
                print('object');
              },
            ),
            Divider(color: tercaryRed),
            ListTile(
              dense: true,
              focusColor: Colors.yellow,
              leading: Icon(Icons.person, color: tercaryRed),
              title: const Text(
                'Usuarios',
                style: styleDrawer,
              ),
              onTap: () {},
            ),
            ListTile(
              dense: true,
              focusColor: Colors.yellow,
              leading: Icon(Icons.location_city, color: tercaryRed),
              title: const Text(
                'Espacios',
                style: styleDrawer,
              ),
              onTap: () {
                print('object');
              },
            ),
            Divider(color: tercaryRed),
            ListTile(
              dense: true,
              focusColor: Colors.yellow,
              leading: Icon(Icons.exit_to_app, color: tercaryRed),
              title: const Text(
                'Cerrar Sesíon',
                style: styleDrawer,
              ),
              onTap: () {
                print('object');
              },
            ),
            Expanded(child: SizedBox()),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: tercaryRed,
                ),
                // margin: EdgeInsets.only(bottom: 50),
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget drawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: primaryRed,
        child: Column(
          children: [
            headerDrawer(),

            Divider(color: tercaryRed),
            tileCerrarSesion(),
            Expanded(child: SizedBox()),
            // btnClose(context),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
