import 'package:autosms_client/bindings/bindings.dart';
import 'package:autosms_client/models/email_model.dart';
import 'package:autosms_client/models/message_model.dart';
import 'package:autosms_client/models/sms_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';
import '../controller/messages_screen_controller.dart';
import 'add_message_screen.dart';

class MessagesScreen extends GetView<MessagesScreenController> {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            children: [
              Obx(() {
                return SegmentedButton<MessageType>(
                  segments: [
                    ButtonSegment<MessageType>(
                        value: MessageType.all,
                        label: const Text("Todos"),
                        icon: const Icon(Icons.all_inbox),
                        enabled: !controller.loading.value),
                    ButtonSegment<MessageType>(
                        value: MessageType.email,
                        label: const Text("Email"),
                        icon: const Icon(Icons.email),
                        enabled: !controller.loading.value),
                    ButtonSegment<MessageType>(
                        value: MessageType.sms,
                        label: const Text("SMS"),
                        icon: const Icon(Icons.sms),
                        enabled: !controller.loading.value)
                  ],
                  style: controller.theme.segmentedButtonTheme.style,
                  selected: <MessageType>{controller.typeElement.value},
                  onSelectionChanged: controller.onFilterChange,
                );
              }),
              const Divider(),
              Expanded(child: Obx(() {
                if (controller.loading.isTrue) {
                  return const CircularProgressIndicator();
                }
                return Obx(() {
                  if (controller.typeElement.value == MessageType.all) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        Message actElement =
                            controller.founded.elementAt(index);
                        return Obx(
                          () => ListTile(
                            leading: Icon(
                                actElement is Email ? Icons.email : Icons.sms),
                            title: Text(actElement is Email
                                ? actElement.subject
                                : actElement.updateDate.toString()),
                            trailing: Utils.getIcon(actElement),
                            onTap: () => controller.onTap(actElement),
                            onLongPress: () =>
                                controller.onLongPress(actElement),
                            selected: controller.selected.contains(actElement),
                            selectedTileColor:
                                controller.selected.contains(actElement)
                                    ? Colors.grey.withOpacity(0.1)
                                    : null,
                            style: controller.theme.listTileTheme.style,
                          ),
                        );
                      },
                      itemCount: controller.founded.length,
                    );
                  } else if (controller.typeElement.value ==
                      MessageType.email) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        Message actElement =
                            controller.founded.elementAt(index);
                        if (actElement is Email) {
                          return Obx(
                            () => ListTile(
                              leading: const Icon(Icons.email),
                              title: Text(actElement.subject),
                              trailing: Utils.getIcon(actElement),
                              onTap: () => controller.onTap(actElement),
                              onLongPress: () =>
                                  controller.onLongPress(actElement),
                              selected:
                                  controller.selected.contains(actElement),
                              selectedTileColor:
                                  controller.selected.contains(actElement)
                                      ? Colors.grey.withOpacity(0.1)
                                      : null,
                              style: controller.theme.listTileTheme.style,
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                      itemCount: controller.founded.length,
                    );
                  }
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      Message actElement = controller.founded.elementAt(index);
                      if (actElement is SmsMessage) {
                        return Obx(
                          () => ListTile(
                            leading: const Icon(Icons.sms),
                            title: Text(actElement.updateDate.toString()),
                            trailing: Utils.getIcon(actElement),
                            onLongPress: () =>
                                controller.onLongPress(actElement),
                            onTap: () => controller.onTap(actElement),
                            selected: controller.selected.contains(actElement),
                            selectedTileColor:
                                controller.selected.contains(actElement)
                                    ? Colors.grey.withOpacity(0.1)
                                    : null,
                            style: controller.theme.listTileTheme.style,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                    itemCount: controller.founded.length,
                  );
                });
              }))
            ],
          ),
        ),
        floatingActionButton: Obx(() {
          if (controller.selected.isNotEmpty) {
            return FloatingActionButton(
              onPressed: () {},
              heroTag: "sendBtn",
              child: const Icon(Icons.send),
            );
          }
          return FloatingActionButton(
            onPressed: controller.toCreateAction,
            heroTag: "addBtn",
            child: const Icon(Icons.add),
          );
        }));
  }
}
