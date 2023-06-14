import 'package:autosms_client/models/manager_element_model.dart';
import 'package:autosms_client/utils/utils.dart';
import 'package:autosms_client/widgets/contact_searcher/contact_searcher_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/contact_model.dart';

class ContactSearcher extends StatelessWidget {
  final bool readOnly;
  late RxList<ManagerElement>? selected;
  final RxList<ManagerElement> founded;
  final bool includeGroups;
  ContactSearcher(
      {super.key,
      this.readOnly = true,
      this.selected,
      required this.founded,
      required this.includeGroups});

  @override
  Widget build(BuildContext context) {
    selected ??= <ManagerElement>[].obs;
    Get.put(ContactSearcherController(
        selected: selected!,
        readOnly: readOnly,
        founded: founded,
        includeGroups: includeGroups));
    return GetBuilder<ContactSearcherController>(builder: (controller) {
      return Column(children: [
        Container(
            height: Utils.percentajeToPx(context.height, readOnly ? 21 : 23),
            decoration: BoxDecoration(
                border: Border.all(color: Get.theme.colorScheme.outline),
                borderRadius: const BorderRadius.all(Radius.circular(8.0))),
            child: Obx(() {
              if (!readOnly &&
                  !controller.hasVal.value &&
                  controller.selected.isEmpty) {
                return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.search,
                            size: 40.0,
                            color: Get.theme.colorScheme.onSurfaceVariant),
                        Text(
                          "Escriba algo en el campo para buscar los contactos disponibles.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Get.theme.colorScheme.onSurfaceVariant),
                        )
                      ]),
                );
              } else if (controller.isSearching.value) {
                return Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      const CircularProgressIndicator(),
                      Text("Buscando...",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Get.theme.colorScheme.onSurfaceVariant))
                    ]));
              } else if (!readOnly) {
                if (controller.notFound.value) {
                  if (controller.selected.isEmpty) {
                    return Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                          Icon(Icons.search_off,
                              size: 40.0,
                              color: Get.theme.colorScheme.onSurfaceVariant),
                          Text("No se encontró nada",
                              style: TextStyle(
                                  color:
                                      Get.theme.colorScheme.onSurfaceVariant))
                        ]));
                  }
                }
                return Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Obx(() => ListView.builder(
                            itemCount: controller.founded.length,
                            itemBuilder: (context, index) => Obx(
                                  () => Material(
                                    type: MaterialType.transparency,
                                    child: ListTile(
                                      selectedTileColor: controller.selected
                                              .contains(
                                                  controller.founded[index])
                                          ? Colors.grey.withOpacity(0.1)
                                          : null,
                                      onTap: () {
                                        int indexPlace = controller.selected
                                            .indexOf(controller.founded[index]);
                                        if (indexPlace == -1) {
                                          controller.selected
                                              .add(controller.founded[index]);
                                        } else {
                                          controller.selected.remove(
                                              controller.founded[index]);
                                        }
                                      },
                                      selected: controller.selected.contains(
                                              controller.founded[index])
                                          ? true
                                          : false,
                                      leading: Icon(
                                          controller.founded[index] is Contact
                                              ? Icons.person
                                              : Icons.group),
                                      title:
                                          Text(controller.founded[index].name),
                                    ),
                                  ),
                                ))),
                      ),
                      Obx(() => IconButton(
                            onPressed: controller.selected.isNotEmpty
                                ? (() => controller.selected.clear())
                                : null,
                            icon: const Icon(Icons.clear),
                            alignment: Alignment.bottomRight,
                          ))
                    ]);
              }
              return ListView.builder(
                  itemCount: controller.founded.length,
                  itemBuilder: (context, index) => ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(controller.founded[index].name),
                      ));
            })),
        !readOnly
            ? TextField(
                onEditingComplete: controller.onComplete,
                onChanged: (value) => controller.val = value,
                onSubmitted: (_) => FocusScope.of(context).unfocus(),
                decoration: const InputDecoration(
                    labelText: "Buscar", icon: Icon(Icons.search)),
              )
            : Container()
      ]);
    });
  }

  void getFromDatabase(String nombre) async {}
}
