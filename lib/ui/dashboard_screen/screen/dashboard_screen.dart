import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/dashboard_screen_controller.dart';

class DashboardScreen extends GetView<DashboardScreenController> {
  const DashboardScreen({super.key});
  Padding getPadding({required Widget? child, double value = 12.0}) {
    return Padding(padding: EdgeInsets.all(value), child: child);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Obx(() {
      if (controller.loading.isTrue) {
        return const CircularProgressIndicator();
      }
      return getPadding(
          child: Column(
        children: [
          Expanded(
              child: Card(
                  child: getPadding(
                      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: Text(
                "Bienvenido al Dashboard",
                style: controller.title,
              )),
              const Image(image: AssetImage("assets/logo_100.png"))
            ],
          )))),
          Padding(
            padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: Card(
                        child: getPadding(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${controller.messagesCount} \nmensajes",
                            style: controller.number,
                          ),
                          Text(
                            "enviados este mes.",
                            style: controller.comment,
                          )
                        ],
                      ),
                    )),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Card(
                      child: getPadding(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${controller.contactCount} \ncontactos",
                          style: controller.number,
                        ),
                        Text(
                          "totales en el gestor.",
                          style: controller.comment,
                        )
                      ],
                    ),
                  )),
                )),
              ],
            ),
          ),
          Card(
              child: getPadding(
                  child: Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Hola ${controller.nameProfile},\n${controller.subscription.value ? "su suscripción está al día." : "no tiene la suscripción activa."} ",
                                style: controller.number),
                            Row(
                              children: [
                                Flexible(
                                    child: Text(
                                  controller.subscription.value
                                      ? "Le recordamos que el ${controller.getDate()} tendrá que renovarla."
                                      : "Si desea enviar mensajes SMS deberá de activarla.",
                                  style: controller.comment,
                                )),
                                controller.subscription.value
                                    ? const Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.lightGreen,
                                        size: 160,
                                      )
                                    : Icon(Icons.cancel_outlined,
                                        color:
                                            controller.theme.colorScheme.error,
                                        size: 160)
                              ],
                            )
                          ]))))
        ],
      ));
    })));
  }
}
