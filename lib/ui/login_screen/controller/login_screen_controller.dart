import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../bindings/bindings.dart';
import '../../../services/http_services.dart';
import '../../home_screen/screen/home_screen.dart';

class LoginScreenController extends GetxController {
  late TextEditingController userController;
  late TextEditingController passController;
  final formKey = GlobalKey<FormState>();
  RxBool loadingState = true.obs;
  @override
  void onInit() async {
    super.onInit();
    if (await HttpService.instance.checkAuth()) {
      print("Existe mi pana");
      return Get.offAll(() => const HomeScreen(), binding: HomeBindings());
    }
    print("No existe mi pana");
    loadingState.value = false;
  }

  @override
  void onReady() {
    super.onReady();
    userController = TextEditingController();
    passController = TextEditingController();
  }

  String? userValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "No has escrito nada";
    }
    return null;
  }

//hacer lo de las cookies
  @override
  void dispose() {
    super.dispose();
    userController.dispose();
    passController.dispose();
  }

  void tryLogin() async {
    if (formKey.currentState!.validate()) {
      if (await HttpService.instance
          .auth(userController.text, passController.text)) {
        loadingState.value = true;
        userController.clear();
        passController.clear();
        Get.offAll(() => const HomeScreen(), binding: HomeBindings());
        loadingState.value = false;
      }
    }
  }
}
