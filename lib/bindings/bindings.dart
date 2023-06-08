import 'package:autosms_client/ui/contact_screen/controller/add_contact_screen_controller.dart';
import 'package:autosms_client/ui/contact_screen/controller/add_group_screen_controller.dart';
import 'package:autosms_client/ui/profile_screen/controller/modify_profile_screen_controller.dart';
import 'package:get/get.dart';

import '../ui/contact_screen/controller/contact_screen_controller.dart';
import '../ui/contact_screen/controller/view_contact_screen_controller.dart';
import '../ui/contact_screen/controller/view_group_screen_controller.dart';
import '../ui/dashboard_screen/controller/dashboard_screen_controller.dart';
import '../ui/home_screen/controller/home_screen_controller.dart';
import '../ui/login_screen/controller/login_screen_controller.dart';
import '../ui/messages_screen/controller/messages_screen_controller.dart';
import '../ui/profile_screen/controller/profile_screen_controller.dart';

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

class ContactBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddContactScreenController());
  }
}

class ContactViewBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ViewContactScreenController());
  }
}

class GroupViewBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ViewGroupScreenController());
  }
}

class GroupBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddGroupScreenController());
  }
}

class ModifyProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ModifyProfileScreenController());
  }
}
