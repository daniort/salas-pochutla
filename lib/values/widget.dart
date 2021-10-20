import 'package:flutter/material.dart';
import 'package:sigea/values/themes.dart';

String horaBonita(TimeOfDay time) {
  return "${time.hour}:${time.minute}";
}

String fechaBonita(DateTime date) {
  return "${date.day} / ${date.month} / ${date.year}";
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
