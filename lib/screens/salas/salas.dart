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
                    ListTile(
                      title: Text('SALA ' + sala.numero.toString()),
                      subtitle: Text(sala.url!),
                      trailing: Icon(Icons.open_in_new, color: Colors.grey),
                      onTap: () async {
                        String _url = sala.url ?? '';
                        if (await canLaunch(_url)) {
                          await launch(
                            _url,
                            forceSafariVC: false,
                            universalLinksOnly: true,
                          );
                        }
                      },
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
