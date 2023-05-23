import 'package:autosms_client/bindings/bindings.dart';
import 'package:autosms_client/services/http_services.dart';
import 'package:autosms_client/view/contact_screen.dart';
import 'package:autosms_client/view/login_screen.dart';
import 'package:autosms_client/view/messages_screen.dart';
import 'package:autosms_client/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/dashboard_screen.dart';

class HomeScreenController extends GetxController {
  RxInt selectedIndex = 0.obs;
  ThemeData theme = Get.theme;
  List<String> titles = const [
    "Dashboard",
    "Mensajes",
    "Gestor de Contactos",
    "Perfil"
  ];
  List<Widget> screens = const [
    DashboardScreen(),
    MessagesScreen(),
    ContactScreen(),
    ProfileScreen()
  ];
  void logout() async {
    if (await Get.find<HttpService>().logout()) {
      Get.offAll(() => const LoginScreen(), binding: LoginBindings());
    }
  }

  void onTap(int index) {
    selectedIndex.value = index;
    update();
  }
}
