import 'package:autosms_client/models/manager_element_model.dart';
import 'package:autosms_client/ui/contact_screen/screen/add_contact_screen.dart';
import 'package:autosms_client/ui/contact_screen/screen/add_group_screen.dart';
import 'package:autosms_client/ui/dashboard_screen/controller/dashboard_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../bindings/bindings.dart';
import '../../../models/contact_model.dart';
import '../../../models/group_model.dart';

enum ManagerElementType { contact, group }

class ContactScreenController extends GetxController {
  Rx<ManagerElementType> typeElement = ManagerElementType.contact.obs;
  RxList<Group> groups = <Group>[].obs;
  RxList<Contact> contacts = <Contact>[].obs;
  int limitQuery = 25;
  int offsetGroup = 0;
  int offsetContact = 0;
  RxBool deleting = false.obs;
  RxBool loading = true.obs;
  RxList<ManagerElement> selected = <ManagerElement>[].obs;
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

  void goToCreateContact() async {
    Map<String, dynamic> arguments = {
      "valid": false,
      "contact": Contact(id: "", name: "", phoneNumber: "", email: "")
    };
    await Get.to(() => const AddContactScreen(),
        binding: ContactBindings(), arguments: arguments);
    if (arguments["valid"] == true) {
      contacts.add(arguments["contact"]);
      Get.find<DashboardScreenController>().contactCount.value++;
    }
  }

  void goToCreateGroup() async {
    Map<String, dynamic> arguments = {
      "valid": false,
      "group": Group(id: "", name: "", groupElements: [])
    };
    await Get.to(() => const AddGroupScreen(),
        binding: GroupBindings(), arguments: arguments);
    if (arguments["valid"] == true) {
      groups.add(arguments["group"]);
    }
  }

  void onFilterChange(Set<ManagerElementType> value) {
    typeElement.value = value.first;
    selected.clear();
  }

  void deleteContacts() async {
    int deleted = 0;
    Iterator<ManagerElement> iterator = selected.iterator;
    print(iterator.toString());
    while (selected.isNotEmpty && iterator.moveNext()) {
      if (await iterator.current.deleteManagerElement()) {
        contacts.remove(iterator.current);
        selected.remove(iterator.current);
        deleted += 1;
      }
    }
    groups.value = await Group.getAll(limitQuery, 0);
    Get.find<DashboardScreenController>().contactCount.value -= deleted;
    Get.back();
  }

  void deleteGroups() async {
    Iterator<ManagerElement> iterator = selected.iterator;
    while (selected.isNotEmpty && iterator.moveNext()) {
      if (await iterator.current.deleteManagerElement()) {
        groups.remove(iterator.current);
        selected.remove(iterator.current);
      }
    }
    Get.back();
  }
}
