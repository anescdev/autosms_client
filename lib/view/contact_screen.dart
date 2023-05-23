import 'package:autosms_client/controllers/contact_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';

class ContactScreen extends GetView<ContactScreenController> {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Obx(() => SegmentedButton<ManagerElementType>(
                segments: const [
                  ButtonSegment<ManagerElementType>(
                      value: ManagerElementType.contact,
                      label: Text("Contactos"),
                      icon: Icon(Icons.contacts)),
                  ButtonSegment<ManagerElementType>(
                      value: ManagerElementType.group,
                      label: Text("Grupos"),
                      icon: Icon(Icons.groups))
                ],
                selected: <ManagerElementType>{controller.typeElement.value},
                onSelectionChanged: controller.onFilterChange,
              )),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: Utils.percentajeToPx(context.width, 20)),
            child: const Divider(),
          )
        ],
      )),
    );
  }
}
