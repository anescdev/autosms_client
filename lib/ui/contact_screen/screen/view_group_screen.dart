import 'package:autosms_client/ui/contact_screen/controller/view_group_screen_controller.dart';
import 'package:autosms_client/widgets/contact_searcher/contact_searcher_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';

class ViewGroupScreen extends GetView<ViewGroupScreenController> {
  const ViewGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Información de grupo", style: Utils.textBold)),
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
                      child: Text(controller.actualGroup.name.substring(0, 1),
                          style: const TextStyle(fontSize: 50)),
                    ),
                  )),
              Column(
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
                                  child: ListTile(
                                    title: const Text("Nombre"),
                                    subtitle: Text(controller.actualGroup.name),
                                  )),
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
                                    Text(
                                      "Participantes: ${controller.actualGroup.groupElements.length}",
                                      style: Utils.textBold,
                                    )
                                  ]),
                              const Divider(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 6.0, bottom: 6.0),
                                child: ContactSearcher(
                                  readOnly: true,
                                  founded:
                                      controller.actualGroup.groupElements.obs,
                                  includeGroups: false,
                                ),
                              )
                            ]))),
                  )
                ],
              )
            ],
          ),
        )));
  }
}
