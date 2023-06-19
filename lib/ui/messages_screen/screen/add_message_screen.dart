import 'package:autosms_client/models/manager_element_model.dart';
import 'package:autosms_client/widgets/contact_searcher/contact_searcher_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';
import '../controller/add_message_screen_controller.dart';

class CreateMessageScreen extends GetView<CreateMessageScreenController> {
  const CreateMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Crear mensaje",
        style: Utils.textBold,
      )),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
              child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                DropdownButtonFormField(
                  items: const [
                    DropdownMenuItem<int>(
                      value: 0,
                      enabled: false,
                      child: Text("SMS"),
                    ),
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text("Email"),
                    )
                  ],
                  onChanged: (val) => controller.selectedDrop.value = val!,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Canal de mensajería",
                      icon: Icon(Icons.signpost_outlined)),
                  validator: (val) {
                    if (val == null) return "No has seleccionado el canal";
                    if (val == 0) return "No se permite enviar SMS aún";
                    return null;
                  },
                ),
                const Divider(),
                controller.selectedDrop.value == 1
                    ? Column(
                        children: [
                          TextFormField(
                              controller: controller.subjectController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "No puede estar vacío";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.subject),
                                  labelText: "Asunto")),
                          const Divider(),
                        ],
                      )
                    : const SizedBox.shrink(),
                const ListTile(
                  leading: Icon(Icons.groups),
                  title: Text("Destinatiarios"),
                ),
                SizedBox(
                    width: Utils.percentajeToPx(context.width, 95),
                    child: ContactSearcher(
                      founded: <ManagerElement>[].obs,
                      selected: controller.selected,
                      readOnly: false,
                      includeGroups: true,
                    )),
                const Divider(),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) return "No puede estar vacío";
                    return null;
                  },
                  controller: controller.messageController,
                  minLines: 4,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                      labelText: "Mensaje",
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.description)),
                )
              ],
            ),
          )),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          heroTag: null,
          onPressed: controller.create,
          icon: const Icon(Icons.sms),
          label: const Text("Crear mensaje")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
