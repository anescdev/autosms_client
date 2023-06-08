import 'package:autosms_client/models/contact_model.dart';
import 'package:autosms_client/ui/contact_screen/controller/add_group_screen_controller.dart';
import 'package:autosms_client/widgets/contact_searcher/contact_searcher_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';

class AddGroupScreen extends GetView<AddGroupScreenController> {
  const AddGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar:
            AppBar(title: const Text("Añadir grupo", style: Utils.textBold)),
        body: Center(child: Obx(() {
          if (controller.isCreating.value)
            return const CircularProgressIndicator();
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                    width: context.width,
                    color: controller.theme.colorScheme.primaryContainer
                        .withOpacity(0.3),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CircleAvatar(
                        radius: 60.0,
                        child: Text(
                            controller.controllerName.text.isNotEmpty
                                ? controller.controllerName.text.substring(
                                    0,
                                    controller.controllerName.text.length > 1
                                        ? 2
                                        : 1)
                                : "AC",
                            style: const TextStyle(fontSize: 50)),
                      ),
                    )),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, bottom: 6.0),
                        child: Card(
                            child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(children: [
                                  const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.label),
                                        Text(
                                          "Identificación del grupo",
                                          style: Utils.textBold,
                                        )
                                      ]),
                                  const Divider(),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 6.0, bottom: 6.0),
                                      child: TextFormField(
                                          controller: controller.controllerName,
                                          validator: controller.nameValidator,
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: "Nombre"))),
                                ]))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                        child: Card(
                            child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(Icons.group),
                                        Obx(() => Text(
                                              "Participantes: ${controller.selectedContact.length}",
                                              style: Utils.textBold,
                                            ))
                                      ]),
                                  const Divider(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 6.0, bottom: 6.0),
                                    child: ContactSearcher(
                                      readOnly: false,
                                      selected: controller.selectedContact,
                                      founded: <Contact>[].obs,
                                    ),
                                  )
                                ]))),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        })),
        floatingActionButton: FloatingActionButton.extended(
            icon: const Icon(Icons.person_add),
            label: const Text("Crear"),
            onPressed: controller.createGroup),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
