import 'package:flutter/material.dart';

class Utils {
  static const TextStyle textBold = TextStyle(fontWeight: FontWeight.bold);
  static const TextStyle textBoldBig =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0);
  static double percentajeToPx(double maxSize, double percentaje) =>
      maxSize * percentaje / 100;
  static String prepareCellphone(String cellPhone, prefix) {
    if (cellPhone.substring(0, 3).compareTo(prefix) == 0) return cellPhone;
    return "$prefix$cellPhone";
  }
}
