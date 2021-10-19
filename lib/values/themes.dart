import 'package:flutter/material.dart';

const Color primaryBlack = Color.fromRGBO(0, 0, 0, 1);
const Color primaryRed = Color.fromRGBO(108, 35, 59, 1);
const Color primaryGreen = Color.fromRGBO(50, 90, 79, 1);
const Color primaryGrey = Color.fromRGBO(53, 58, 63, 1);
const Color primaryBlue = Color.fromRGBO(51, 114, 246, 1);
const Color primaryGold = Color.fromRGBO(209, 194, 160, 1);

const Color secundaryRed = Color.fromRGBO(246, 220, 217, 1);
const Color tercaryRed = Color.fromRGBO(152, 101, 118, 1);
const Color secundaryGreen = Color.fromRGBO(218, 243, 233, 1);
const Color secundaryGrey = Color.fromRGBO(231, 231, 234, 1);
const Color secundaryBrown = Color.fromRGBO(171, 154, 152, 1);
const Color secundaryBlue = Color.fromRGBO(187, 221, 246, 1);

const Color borderGrey = Color.fromRGBO(228, 230, 239, 1);
const Color backgroudGrey = Color.fromRGBO(248, 249, 252, 1);

const Color textGrey = Color.fromRGBO(91, 92, 104, 1);
const Color textRed = Color.fromRGBO(108, 35, 59, 1);
const Color textGreyLigth = Color.fromRGBO(133, 135, 149, 1);

ThemeData primaryTheme(BuildContext context) {
  return ThemeData(
    primaryColor: primaryRed,
    accentColor: primaryRed,
    primarySwatch: Colors.red,
    highlightColor: Colors.indigo,
    focusColor: Colors.purple,
    hintColor: Colors.grey,
    cardColor: Colors.green,
  );
}
