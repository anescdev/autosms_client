import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/contact_model.dart';

class ViewContactScreenController extends GetxController {
  ThemeData theme = Get.theme;
  Contact actualContact = Get.arguments;
}
