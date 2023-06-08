import 'package:autosms_client/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddGroupScreenController extends GetxController {
  TextEditingController controllerName = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ThemeData theme = Get.theme;
  RxBool isCreating = false.obs;
  RxList<Contact> selectedContact = <Contact>[].obs;

  @override
  void onReady() {
    super.onReady();
    controllerName.addListener(onEditComplete);
  }

  @override
  void dispose() {
    super.dispose();
    controllerName.dispose();
  }

  void onEditComplete() {
    update();
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) return "No has escrito nada";
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) return "No has escrito nada";
    if (!value.isEmail) return "No has pasado un email válido";
    return null;
  }

  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) return "No has escrito nada";
    if (!value.isPhoneNumber) return "No has pasado un número válido";
    return null;
  }

  void createGroup() async {
    isCreating.value = true;
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> args = Get.arguments;
      args["group"].id = "";
      args["group"].name = controllerName.text;
      args["group"].groupElements = selectedContact;
      args["group"].members = selectedContact.length;
      String? id = await args["group"].addGroup();
      if (id != null) {
        args["valid"] = true;
        args["group"].id = id;
        Get.back();
      }
    }
    isCreating.value = false;
  }
}
