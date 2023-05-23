import 'package:autosms_client/controllers/messages_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagesScreen extends GetView<MessagesScreenController> {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Mensajes")),
    );
  }
}
