import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigea/models/models.dart';
import 'package:sigea/services/services.dart';
import 'package:sigea/values/mydrop.dart';
import 'package:sigea/values/values.dart';

class AddSolicitudPage extends StatefulWidget {
  @override
  _AddSolicitudPageState createState() => _AddSolicitudPageState();
}

class _AddSolicitudPageState extends State<AddSolicitudPage> {
  SalaModel? dropdownSala;
  AreaModel? dropdownArea;

  TimeOfDay timeInicio = TimeOfDay.now();
  TimeOfDay timeFin = TimeOfDay.now();
  DateTime _dateSelected = DateTime.now();

  GlobalKey<FormState> _formsala = GlobalKey<FormState>();
  TextEditingController descripcion = TextEditingController();

  Future<TimeOfDay?> _selectTime(BuildContext context, TimeOfDay time) async {
    return await showTimePicker(
      context: context,
      initialTime: time,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? _datePicker = await showDatePicker(
      context: context,
      initialDate: this._dateSelected,
      firstDate: DateTime.now(),
      lastDate: DateTime(2023),
    );

    if (_datePicker != null) {
      this._dateSelected = _datePicker;
      setState(() {});
    }
  }

  Size? size;
  AppState? state;
  @override
  Widget build(BuildContext context) {
    this.size = MediaQuery.of(context).size;
    this.state = Provider.of<AppState>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('Solicitar Sala'),
      ),
      body: Form(
        key: _formsala,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              InputDecorator(
                decoration: inputDecora('Sala:'),
                child: FutureBuilder<List<SalaModel>>(
                  future: this.state!.getSalas(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<SalaModel>> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return spinner();
                      case ConnectionState.done:
                        List<SalaModel> salas = snapshot.data ?? [];
                        return CustomDropdown(
                          items: [
                            for (SalaModel item in salas)
                              CustomDropModel(
                                value: item,
                                label: 'Sala ' + item.numero.toString(),
                              ),
                          ],
                          constraints: BoxConstraints(
                            maxHeight: this.size!.height * 0.6,
                            minHeight: this.size!.height * 0.1,
                          ),
                          widthDropItem: this.size!.width - 40,
                          onSelected: (CustomDropModel val) {
                            print(val.label);
                            this.dropdownSala = val.value;
                            setState(() {});
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(salaBonita(this.dropdownSala)),
                              Icon(Icons.keyboard_arrow_down),
                            ],
                          ),
                        );

                      default:
                        return TextFormField(
                          enabled: false,
                          decoration:
                              InputDecoration(labelText: 'No hay Salas'),
                        );
                    }
                  },
                ),
                // child:
              ),
              SizedBox(height: 20),
              InputDecorator(
                decoration: inputDecora('Área:'),
                child: FutureBuilder<List<AreaModel>>(
                  future: this.state!.getAreas(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<AreaModel>> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return spinner();
                      case ConnectionState.done:
                        List<AreaModel> areas = snapshot.data ?? [];

                        return CustomDropdown(
                          items: [
                            for (AreaModel item in areas)
                              CustomDropModel(
                                value: item,
                                label: item.area!,
                              ),
                          ],
                          constraints: BoxConstraints(
                            maxHeight: this.size!.height * 0.6,
                            minHeight: this.size!.height * 0.1,
                          ),
                          widthDropItem: this.size!.width - 40,
                          onSelected: (CustomDropModel val) {
                            print(val.label);
                            this.dropdownArea = val.value;
                            setState(() {});
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              // Text('Sala: '),
                              Text(areaBonita(this.dropdownArea)),
                              Icon(Icons.keyboard_arrow_down),
                            ],
                          ),
                        );

                      default:
                        return TextFormField(
                          enabled: false,
                          decoration:
                              InputDecoration(labelText: 'No hay Áreas'),
                        );
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  TimeOfDay? pic = await _selectTime(context, this.timeInicio);
                  if (pic != null) {
                    print(pic.hourOfPeriod);
                    this.timeInicio = pic;
                    setState(() {});
                  }
                },
                child: InputDecorator(
                  decoration: inputDecora('Hora de inicio:'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(horaBonita(this.timeInicio)),
                      Icon(Icons.access_time),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  TimeOfDay? pic = await _selectTime(context, this.timeFin);
                  if (pic != null) {
                    this.timeFin = pic;
                    setState(() {});
                  }
                },
                child: InputDecorator(
                  decoration: inputDecora('Hora de fin:'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(horaBonita(this.timeFin)),
                      Icon(Icons.access_time),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: InputDecorator(
                  decoration: inputDecora('Fecha:'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(fechaBonita(this._dateSelected)),
                      Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: descripcion,
                maxLines: 3,
                decoration: inputDecora('Descripcion'),
                validator: (String? val) {
                  if (val!.isEmpty) {
                    return 'Debe ingresar una descripción';
                  }
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: this.size!.width * 0.40,
                    child: ElevatedButton(
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
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: this.size!.width * 0.40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(primaryRed),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 50),
                        ),
                      ),
                      onPressed: () async {
                        if (this.dropdownSala == null) {
                          snack(context, 'Debes seleccionar una sala',
                              secundaryRed);
                          return;
                        }
                        if (this.dropdownArea == null) {
                          snack(context, 'Debes seleccionar un área',
                              secundaryRed);
                          return;
                        }

                        print(this.timeFin.hour.compareTo(this.timeFin.hour));
                        if (!horasValidas(this.timeFin, this.timeFin.hour)) {
                          snack(context, 'Solo puedes apartar 2 horas máximo.',
                              secundaryRed);
                          return;
                        }
                        DateTime hoy = DateTime.now();

                        print(hoy);
                        print(this._dateSelected);

                        if (hoy.year == this._dateSelected.year &&
                            hoy.month == this._dateSelected.month &&
                            hoy.day == this._dateSelected.day) {
                          print('SI ES HOY!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
                          print(horasActual(this.timeInicio));
                          if (!horasActual(this.timeInicio)) {
                            snack(context, 'Seleciona una hora válida.',
                                secundaryRed);
                            return;
                          }
                        }

                        if (this._formsala.currentState!.validate()) {
                          Map info = {
                            "nombre": this.state!.isUser.nombre,
                            "idsala": this.dropdownSala!.key,
                            "urlsala": this.dropdownSala!.url,
                            "idarea": this.dropdownArea!.key,
                            "sala": this.dropdownSala!.numero,
                            "area": this.dropdownArea!.area,
                            "hora_inicial":
                                "${this.timeInicio.hour}:${this.timeInicio.minute}",
                            "hora_final":
                                "${this.timeFin.hour}:${this.timeFin.minute}",
                            "fecha": this._dateSelected.millisecondsSinceEpoch,
                            "descripcion": this.descripcion.text,
                          };

                          ResModel _res = await this.state!.solicitarArea(
                              info,
                              this._dateSelected,
                              this.timeInicio,
                              this.timeFin);

                          if (_res.success!) {
                            snack(
                                context, 'Solicitud Aprobada', secundaryGreen);
                            Navigator.pop(context);
                          } else {
                            snack(context, _res.mensaje!, secundaryRed);
                          }
                        }
                      },
                      child:
                          this.state!.isLoading ? spinner() : Text('Solicitar'),
                    ),
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

  Container mensajeForm() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: borderGrey,
      ),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: RichText(
        text: TextSpan(
            style: TextStyle(color: textGrey, fontSize: 12),
            children: [
              TextSpan(
                text:
                    '- Elige el espacio y la fecha para ver los horarios ocupados.\n',
              ),
              TextSpan(
                text: '- Solo puedes apartar 2 horas máximo.\n',
              ),
              TextSpan(
                text:
                    '- El número de asistentes (incluyendote) no debe exceder la capacidad del espacio que selecciones.',
              ),
            ]),
      ),
    );
  }

  String salaBonita(SalaModel? dro) {
    if (dro != null) {
      return 'SALA ' + dro.numero.toString();
    }
    return 'SELECIONA UNA SALA';
  }

  String areaBonita(AreaModel? are) {
    if (are != null) {
      return are.area ?? 'SELECCIONA UN ÁREA';
    }
    return 'SELECCIONA UN ÁREA';
  }

  bool horasValidas(TimeOfDay timeFin, int hour) {
    double _doubleYourTime =
        this.timeFin.hour.toDouble() + (this.timeFin.minute.toDouble() / 60);
    double _doubleNowTime = this.timeInicio.hour.toDouble() +
        (this.timeInicio.minute.toDouble() / 60);
    double _timeDiff = _doubleYourTime - _doubleNowTime;
    int _hr = _timeDiff.truncate();
    double _minute = (_timeDiff - _timeDiff.truncate()) * 60;

    print('Here your Happy $_hr Hour and also $_minute min');

    if (_hr <= 2 && _hr >= 0) {
      if (_hr == 2 && _minute > 0.0)
        return false;
      else
        return true;
    } else
      return false;
  }

  bool horasActual(TimeOfDay time) {
    DateTime hoy = DateTime.now();

    if (time.hour == hoy.hour) {
      print('ES A LA MISMA HORA');
      if (time.minute > hoy.minute) {
        print('el minuto es mayor');

        return true;
      } else {
        return false;
      }
    } else if (time.hour > hoy.hour) {
      return true;
    } else {
      return false;
    }
  }
}
