import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigea/models/models.dart';
import 'package:sigea/services/services.dart';
import 'package:sigea/values/values.dart';
import 'package:url_launcher/url_launcher.dart';

class SalasPage extends StatefulWidget {
  @override
  _SalasPageState createState() => _SalasPageState();
}

class _SalasPageState extends State<SalasPage> {
  Size? size;
  AppState? state;
  @override
  Widget build(BuildContext context) {
    this.size = MediaQuery.of(context).size;
    this.state = Provider.of<AppState>(context, listen: true);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'add_sala');
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<SalaModel>>(
        future: this.state!.getSalas(),
        builder:
            (BuildContext context, AsyncSnapshot<List<SalaModel>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return spinner();
            case ConnectionState.done:
              List<SalaModel> _salas = snapshot.data ?? [];

              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20),
                    child: Text(
                      'Salas en Sistema',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          color: textGrey),
                    ),
                  ),
                  for (SalaModel sala in _salas)
                    ExpansionTile(
                      title: Text('SALA ' + sala.numero.toString()),
                      subtitle: Text(sala.url!),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 10),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        primaryGrey),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.symmetric(horizontal: 10),
                                ),
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Eliminar sala'),
                                        content: Text(
                                            'Está seguro de eliminar la Sala ' +
                                                sala.numero!.toString()),
                                        actions: [
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(primaryGrey),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsets>(
                                                EdgeInsets.symmetric(
                                                    horizontal: 10),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Cancelar',
                                            ),
                                          ),
                                          ElevatedButton(
                                            child: Text('Eliminar'),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(primaryRed),
                                              padding: MaterialStateProperty
                                                  .all<EdgeInsets>(
                                                EdgeInsets.symmetric(
                                                    horizontal: 10),
                                              ),
                                            ),
                                            onPressed: () async {
                                              ResModel res =
                                                  await UserServices()
                                                      .removeSala(sala.key!);

                                              Navigator.pop(context);
                                              snack(
                                                context,
                                                res.mensaje!,
                                                res.success!
                                                    ? secundaryGreen
                                                    : secundaryRed,
                                              );
                                              setState(() {});
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Text('Eliminar'),
                            ),
                            SizedBox(width: 20)
                          ],
                        )
                      ],

                      // onTap: () async {
                      //   String _url = sala.url ?? '';
                      //   if (await canLaunch(_url)) {
                      //     await launch(
                      //       _url,
                      //       forceSafariVC: false,
                      //       universalLinksOnly: true,
                      //     );
                      //   }
                      // },
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
    );
  }
}
