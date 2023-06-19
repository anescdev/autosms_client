import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/message_model.dart';
import '../theme/custom_color.g.dart';

class Utils {
  static final CustomColors extension = Get.theme.extension<CustomColors>()!;
  static const TextStyle textBold = TextStyle(fontWeight: FontWeight.bold);
  static const TextStyle textBoldBig =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0);
  static String formatDate(DateTime dateTime, bool showTime) {
    return "${dateTime.day < 10 ? 0 : ""}${dateTime.day} - ${dateTime.month < 10 ? 0 : ""}${dateTime.month} - ${dateTime.year} ${!showTime ? "" : " a las ${dateTime.hour < 10 ? 0 : ""}${dateTime.hour}:${dateTime.minute < 10 ? 0 : ""}${dateTime.minute}"}";
  }

  static Widget getIcon(Message msg) => Obx(() {
        switch (msg.state.value) {
          case MessageState.noEnviado:
            return Icon(
              Icons.close,
              color: extension.fail,
            );
          case MessageState.enCola:
            return Icon(
              Icons.schedule,
              color: extension.wait,
            );
          case MessageState.enviado:
            return Icon(
              Icons.done,
              color: extension.good,
            );
          default:
            throw Exception("No se pasó un valor válido");
        }
      });

  static double percentajeToPx(double maxSize, double percentaje) =>
      maxSize * percentaje / 100;
  static String prepareCellphone(String cellPhone, prefix) {
    if (cellPhone.substring(0, 3).compareTo(prefix) == 0) return cellPhone;
    return "$prefix$cellPhone";
  }
}
