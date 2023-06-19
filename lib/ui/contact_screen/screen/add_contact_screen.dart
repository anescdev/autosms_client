import 'package:autosms_client/ui/contact_screen/controller/add_contact_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';

class AddContactScreen extends GetView<AddContactScreenController> {
  const AddContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar:
            AppBar(title: const Text("Añadir contacto", style: Utils.textBold)),
        body: Center(
            child: SingleChildScrollView(
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
                              ? controller.controllerLastName.text.isNotEmpty
                                  ? "${controller.controllerName.text.substring(0, 1)}${controller.controllerLastName.text.substring(0, 1)}"
                                  : controller.controllerName.text.substring(
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
                                      Icon(Icons.badge),
                                      Text(
                                        "Identificación del contacto",
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
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 6.0, bottom: 6.0),
                                    child: TextFormField(
                                        controller:
                                            controller.controllerLastName,
                                        validator: controller.nameValidator,
                                        textInputAction: TextInputAction.done,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "Apellidos")))
                              ]))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                      child: Card(
                          child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(children: [
                                const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.book),
                                      Text(
                                        "Formas de contacto",
                                        style: Utils.textBold,
                                      )
                                    ]),
                                const Divider(),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 6.0, bottom: 6.0),
                                    child: TextFormField(
                                        controller: controller.controllerEmail,
                                        validator: controller.emailValidator,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "Correo electrónico"))),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 6.0, bottom: 6.0),
                                    child: TextFormField(
                                        controller: controller.controllerPhone,
                                        validator: controller.phoneValidator,
                                        textInputAction: TextInputAction.done,
                                        keyboardType: TextInputType.phone,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "Teléfono")))
                              ]))),
                    )
                  ],
                ),
              )
            ],
          ),
        )),
        floatingActionButton: FloatingActionButton.extended(
            icon: const Icon(Icons.person_add),
            label: const Text("Crear"),
            onPressed: controller.createContact),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
