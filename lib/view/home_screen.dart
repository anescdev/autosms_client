import 'package:autosms_client/controllers/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(
          title: Text(controller.titles[controller.selectedIndex.value],
              style: const TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
                onPressed: controller.logout, icon: const Icon(Icons.logout))
          ],
        ),
        body: IndexedStack(
          index: controller.selectedIndex.value,
          children: controller.screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          useLegacyColorScheme: false,
          currentIndex: controller.selectedIndex.value,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home_filled),
                label: "Dashboard"),
            BottomNavigationBarItem(
                icon: Icon(Icons.message_outlined),
                activeIcon: Icon(Icons.message),
                label: "Mensajes"),
            BottomNavigationBarItem(
                icon: Icon(Icons.groups_outlined),
                activeIcon: Icon(Icons.groups),
                label: "Contactos"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: "Perfil")
          ],
          onTap: controller.onTap,
        )));
  }
}
