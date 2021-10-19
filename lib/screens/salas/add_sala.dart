import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigea/models/models.dart';
import 'package:sigea/services/services.dart';
import 'package:sigea/values/values.dart';

class AddSalaPage extends StatefulWidget {
  @override
  _AddSalaPageState createState() => _AddSalaPageState();
}

class _AddSalaPageState extends State<AddSalaPage> {
  GlobalKey<FormState> _formsala = GlobalKey<FormState>();
  TextEditingController numero = TextEditingController();
  TextEditingController url = TextEditingController();

  Size? size;
  AppState? state;

  @override
  void dispose() {
    this.numero.dispose();
    this.url.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    this.size = MediaQuery.of(context).size;
    this.state = Provider.of<AppState>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Sala'),
      ),
      body: Form(
        key: _formsala,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              TextFormField(
                controller: numero,
                maxLines: 1,
                keyboardType: TextInputType.number,
                decoration: inputDecora('Número de Sala'),
                validator: (String? val) {
                  if (val!.isEmpty) {
                    return 'Debe ingresar un número';
                  }
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: url,
                maxLines: 1,
                decoration: inputDecora('Url'),
                validator: (String? val) {
                  if (val!.isEmpty) {
                    return 'Debe ingresar una url';
                  }
                },
              ),
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
                          "numero": int.parse(this.numero.text),
                          "url": this.url.text,
                        };
                        ResModel _res =
                            await this.state!.agregarNuevaSala(info);
                        if (_res.success!) {
                          snack(context, 'Sala Agregada', secundaryGreen);
                          Navigator.pop(context);
                        } else {
                          snack(context, _res.mensaje!, secundaryRed);
                        }
                      }
                    },
                    child:
                        this.state!.isLoading ? spinner() : Text('Solicitar'),
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
