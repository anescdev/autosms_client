import 'package:autosms_client/bindings/bindings.dart';
import 'package:autosms_client/ui/profile_screen/screen/modify_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/profile_model.dart';

class ProfileScreenController extends GetxController {
  Rx<Profile?> profile = Rx(null);
  RxString composedName = "".obs;
  late RxString phone = "".obs;
  late RxString email = "".obs;
  ThemeData theme = Get.theme;
  @override
  void onInit() async {
    super.onInit();
    profile.value = await Profile.getProfile();
    updateVals();
  }

  void modify() async {
    Map<String, dynamic> args = {"valid": false, "profile": profile.value};
    await Get.to(() => const ModifyProfileScreen(),
        binding: ModifyProfileBindings(), arguments: args);
    if (args["valid"]) updateVals();
  }

  void updateVals() {
    composedName.value = profile.value!.name;
    if (profile.value!.lastName.isNotEmpty) {
      composedName.value += " ${profile.value!.lastName}";
    }
    phone.value = profile.value!.cellNumber;
    email.value = profile.value!.email;
  }
}
