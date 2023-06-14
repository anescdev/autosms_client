import 'dart:collection';
import 'dart:convert';

import 'package:autosms_client/models/contact_model.dart';
import 'package:autosms_client/models/email_model.dart';
import 'package:autosms_client/models/group_model.dart';
import 'package:autosms_client/models/manager_element_model.dart';
import 'package:autosms_client/models/sms_model.dart';
import 'package:autosms_client/services/http_services.dart';
import "package:dio/dio.dart" as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/message_model.dart';
import '../../../utils/utils.dart';

class CreateMessageScreenController extends GetxController {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  RxInt selectedDrop = 1.obs;
  final GlobalKey<FormState> formKey = GlobalKey();
  final RxList<ManagerElement> selected = <ManagerElement>[].obs;

  void recursiveContactManager(
      List<ManagerElement> managerElement, HashSet<String> receptors) {
    for (var element in managerElement) {
      if (element is Contact) {
        receptors.add(element.id);
      } else {
        recursiveContactManager((element as Group).groupElements, receptors);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    subjectController.dispose();
    messageController.dispose();
  }

  void create({bool send = false}) async {
    if (formKey.currentState!.validate()) {
      if (selected.isEmpty) {
        Get.defaultDialog(
            title: "Error",
            titlePadding: const EdgeInsets.all(8.0),
            titleStyle: Utils.textBold,
            cancel: TextButton(onPressed: Get.back, child: const Text("Vale")),
            content: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  "No puede crear un mensaje si no seleccionas un contacto o grupo"),
            ));
      } else {
        final HashSet<String> receptors =
            HashSet(equals: (str1, str2) => str1.compareTo(str2) == 0);
        recursiveContactManager(selected, receptors);
        Map<String, dynamic> body = {
          "message": {
            "receptors": receptors.toList(),
            "message": messageController.text
          }
        };
        if (selectedDrop.value == 0) {
          body["type"] = "sms";
        } else {
          body["type"] = "email";
          body["message"]["subject"] = subjectController.text;
        }
        try {
          dio.Response res = await HttpService.instance.httpClient
              .post("/message", data: jsonEncode(body));
          if (res.statusCode == 201) {
            Get.arguments["valid"] = true;
            Get.back();
          }
        } on dio.DioError catch (e) {
          if (e.response != null) {
            if (e.response!.statusCode == 400) {
              HttpService.instance.show400Error();
            }
          } else {
            print(e);
          }
        }
      }
    }
  }
}
