import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigea/services/services.dart';
import 'package:sigea/values/themes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Size? size;
  AppState? state;
  @override
  Widget build(BuildContext context) {
    this.size = MediaQuery.of(context).size;
    this.state = Provider.of<AppState>(context, listen: true);
    if (!this.state!.isLogin) {
      // return pantalla con  la lista de evetos
      return Scaffold(
        backgroundColor: backgroudGrey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
              child: Text(
                'Salas registradas',
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    color: textGrey),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'add_solicitud');
                    },
                    child: Container(
                      height: this.size!.height * 0.15,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 0),
                              blurRadius: 5.0),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: primaryRed,
                      ),
                      child: Container(
                        margin: EdgeInsets.only(left: 5),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SOLICITUD DE SALAS',
                              style: TextStyle(
                                // fontSize: 25,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                                color: textRed,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Nueva solicitud de Sala',
                                    overflow: TextOverflow.clip,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold,
                                      color: textGrey,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Icon(
                                  Icons.notifications,
                                  color: borderGrey,
                                  size: 30,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: this.size!.height * 0.15,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 0),
                            blurRadius: 5.0),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: primaryRed,
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SOLICITUD DE ASESORÍAS REALIZADAS',
                            style: TextStyle(
                              // fontSize: 25,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              color: textRed,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  '3',
                                  overflow: TextOverflow.clip,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                    color: textGrey,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Icon(
                                Icons.notifications,
                                color: borderGrey,
                                size: 30,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    } else
      return Scaffold(
        backgroundColor: backgroudGrey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
              child: Text(
                'Buenas Tardes, Ruperto',
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    color: textGrey),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'add_solicitud');
                    },
                    child: Container(
                      height: this.size!.height * 0.15,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 0),
                              blurRadius: 5.0),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: primaryRed,
                      ),
                      child: Container(
                        margin: EdgeInsets.only(left: 5),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SOLICITUD DE SALAS',
                              style: TextStyle(
                                // fontSize: 25,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                                color: textRed,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Nueva solicitud de Sala',
                                    overflow: TextOverflow.clip,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold,
                                      color: textGrey,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Icon(
                                  Icons.notifications,
                                  color: borderGrey,
                                  size: 30,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: this.size!.height * 0.15,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0, 0),
                            blurRadius: 5.0),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: primaryRed,
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SOLICITUD DE ASESORÍAS REALIZADAS',
                            style: TextStyle(
                              // fontSize: 25,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              color: textRed,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  '3',
                                  overflow: TextOverflow.clip,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                    color: textGrey,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Icon(
                                Icons.notifications,
                                color: borderGrey,
                                size: 30,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
  }
}
