import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigea/models/models.dart';
import 'package:sigea/services/appstate.dart';
import 'package:sigea/values/themes.dart';
import 'package:sigea/values/values.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  Size? size;
  AppState? state;
  @override
  Widget build(BuildContext context) {
    this.size = MediaQuery.of(context).size;
    this.state = Provider.of<AppState>(context, listen: true);
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Image.asset(
                'assets/images/logotec.png',
                height: this.size!.height * 0.2,
              ),
              SizedBox(height: 10),
              Text('¡Bienvenido!',
                  style: TextStyle(
                    fontSize: 25,
                    color: textGrey,
                  )),
              SizedBox(height: 20),
              TextFormField(
                controller: user,
                decoration: inputDecora('Ingresa tu usuario'),
                validator: (String? val) {
                  if (val!.isEmpty) return 'Ingrese su usuario';
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: pass,
                obscureText: true,
                decoration: inputDecora('Clave'),
                validator: (String? val) {
                  if (val!.isEmpty) return 'Ingrese su clave';
                },
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    ResModel res =
                        await this.state!.login(user.text, pass.text);
                    if (!res.success!)
                      snack(context, res.mensaje, secundaryRed);
                  }
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: this.size!.height * 0.07,
                  decoration: BoxDecoration(
                    color: primaryRed,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: this.state!.isLoading
                      ? spinner()
                      : Center(
                          child: Text('Iniciar sesión',
                              style: TextStyle(
                                color: Colors.white,
                              )),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
