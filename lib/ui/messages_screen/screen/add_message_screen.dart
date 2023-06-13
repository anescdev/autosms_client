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
                controller.isEmail.isTrue
                    ? Column(
                        children: [
                          TextFormField(
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
                    width: Utils.percentajeToPx(context.width, 90),
                    child: ContactSearcher(
                        founded: <ManagerElement>[].obs, readOnly: false)),
                const Divider(),
                TextFormField(
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
          onPressed: controller.create,
          icon: const Icon(Icons.sms),
          label: const Text("Crear mensaje")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
