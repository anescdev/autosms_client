import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/group_model.dart';

class ViewGroupScreenController extends GetxController {
  ThemeData theme = Get.theme;
  Group actualGroup = Get.arguments;
  @override
  void onInit() {
    super.onInit();
    print(actualGroup.groupElements);
  }
}
