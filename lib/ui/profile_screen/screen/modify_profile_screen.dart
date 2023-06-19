import 'package:autosms_client/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/modify_profile_screen_controller.dart';

class ModifyProfileScreen extends GetView<ModifyProfileScreenController> {
  const ModifyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Modificar perfil",
          style: Utils.textBold,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
            child: Form(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.badge),
                                Text(
                                  "Identificación del contacto",
                                  style: Utils.textBold,
                                )
                              ]),
                          const Divider(),
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 6.0, bottom: 6.0),
                              child: Obx(
                                () => TextFormField(
                                    enabled: !controller.isModifying.value,
                                    controller: controller.nameController,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Nombre")),
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 6.0, bottom: 6.0),
                              child: Obx(
                                () => TextFormField(
                                    enabled: !controller.isModifying.value,
                                    controller: controller.nameLastController,
                                    textInputAction: TextInputAction.done,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Apellidos")),
                              ))
                        ]))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                child: Card(
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(children: [
                          const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.book),
                                Text(
                                  "Formas de contacto",
                                  style: Utils.textBold,
                                )
                              ]),
                          const Divider(),
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 6.0, bottom: 6.0),
                              child: Obx(
                                () => TextFormField(
                                    enabled: !controller.isModifying.value,
                                    controller: controller.emailController,
                                    validator: controller.emailValidator,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Correo electrónico")),
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 6.0, bottom: 6.0),
                              child: Obx(
                                () => TextFormField(
                                    enabled: !controller.isModifying.value,
                                    controller: controller.phoneController,
                                    validator: controller.phoneValidator,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Teléfono")),
                              ))
                        ]))),
              )
            ],
          ),
        )),
      ),
      floatingActionButton: Obx(() => FloatingActionButton.extended(
          isExtended: !controller.isModifying.value,
          onPressed:
              controller.isModifying.value ? null : controller.modificarPerfil,
          icon: controller.isModifying.value
              ? const CircularProgressIndicator()
              : const Icon(Icons.edit),
          label: const Text("Modificar"))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
