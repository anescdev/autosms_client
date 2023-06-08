import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddContactScreenController extends GetxController {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ThemeData theme = Get.theme;

  @override
  void onReady() {
    super.onReady();
    controllerName.addListener(onEditComplete);
    controllerLastName.addListener(onEditComplete);
  }

  @override
  void dispose() {
    super.dispose();
    controllerName.dispose();
    controllerLastName.dispose();
    controllerPhone.dispose();
    controllerEmail.dispose();
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

  void createContact() async {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> args = Get.arguments;
      args["contact"].id = "";
      args["contact"].name = controllerName.text;
      args["contact"].lastName = controllerLastName.text;
      args["contact"].phoneNumber = controllerPhone.text.contains("+34")
          ? controllerPhone.text
          : "+34${controllerPhone.text}";
      args["contact"].email = controllerEmail.text;
      String? id = await args["contact"].addContact();
      if (id != null) {
        args["valid"] = true;
        args["contact"].id = id;
        Get.back();
      }
    }
  }
}
