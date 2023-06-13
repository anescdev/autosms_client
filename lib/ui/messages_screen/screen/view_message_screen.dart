import 'package:autosms_client/models/email_model.dart';
import 'package:autosms_client/models/message_model.dart';
import 'package:autosms_client/widgets/contact_searcher/contact_searcher_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';
import '../controller/view_message_screen_controller.dart';

class ViewMessageScreen extends GetView<ViewMessageScreenController> {
  const ViewMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Información del ${controller.message is Email ? "email" : "SMS"}",
          style: Utils.textBold,
        ),
        actions: controller.message.state.value == MessageState.noEnviado
            ? [
                IconButton(
                    onPressed: controller.send, icon: const Icon(Icons.send))
              ]
            : [],
      ),
      body: Center(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ListTile(
              leading: Utils.getIcon(controller.message),
              title: const Text("Estado"),
              subtitle:
                  Text(controller.message.state.value == MessageState.noEnviado
                      ? "No enviado"
                      : controller.message.state.value == MessageState.enCola
                          ? "En cola"
                          : "Enviado"),
            ),
            const Divider(),
            controller.message is Email
                ? Column(
                    children: [
                      ListTile(
                          leading: const Icon(Icons.subject),
                          title: const Text("Asunto"),
                          subtitle:
                              Text((controller.message as Email).subject)),
                      const Divider(),
                    ],
                  )
                : const SizedBox.shrink(),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Remitente"),
              subtitle: Text(controller.message.emiter),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.groups),
              title: Text("Destinatiarios"),
            ),
            SizedBox(
                width: Utils.percentajeToPx(context.width, 90),
                child: ContactSearcher(
                    founded: controller.message.receptors.obs, readOnly: true)),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.description),
              title: Text("Mensaje"),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: Utils.percentajeToPx(context.width, 90),
                  maxHeight: Utils.percentajeToPx(context.height, 20)),
              child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Text(controller.message.message,
                      textAlign: TextAlign.left)),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.today),
              title: const Text("Última actualización"),
              subtitle:
                  Text(Utils.formatDate(controller.message.updateDate, true)),
            ),
            const Divider(),
            controller.message.sendDate != null
                ? ListTile(
                    leading: const Icon(Icons.today),
                    title: const Text("Fecha y hora de envío"),
                    subtitle: Text(
                        Utils.formatDate(controller.message.sendDate!, true)),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      )),
    );
  }
}
