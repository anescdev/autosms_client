import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';
import '../controller/view_contact_screen_controller.dart';

class ViewContactScreen extends GetView<ViewContactScreenController> {
  const ViewContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:
                const Text("Información de contacto", style: Utils.textBold)),
        body: Center(
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(children: [
                  Container(
                      width: context.width,
                      color: controller.theme.colorScheme.primaryContainer
                          .withOpacity(0.3),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CircleAvatar(
                          radius: 60.0,
                          child: Text(
                              controller.actualContact.lastName != null
                                  ? "${controller.actualContact.name.substring(0, 1)}${controller.actualContact.lastName!.substring(0, 1)}"
                                  : controller.actualContact.name
                                      .substring(0, 1),
                              style: const TextStyle(fontSize: 50)),
                        ),
                      )),
                  Column(children: [
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
                                    child: ListTile(
                                      title: const Text("Nombre"),
                                      subtitle:
                                          Text(controller.actualContact.name),
                                    )),
                                const Divider(
                                  indent: 30,
                                  endIndent: 30,
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 6.0, bottom: 6.0),
                                    child: ListTile(
                                      title: const Text("Apellidos"),
                                      subtitle: Text(
                                          controller.actualContact.lastName ??
                                              "No definido"),
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
                                      child: ListTile(
                                        title: const Text("Correo electrónico"),
                                        subtitle: Text(
                                            controller.actualContact.email),
                                      )),
                                  const Divider(
                                    indent: 30,
                                    endIndent: 30,
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 6.0, bottom: 6.0),
                                      child: ListTile(
                                        title: const Text("Teléfono"),
                                        subtitle: Text(
                                            "+34 ${controller.actualContact.phoneNumber.substring(3)}"),
                                      ))
                                ]))))
                  ])
                ]))));
  }
}
