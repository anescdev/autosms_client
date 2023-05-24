import 'package:autosms_client/bindings/bindings.dart';
import 'package:autosms_client/view/login_screen.dart';

import 'theme/color_schemes.g.dart';
import './theme/custom_color.g.dart';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './services/http_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpService.instance.setupCookieManager();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // final Directory supportDir;
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightScheme;
        ColorScheme darkScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightScheme = lightDynamic.harmonized();
          lightCustomColors = lightCustomColors.harmonized(lightScheme);

          // Repeat for the dark color scheme.
          darkScheme = darkDynamic.harmonized();
          darkCustomColors = darkCustomColors.harmonized(darkScheme);
        } else {
          // Otherwise, use fallback schemes.
          lightScheme = lightColorScheme;
          darkScheme = darkColorScheme;
        }

        return GetMaterialApp(
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: lightScheme,
              extensions: [lightCustomColors],
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: darkScheme,
              extensions: [darkCustomColors],
            ),
            //onInit: () => Get.put<HttpService>(HttpService()),
            title: "AutoSMS",
            initialBinding: LoginBindings(),
            home: const LoginScreen());
      },
    );
  }
}
