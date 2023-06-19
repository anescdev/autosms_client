import 'package:autosms_client/bindings/bindings.dart';
import 'package:autosms_client/services/http_services.dart';
import 'package:autosms_client/ui/contact_screen/controller/contact_screen_controller.dart';
import 'package:autosms_client/ui/messages_screen/controller/messages_screen_controller.dart';
import 'package:autosms_client/ui/profile_screen/controller/profile_screen_controller.dart';
import 'package:autosms_client/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contact_screen/screen/contact_screen.dart';
import '../../dashboard_screen/screen/dashboard_screen.dart';
import '../../login_screen/screen/login_screen.dart';
import '../../messages_screen/screen/messages_screen.dart';
import '../../profile_screen/screen/profile_screen.dart';

class HomeScreenController extends GetxController {
  late final List<List<Widget>> actions;
  RxInt selectedIndex = 0.obs;
  ThemeData theme = Get.theme;
  late final IconButton logOutButton;

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
  @override
  void onInit() {
    super.onInit();
    ContactScreenController contactScreenController =
        Get.find<ContactScreenController>();
    ProfileScreenController profileScreenController =
        Get.find<ProfileScreenController>();
    MessagesScreenController messagesScreenController =
        Get.find<MessagesScreenController>();
    logOutButton =
        IconButton(onPressed: logout, icon: const Icon(Icons.logout));
    const Text titleDialog = Text("Confirmación", style: Utils.textBold);
    actions = [
      [logOutButton],
      [
        IconButton(
            onPressed: () => messagesScreenController.getAndPushMessages(true),
            icon: const Icon(Icons.refresh)),
        Obx(() => IconButton(
            onPressed: messagesScreenController.selected.isEmpty
                ? null
                : () => messagesScreenController.selected.clear(),
            icon: const Icon(Icons.deselect))),
        logOutButton
      ],
      [
        Obx(() => IconButton(
            onPressed: contactScreenController.selected.isNotEmpty
                ? () async {
                    contactScreenController.deleting.value = true;
                    await Get.dialog(contactScreenController
                                .typeElement.value ==
                            ManagerElementType.contact
                        ? AlertDialog(
                            icon: const Icon(Icons.person_remove),
                            title: titleDialog,
                            content: Text(contactScreenController
                                        .selected.length >
                                    1
                                ? "¿Estás segur@ de que quiere eliminar los contactos seleccionados?"
                                : "¿Estás segur@ de que quiere eliminar el contacto seleccionado?"),
                            actions: [
                                TextButton(
                                    onPressed:
                                        contactScreenController.deleteContacts,
                                    child: const Text("Borrar")),
                                TextButton(
                                    onPressed: () => Get.back(),
                                    child: const Text("Cancelar"))
                              ])
                        : AlertDialog(
                            icon: const Icon(Icons.group_remove),
                            title: titleDialog,
                            content: Text(contactScreenController
                                        .selected.length >
                                    1
                                ? "¿Estás segur@ de que quiere eliminar los grupos seleccionados?"
                                : "¿Estás segur@ de que quiere eliminar el grupo seleccionado?"),
                            actions: [
                                TextButton(
                                    onPressed:
                                        contactScreenController.deleteGroups,
                                    child: const Text("Borrar")),
                                TextButton(
                                    onPressed: () => Get.back(),
                                    child: const Text("Cancelar"))
                              ]));
                    contactScreenController.deleting.value = false;
                  }
                : null,
            icon: const Icon(Icons.delete))),
        logOutButton
      ],
      [
        IconButton(
            onPressed: () => profileScreenController.modify(),
            icon: const Icon(Icons.edit)),
        logOutButton
      ]
    ];
  }

  void logout() async {
    if (await HttpService.instance.logout()) {
      Get.offAll(() => const LoginScreen(), binding: LoginBindings());
    }
  }

  void onTap(int index) {
    selectedIndex.value = index;
    update();
  }
}
