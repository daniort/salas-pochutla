import 'package:flutter/material.dart';
import 'package:sigea/values/themes.dart';

String horaBonita(TimeOfDay time) {
  // EVALUO SI LA HORA ES MENOR A 10,
  // LE CONCATENO UN 0 A LA IZQUIERDA,
  // SI ES MAYOR A CERO, NO LE PONGO NADA Y LO RETORNO

  int min = time.minute;
  if (min < 10) {
    if (time.hour < 10) {
      return "0${time.hour}:0${time.minute}";
    } else {
      return "${time.hour}:0${time.minute}";
    }
  }
  return "${time.hour}:${time.minute}";
}

String fechaBonita(DateTime date) {
  return "${date.day} / ${date.month} / ${date.year}";
}

// String cargoBonito(List<String> split) {
//   if (split.length > 3)
//     return split[0] + ' ' + split[1] + ' ' + split[2];
//   else
//     return split[0];
// }

saludoTitle(String s, String cargo) {
  String label = 'Buenos días';
  DateTime hoy = DateTime.now();

  if (hoy.hour > 0) {
    label = 'Buenos días';
  }

  if (hoy.hour > 12) {
    label = 'Buenas tardes';
  }

  if (hoy.hour > 17) {
    label = 'Buenas noches';
  }

  return Container(
    // color: Colors.amber[100],
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: RichText(
      text: TextSpan(
        style: TextStyle(color: textGrey),
        children: <TextSpan>[
          TextSpan(
              text: label + '\n',
              style: TextStyle(fontWeight: FontWeight.normal)),
          TextSpan(
            text: s + '\n',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          TextSpan(text: cargo.toUpperCase()),
        ],
      ),
    ),
  );

  // return Padding(
  //   padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
  //   child: Text(
  //     label + ',\n' + s,
  //     style: TextStyle(
  //         fontSize: 16,
  //         fontFamily: 'Roboto',
  //         fontWeight: FontWeight.bold,
  //         color: textGrey),
  //   ),
  // );
}

void snack(BuildContext context, String? mensaje, Color col) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: col,
      content: Text(
        mensaje ?? '',
        style: TextStyle(color: textGrey),
      ),
    ),
  );
}

Widget spinner() {
  return Center(
    child: SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        strokeWidth: 1,
        backgroundColor: Colors.white,
      ),
    ),
  );
}

InputDecoration inputDecora(String label) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    filled: true,
    hintStyle: TextStyle(color: textGreyLigth),
    fillColor: Colors.white,
    labelText: label,
  );
}
