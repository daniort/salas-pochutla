import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigea/models/models.dart';
import 'package:sigea/services/services.dart';
import 'package:sigea/values/values.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  Size? size;
  AppState? state;
  @override
  Widget build(BuildContext context) {
    this.size = MediaQuery.of(context).size;
    this.state = Provider.of<AppState>(context, listen: true);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'add_user');
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: this.state!.getUsers(),
        builder:
            (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return spinner();
            case ConnectionState.done:
              List<UserModel> _users = snapshot.data ?? [];

              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20),
                    child: Text(
                      'Usuarios en Sistema',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          color: textGrey),
                    ),
                  ),
                  for (UserModel sala in _users)
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: ExpansionTile(
                        // initiallyExpanded: true,
                        title: Text(sala.nombre!),
                        subtitle: Text(sala.cargo!),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          primaryGold),
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(horizontal: 10),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, 'edit_user');
                                },
                                child: Text('Editar'),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          primaryGrey),
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(horizontal: 10),
                                  ),
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Eliminar usuario'),
                                          content: Text(
                                            'Está seguro de eliminar el usuario: \n' +
                                                sala.nombre!,
                                          ),
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
                                                        .removeUser(sala.key!);

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
                        // trailing: Icon(Icons.open_in_new, color: Colors.grey),
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
    );
  }
}
