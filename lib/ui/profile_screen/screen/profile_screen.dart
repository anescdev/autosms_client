import 'package:autosms_client/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/profile_screen_controller.dart';

class ProfileScreen extends GetView<ProfileScreenController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Obx((() {
      if (controller.profile.value == null) {
        return const CircularProgressIndicator();
      }
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: controller.theme.colorScheme.primaryContainer
                          .withOpacity(0.5)),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24.0, top: 24.0),
                    child: Obx(() {
                      if (controller.profile.value!.photo == null) {
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: controller
                                      .theme.colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.person,
                                  size:
                                      Utils.percentajeToPx(context.height, 10),
                                ),
                              ),
                            ),
                            Obx(() => Text(
                                  controller.composedName.value,
                                  style: Utils.textBoldBig,
                                ))
                          ],
                        );
                      }
                      return Stack(
                        children: [
                          Image.memory(controller.profile.value!.photo!)
                        ],
                      );
                    }),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListTile(
                leading: const Icon(Icons.phone),
                title: const Text("Teléfono"),
                subtitle: Obx(
                  () => Text(controller.phone.value),
                )),
          ),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.email),
              title: const Text("Correo electrónico"),
              subtitle: Obx(() => Text(controller.email.value))),
        ],
      );
    }))));
  }
}
