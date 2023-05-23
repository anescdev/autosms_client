import 'dart:io';

import 'package:autosms_client/controllers/login_screen_controller.dart';
//import 'package:autosms_client/theme/custom_color.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginScreenController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          "Inicio de sesión",
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        body: Center(child: Obx(() {
          if (controller.loadingState.value) {
            return const CircularProgressIndicator();
          }
          return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Platform.isAndroid == true
                          ? "assets/fondo.jpg"
                          : "assets/fondo_2.jpg"),
                      fit: BoxFit.cover)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                        child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(
                                    bottom: 20.0, top: 20.0, right: 20.0),
                                child: const Image(
                                    image: AssetImage("assets/logo_150.png"),
                                    width: 80,
                                    height: 80)),
                            Flexible(
                                child: Text(
                                    "Hola, introduzca sus credenciales:",
                                    style: theme.textTheme.headlineSmall))
                          ],
                        ),
                        const Divider(),
                        Form(
                            key: controller.formKey,
                            child: Column(
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(
                                        top: 20.0, bottom: 8.0),
                                    child: TextFormField(
                                      controller: controller.userController,
                                      validator: controller.userValidator,
                                      decoration: const InputDecoration(
                                          labelText: "Usuario",
                                          border: OutlineInputBorder()),
                                    )),
                                Container(
                                    margin: const EdgeInsets.only(
                                        top: 8.0, bottom: 24.0),
                                    child: TextFormField(
                                      controller: controller.passController,
                                      validator: controller.userValidator,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                          labelText: "Contraseña",
                                          border: OutlineInputBorder()),
                                    )),
                                FilledButton(
                                    onPressed: controller.tryLogin,
                                    child: const Text("Iniciar sesión"))
                              ],
                            ))
                      ]),
                    )),
                  ]));
        })));
  }
}
