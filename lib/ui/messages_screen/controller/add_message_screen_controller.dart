import 'dart:collection';

import 'package:autosms_client/models/contact_model.dart';
import 'package:autosms_client/models/email_model.dart';
import 'package:autosms_client/models/group_model.dart';
import 'package:autosms_client/models/manager_element_model.dart';
import 'package:autosms_client/services/http_services.dart';
import "package:dio/dio.dart" as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/message_model.dart';

class CreateMessageScreenController extends GetxController {
  RxBool isEmail = true.obs;
  GlobalKey<FormState> formKey = GlobalKey();
  void recursiveContactManager(
      List<ManagerElement> managerElement, HashSet<String> receptors) {
    for (var element in managerElement) {
      if (element is Contact) {
        if (element is Email) {
          receptors.add(element.phoneNumber);
        } else {
          receptors.add(element.email);
        }
      } else {
        recursiveContactManager((element as Group).groupElements, receptors);
      }
    }
  }

  void create() {}
}
