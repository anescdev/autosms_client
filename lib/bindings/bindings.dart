import 'package:autosms_client/controllers/contact_screen_controller.dart';
import 'package:autosms_client/controllers/dashboard_screen_controller.dart';
import 'package:autosms_client/controllers/home_screen_controller.dart';
import 'package:autosms_client/controllers/login_screen_controller.dart';
import 'package:autosms_client/controllers/messages_screen_controller.dart';
import 'package:autosms_client/controllers/profile_screen_controller.dart';
import 'package:get/get.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginScreenController());
  }
}

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeScreenController());
    Get.lazyPut(() => DashboardScreenController());
    Get.lazyPut(() => MessagesScreenController());
    Get.lazyPut(() => ContactScreenController());
    Get.lazyPut(() => ProfileScreenController());
  }
}
