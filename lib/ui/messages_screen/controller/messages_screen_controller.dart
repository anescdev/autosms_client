import 'package:autosms_client/services/http_services.dart';
import 'package:autosms_client/theme/custom_color.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../../../models/message_model.dart';

class MessagesScreenController extends GetxController {
  RxBool loading = false.obs;
  RxList<Message> founded = <Message>[].obs;
  Rx<MessageType> typeElement = MessageType.all.obs;
  ThemeData theme = Get.theme;
  final CustomColors extension = Get.theme.extension<CustomColors>()!;
  RxList<Message> selected = <Message>[].obs;

  int limit = 25;
  int offset = 0;
  @override
  void onInit() async {
    super.onInit();
    loading.value = true;
    List<Message>? temp = await HttpService.instance.getMessages(limit, offset);
    if (temp != null) {
      founded.addAll(temp);
    }
    loading.value = false;
  }

  void onFilterChange(Set<MessageType> value) {
    typeElement.value = value.first;
    selected.clear();
  }

  void onLongPress(Message msg) {
    if (msg.state == MessageState.noEnviado) {
      if (!selected.contains(msg)) {
        selected.add(msg);
        print("seleccionado");
      } else {
        selected.remove(msg);
        print("deseleccionado");
      }
    }
  }

  void onTap(Message msg) {
    if (selected.contains(msg)) {
      selected.remove(msg);
    } else if (selected.isNotEmpty) {
      selected.add(msg);
    }
  }

  Icon getIcon(Message msg) {
    switch (msg.state) {
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
  }
}

enum MessageType { all, sms, email }
