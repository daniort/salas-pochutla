import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigea/models/models.dart';
import 'package:sigea/services/services.dart';
import 'package:sigea/values/values.dart';

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  GlobalKey<FormState> _formsala = GlobalKey<FormState>();
  TextEditingController nombreController = TextEditingController();
  TextEditingController cargoController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  Size? size;
  AppState? state;
  bool obcured = true;

  @override
  void dispose() {
    this.nombreController.dispose();
    this.cargoController.dispose();
    this.usernameController.dispose();
    this.passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    this.size = MediaQuery.of(context).size;
    this.state = Provider.of<AppState>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Usuario'),
      ),
      body: Form(
        key: _formsala,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              TextFormField(
                controller: nombreController,
                maxLines: 1,
                decoration: inputDecora('Nombre completo'),
                validator: (String? val) {
                  if (val!.isEmpty) {
                    return 'Debe ingresar un nombre';
                  }
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: cargoController,
                maxLines: 1,
                decoration: inputDecora('Cargo'),
                validator: (String? val) {
                  if (val!.isEmpty) {
                    return 'Debe ingresar un cargo';
                  }
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: usernameController,
                maxLines: 1,
                decoration: inputDecora('Nombre de usuario'),
                validator: (String? val) {
                  if (val!.isEmpty) {
                    return 'Debe ingresar un nombre de usaurios';
                  }
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passController,
                maxLines: 1,
                obscureText: this.obcured,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(this.obcured ? Icons.lock : Icons.lock_open),
                    onPressed: () {
                      this.obcured = !this.obcured;
                      setState(() {});
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: textGreyLigth),
                  fillColor: Colors.white,
                  labelText: 'Contrase??a',
                ),
                validator: (String? val) {
                  if (val!.isEmpty) {
                    return 'Debe ingresar una contrase??a';
                  }
                  if (val.length < 8) {
                    return 'La contrase??a es muy corta.';
                  }
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(primaryGrey),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 50),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(primaryRed),
                    ),
                    onPressed: () async {
                      if (this._formsala.currentState!.validate()) {
                        Map info = {
                          "cargo": this.cargoController.text.toUpperCase(),
                          "nombre": this.nombreController.text.toUpperCase(),
                          "firma": this.passController.text,
                          "user": this.usernameController.text,
                        };
                        ResModel _res =
                            await this.state!.agregarNuevaUsuario(info);
                        if (_res.success!) {
                          Navigator.pop(context);
                          snack(context, 'Usuario Agregado', secundaryGreen);
                        } else {
                          snack(context, _res.mensaje!, secundaryRed);
                        }
                      }
                    },
                    child: this.state!.isLoading ? spinner() : Text('Agregar'),
                  ),
                ],
              ),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
