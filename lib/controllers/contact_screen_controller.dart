import 'package:autosms_client/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/group_manager.dart';

enum ManagerElementType { contact, group }

class ContactScreenController extends GetxController {
  Rx<ManagerElementType> typeElement = ManagerElementType.contact.obs;
  RxList<Group> groups = <Group>[].obs;
  RxList<Contact> contacts = <Contact>[].obs;
  int limitQuery = 25;
  int offsetGroup = 0;
  int offsetContact = 0;
  RxBool loading = true.obs;
  RxList<int> selected = <int>[].obs;
  ThemeData theme = Get.theme;
  @override
  void onInit() async {
    super.onInit();
    contacts.value = await Contact.getAll(limitQuery, offsetContact);
    offsetContact += limitQuery;
    groups.value = await Group.getAll(limitQuery, offsetGroup);
    offsetGroup += limitQuery;
    loading.value = false;
  }

  void onFilterChange(Set<ManagerElementType> value) {
    typeElement.value = value.first;
    selected.clear();
    print(selected);
  }
}
