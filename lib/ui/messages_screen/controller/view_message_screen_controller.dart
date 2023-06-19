import 'dart:collection';

import 'package:autosms_client/models/contact_model.dart';
import 'package:autosms_client/models/email_model.dart';
import 'package:autosms_client/models/group_model.dart';
import 'package:autosms_client/models/manager_element_model.dart';
import 'package:autosms_client/services/http_services.dart';
import 'package:autosms_client/ui/dashboard_screen/controller/dashboard_screen_controller.dart';
import "package:dio/dio.dart" as dio;
import 'package:get/get.dart';

import '../../../models/message_model.dart';

class ViewMessageScreenController extends GetxController {
  Message message = Get.arguments;
  RxBool loading = false.obs;
  @override
  void send() async {
    loading.value = true;
    if (message is Email) {
      Map<String, dynamic> body = {
        "id": message.id,
        "message": message.message
      };
      if (message is Email) body["subject"] = (message as Email).subject;
      HashSet<String> receptors =
          HashSet(equals: (str1, str2) => str1.compareTo(str2) == 0);
      recursiveContactManager(message.receptors, receptors);
      body["receptors"] = receptors.toList();
      try {
        dio.Response res = await HttpService.instance.httpClient
            .post("/messages/send", data: body);
        if (res.statusCode == 202) {
          message.state.value = MessageState.enCola;
          Get.find<DashboardScreenController>().messagesCount++;
          Get.back();
        }
      } on dio.DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 500) {
            HttpService.instance.show5xxError();
          }
        } else {
          printError(info: e.toString());
        }
      }
    } else {
      Get.snackbar("Aviso", "Aún no está funcionando la mensajería SMS");
    }
    loading.value = false;
  }

  void recursiveContactManager(
      List<ManagerElement> managerElement, HashSet<String> receptors) {
    if (message is Email) {
      for (var element in managerElement) {
        if (element is Contact) {
          receptors.add(element.email);
        } else {
          recursiveContactManager((element as Group).groupElements, receptors);
        }
      }
    } else {
      for (var element in managerElement) {
        if (element is Contact) {
          receptors.add(element.phoneNumber);
        } else {
          recursiveContactManager((element as Group).groupElements, receptors);
        }
      }
    }
  }
}
