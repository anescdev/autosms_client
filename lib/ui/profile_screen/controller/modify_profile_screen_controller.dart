import 'package:autosms_client/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/profile_model.dart';

class ModifyProfileScreenController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController nameLastController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ThemeData theme = Get.theme;
  Profile? profile = Get.arguments["profile"];
  RxBool isModifying = false.obs;
  @override
  void onInit() {
    super.onInit();
    nameController.text = profile!.name;
    nameLastController.text = profile!.lastName;
    phoneController.text = profile!.cellNumber;
    emailController.text = profile!.email;
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    nameLastController.dispose();
    phoneController.dispose();
    emailController.dispose();
  }

  String? emailValidator(String? value) {
    if (value!.isNotEmpty && !value.isEmail) {
      return "No has pasado un email válido";
    }
    return null;
  }

  String? phoneValidator(String? value) {
    if (value!.isNotEmpty && !value.isPhoneNumber) {
      return "No has pasado un número válido";
    }
    return null;
  }

  void modificarPerfil() async {
    if (formKey.currentState!.validate()) {
      String cellPhone = Utils.prepareCellphone(phoneController.text, "+34");
      isModifying.value = true;
      Profile newProfile = Profile(
          id: profile!.id,
          name: nameController.text,
          lastName: nameLastController.text,
          cellNumber: cellPhone,
          email: emailController.text);
      bool updated = await profile!.updateProfile(newProfile);
      print(updated);
      if (updated) {
        profile!.name = newProfile.name;
        profile!.lastName = newProfile.lastName;
        profile!.cellNumber = cellPhone;
        profile!.email = emailController.text;
        Get.arguments["valid"] = true;
        Get.back();
      }
      isModifying.value = false;
    }
  }
}
