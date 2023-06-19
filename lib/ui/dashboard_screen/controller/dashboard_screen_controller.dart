import 'package:autosms_client/services/http_dtos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../services/http_services.dart';

class DashboardScreenController extends GetxController {
  late ThemeData theme;
  late TextStyle title;
  late TextStyle number;
  late TextStyle comment;
  RxBool loading = true.obs;
  RxInt messagesCount = 0.obs;
  RxInt contactCount = 0.obs;
  RxBool subscription = true.obs;
  RxString nameProfile = "Nombre".obs;
  late DateTime date = DateTime.now().add(const Duration(days: 30));
  @override
  void onInit() async {
    super.onInit();
    title =
        GoogleFonts.sourceSansPro(fontSize: 32.0, fontWeight: FontWeight.bold);
    number =
        GoogleFonts.sourceSansPro(fontSize: 22.0, fontWeight: FontWeight.bold);
    comment =
        GoogleFonts.sourceSansPro(fontSize: 18.0, fontWeight: FontWeight.bold);
    theme = Get.theme;
    DashboardDto? data = await HttpService.instance.getDashboardValues();
    if (data != null) {
      if (data.nodata()) {
        //Get.offAll(const LoginScreen(), binding: LoginBindings());
      } else {
        messagesCount.value = data.messagesCount!;
        contactCount.value = data.contactsCount!;
        subscription.value = data.activeSubscription!;
        nameProfile.value = data.userName!;
        loading.value = false;
      }
    }
  }

  String getDate() {
    return "${date.day}/${date.month}/${date.year}";
  }
}
