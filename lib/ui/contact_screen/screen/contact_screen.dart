import 'package:autosms_client/bindings/bindings.dart';
import 'package:autosms_client/ui/contact_screen/screen/view_group_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';
import '../controller/contact_screen_controller.dart';
import 'view_contact_screen.dart';

class ContactScreen extends GetView<ContactScreenController> {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Obx(() {
        if (controller.loading.isTrue) {
          return const CircularProgressIndicator();
        }
        return Column(
          children: [
            Obx(() => SegmentedButton<ManagerElementType>(
                  segments: [
                    ButtonSegment<ManagerElementType>(
                        value: ManagerElementType.contact,
                        label: const Text("Contactos"),
                        icon: const Icon(Icons.contacts),
                        enabled: !(controller.loading.value ||
                            controller.deleting.value)),
                    ButtonSegment<ManagerElementType>(
                        value: ManagerElementType.group,
                        label: const Text("Grupos"),
                        icon: const Icon(Icons.groups),
                        enabled: !(controller.loading.value ||
                            controller.deleting.value))
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
                          selectedTileColor: controller.selected
                                  .contains(controller.contacts[index])
                              ? Colors.grey.withOpacity(0.1)
                              : null,
                          onTap: () {
                            int indexPlace = controller.selected
                                .indexOf(controller.contacts[index]);
                            if (indexPlace == -1) {
                              Get.to(() => const ViewContactScreen(),
                                  arguments: controller.contacts[index],
                                  binding: ContactViewBindings());
                            } else {
                              controller.selected.removeAt(indexPlace);
                            }
                          },
                          onLongPress: () {
                            int indexPlace = controller.selected
                                .indexOf(controller.contacts[index]);
                            if (indexPlace == -1) {
                              controller.selected
                                  .add(controller.contacts[index]);
                            } else {
                              controller.selected.removeAt(indexPlace);
                            }
                          },
                          selected: controller.selected
                              .contains(controller.contacts[index]),
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
                            selectedTileColor: controller.selected
                                    .contains(controller.groups[index])
                                ? Colors.grey.withOpacity(0.1)
                                : null,
                            onTap: () {
                              int indexPlace = controller.selected
                                  .indexOf(controller.groups[index]);
                              if (indexPlace == -1) {
                                print(controller.groups[index].groupElements);
                                Get.to(() => const ViewGroupScreen(),
                                    binding: GroupViewBindings(),
                                    arguments: controller.groups[index]);
                              } else {
                                controller.selected.removeAt(indexPlace);
                              }
                            },
                            onLongPress: () {
                              int indexPlace = controller.selected
                                  .indexOf(controller.groups[index]);
                              if (indexPlace == -1) {
                                controller.selected
                                    .add(controller.groups[index]);
                              } else {
                                controller.selected.removeAt(indexPlace);
                              }
                            },
                            selected: controller.selected
                                .contains(controller.groups[index]),
                            style: controller.theme.listTileTheme.style,
                            leading: CircleAvatar(
                              child: Text(controller.groups[index].name
                                  .substring(0, 1)),
                            ),
                            title: Text(controller.groups[index].name),
                            trailing: Text(
                                "Participantes: ${controller.groups[index].members}",
                                style: const TextStyle(fontSize: 14.0)),
                          ));
                    })
          ],
        );
      })),
      floatingActionButton: Obx(() => FloatingActionButton.extended(
          icon: Icon(controller.typeElement.value == ManagerElementType.contact
              ? Icons.person_add
              : Icons.group_add),
          label: const Text("Crear"),
          onPressed: () =>
              controller.typeElement.value == ManagerElementType.contact
                  ? controller.goToCreateContact()
                  : controller.goToCreateGroup())),
    );
  }
}
