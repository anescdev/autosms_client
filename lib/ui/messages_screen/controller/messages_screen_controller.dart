import 'package:autosms_client/bindings/bindings.dart';
import 'package:autosms_client/services/http_services.dart';
import 'package:autosms_client/theme/custom_color.g.dart';
import 'package:autosms_client/ui/messages_screen/screen/view_message_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../../../models/message_model.dart';

class MessagesScreenController extends GetxController {
  RxBool loading = false.obs;
  RxList<Message> founded = <Message>[].obs;
  Rx<MessageType> typeElement = MessageType.all.obs;
  ThemeData theme = Get.theme;
  RxList<Message> selected = <Message>[].obs;

  int limit = 25;
  int offset = 0;
  @override
  void onInit() async {
    super.onInit();
    getAndPushMessages(false);
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
    } else {
      Get.to(() => const ViewMessageScreen(),
          binding: ViewMessageBindings(), arguments: msg);
    }
  }

  void getAndPushMessages(bool clearList) async {
    loading.value = true;
    List<Message>? temp = await HttpService.instance.getMessages(limit, offset);
    if (temp != null) {
      if (clearList) {
        founded.clear();
      }
      founded.addAll(temp);
    }
    loading.value = false;
  }
}

enum MessageType { all, sms, email }
