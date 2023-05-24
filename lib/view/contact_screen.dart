import 'package:autosms_client/controllers/contact_screen_controller.dart';
import 'package:autosms_client/models/group_manager.dart';
import 'package:autosms_client/models/manager_element_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/utils.dart';

class ContactScreen extends GetView<ContactScreenController> {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Obx(() {
        if (controller.loading.isTrue) {
          return CircularProgressIndicator();
        }
        return Column(
          children: [
            Obx(() => SegmentedButton<ManagerElementType>(
                  segments: [
                    ButtonSegment<ManagerElementType>(
                        value: ManagerElementType.contact,
                        label: const Text("Contactos"),
                        icon: const Icon(Icons.contacts),
                        enabled: !controller.loading.value),
                    ButtonSegment<ManagerElementType>(
                        value: ManagerElementType.group,
                        label: const Text("Grupos"),
                        icon: const Icon(Icons.groups),
                        enabled: !controller.loading.value)
                  ],
                  style: controller.theme.segmentedButtonTheme.style,
                  selected: <ManagerElementType>{controller.typeElement.value},
                  onSelectionChanged: controller.onFilterChange,
                )),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: Utils.percentajeToPx(context.width, 20)),
              child: const Divider(),
            ),
            controller.typeElement.value == ManagerElementType.contact
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: controller.contacts.length,
                    itemBuilder: (context, index) {
                      return Obx(() {
                        return ListTile(
                          selectedTileColor: controller.selected.contains(index)
                              ? Colors.grey.withOpacity(0.1)
                              : null,
                          onTap: () {
                            int indexPlace = controller.selected.indexOf(index);
                            if (indexPlace == -1) {
                              Get.snackbar("Error", "No implementado",
                                  duration: const Duration(seconds: 2));
                            } else {
                              controller.selected.removeAt(indexPlace);
                            }
                          },
                          onLongPress: () {
                            int indexPlace = controller.selected.indexOf(index);
                            if (indexPlace == -1) {
                              controller.selected.add(index);
                            } else {
                              controller.selected.removeAt(indexPlace);
                            }
                          },
                          selected: controller.selected.contains(index),
                          style: controller.theme.listTileTheme.style,
                          leading: CircleAvatar(
                            child: Text(controller.contacts[index].name
                                .substring(0, 1)),
                          ),
                          title: Text(controller.contacts[index].name),
                        );
                      });
                    })
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: controller.groups.length,
                    itemBuilder: (context, index) {
                      return Obx(() => ListTile(
                            selectedTileColor:
                                controller.selected.contains(index)
                                    ? Colors.grey.withOpacity(0.1)
                                    : null,
                            onTap: () {
                              int indexPlace =
                                  controller.selected.indexOf(index);
                              if (indexPlace == -1) {
                                Get.snackbar("Error", "No implementado",
                                    duration: const Duration(seconds: 2));
                              } else {
                                controller.selected.removeAt(indexPlace);
                              }
                            },
                            onLongPress: () {
                              int indexPlace =
                                  controller.selected.indexOf(index);
                              if (indexPlace == -1) {
                                controller.selected.add(index);
                              } else {
                                controller.selected.removeAt(indexPlace);
                              }
                            },
                            selected: controller.selected.contains(index),
                            style: controller.theme.listTileTheme.style,
                            leading: CircleAvatar(
                              child: Text(controller.groups[index].name
                                  .substring(0, 1)),
                            ),
                            title: Text(controller.groups[index].name),
                            trailing: Text(
                                "Participantes: ${controller.groups[index].members}",
                                style: TextStyle(fontSize: 14.0)),
                          ));
                    })
          ],
        );
      })),
      floatingActionButton: Obx(() => FloatingActionButton.extended(
          icon: Icon(controller.typeElement == ManagerElementType.contact
              ? Icons.person_add
              : Icons.group_add),
          label: const Text("Crear"),
          onPressed: () => Get.snackbar("Error", "No implementado"))),
    );
  }
}
