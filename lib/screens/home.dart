import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigea/models/models.dart';
import 'package:sigea/services/services.dart';
import 'package:sigea/values/themes.dart';
import 'package:sigea/values/values.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeDocentePage extends StatefulWidget {
  @override
  _HomeDocentePageState createState() => _HomeDocentePageState();
}

class _HomeDocentePageState extends State<HomeDocentePage> {
  Size? size;
  AppState? state;
  @override
  Widget build(BuildContext context) {
    print('ESTAMOS EN EL HOME:::::::::::::');
    this.size = MediaQuery.of(context).size;
    this.state = Provider.of<AppState>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          saludoTitle(this.state!.isUser.nombre!, this.state!.isUser.cargo!),
          // Divider(),
          BodyTable(),
          rowSimbologia(),
        ],
      ),
    );
  }

  Widget rowSimbologia() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.grey[200],
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                  border: Border.all(width: 0.5)),
            ),
            SizedBox(width: 10),
            Text("Futuras"),
            SizedBox(width: 10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: future,
                  border: Border.all(width: 0.5)),
            ),
            SizedBox(width: 10),
            Text("En curso"),
            SizedBox(width: 10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: curso,
                  border: Border.all(width: 0.5)),
            ),
            SizedBox(width: 10),
            Text("Actual"),
            SizedBox(width: 10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: pasada,
                  border: Border.all(width: 0.5)),
            ),
            SizedBox(width: 10),
            Text("Pasadas"),
          ],
        ),
      ),
    );
  }
}

class BodyTable extends StatelessWidget {
  AppState? state;

  @override
  Widget build(BuildContext context) {
    this.state = Provider.of<AppState>(context, listen: true);
    return FutureBuilder(
      future: this.state!.getSalasRegistradas(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        // return Container();
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Expanded(child: spinner());
          case ConnectionState.done:
            List<SolicitudModel> _solicitudes = snapshot.data ?? [];

            if (_solicitudes.isEmpty)
              return Expanded(
                child: Center(
                  child: Text('No hay salas apartadas'),
                ),
              );
            _solicitudes.sort((a, b) => b.fecha!.millisecondsSinceEpoch
                .compareTo(a.fecha!.millisecondsSinceEpoch));

            return Expanded(
                child: ListView.builder(
              itemCount: _solicitudes.length,
              itemBuilder: (BuildContext context, int index) {
                SolicitudModel item = _solicitudes[index];
                return Container(
                  color:
                      colorTime(item.fecha!, item.horaInicial, item.horaFinal),
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: ExpansionTile(
                    backgroundColor: colorTime(
                        item.fecha!, item.horaInicial, item.horaFinal),
                    collapsedTextColor: primaryGrey,
                    textColor: primaryBlack,
                    title: Text(item.nombre!),
                    subtitle: Text('Sala: ' + item.sala!.toString()),
                    children: [
                      ListTile(
                        onTap: () async {
                          String _url = item.urlSala ?? '';

                          try {
                            if (await canLaunch(_url)) {
                              print(
                                  'ABRIENDO URL.......'); // chrome no jala en el emulador
                              await launch(
                                _url,
                                forceSafariVC: false,
                                universalLinksOnly: true,
                              );
                            } else {
                              throw 'Could not launch $_url';
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        leading: Icon(Icons.video_call),
                        title: Text(item.urlSala!),
                      ),
                      ListTile(
                        leading: Icon(Icons.group),
                        title: Text(item.area!),
                      ),
                      ListTile(
                        leading: Icon(Icons.access_time),
                        title: Text(horaBonita(item.horaInicial!)),
                      ),
                      ListTile(
                        leading: Icon(Icons.access_time_filled),
                        title: Text(horaBonita(item.horaFinal!)),
                      ),
                      ListTile(
                        leading: Icon(Icons.calendar_today),
                        title: Text(fechaBonita(item.fecha!)),
                      ),
                      ListTile(
                        // leading: Icon(Icons.access_time_filled),
                        title: Text('Descripción:'),
                        subtitle: Text(item.descripcion!),
                      ),
                    ],
                  ),
                );
              },
            ));

          default:
            return TextFormField(
              enabled: false,
              decoration: InputDecoration(labelText: 'No hay Salas'),
            );
        }
      },
    );
  }

  colorTime(DateTime da, TimeOfDay? horaInicial, TimeOfDay? horaFinal) {
    Color cor = future;
    DateTime hoy = DateTime.now();
    if (da.year > hoy.year) {
      cor = future;
    } else if (da.year < hoy.year) {
      cor = pasada;
    } else if (da.year == hoy.year) {
      if (da.month > hoy.month) {
        cor = future;
      } else if (da.month < hoy.month) {
        cor = pasada;
      } else if (da.month == hoy.month) {
        if (da.day > hoy.day) {
          cor = future;
        } else if (da.day < hoy.day) {
          cor = pasada;
        } else if (da.day == hoy.day) {
          cor = actual; //ES hoy, es hoy

          if (horaInicial!.hour <= hoy.hour && horaFinal!.hour >= hoy.hour) {
            // if (horaFinal) {

            // }
            // if (horaInicial.minute <= hoy.minute &&
            //     horaFinal.minute >= hoy.minute) {
            cor = curso;
            // }
          }
        }
      }
    }

    return cor;
  }
}

class HomeAlumnoPage extends StatefulWidget {
  const HomeAlumnoPage({Key? key}) : super(key: key);

  @override
  _HomeAlumnoPageState createState() => _HomeAlumnoPageState();
}

class _HomeAlumnoPageState extends State<HomeAlumnoPage> {
  Size? size;
  AppState? state;
  @override
  Widget build(BuildContext context) {
    this.size = MediaQuery.of(context).size;
    this.state = Provider.of<AppState>(context, listen: true);

    return Scaffold(
      body: FutureBuilder<List<SalaModel>>(
        future: this.state!.getSalas(),
        builder:
            (BuildContext context, AsyncSnapshot<List<SalaModel>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return spinner();
            case ConnectionState.done:
              List<SalaModel> _salas = snapshot.data ?? [];
              _salas.sort((a, b) => a.numero!.compareTo(b.numero!));

              return GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  for (SalaModel item in _salas)
                    GestureDetector(
                      onTap: () async {
                        String _url = item.url ?? '';
                        try {
                          await launch(
                            _url,
                            forceSafariVC: false,
                            universalLinksOnly: true,
                          );
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Stack(
                          children: [
                            Positioned(
                              right: 0.0,
                              child: Icon(
                                Icons.open_in_new,
                                color: Colors.grey[400],
                              ),
                            ),
                            Container(
                              width: this.size!.width,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('SALA ' + item.numero.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                      )),
                                  Image.asset(
                                    'assets/images/logo_meet.png',
                                    height: this.size!.height * 0.08,
                                  ),
                                  Text('Google Meet',
                                      style: TextStyle(
                                        fontSize: 20,
                                      )),
                                  Text(
                                    item.url!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        color: Colors.grey[200],
                      ),
                    ),
                ],
              );
            default:
              return TextFormField(
                enabled: false,
                decoration: InputDecoration(labelText: 'No hay Salas'),
              );
          }
        },
      ),

      //  Column(children: [
      //   Text('data'),

      // ]),
    );
  }
}
