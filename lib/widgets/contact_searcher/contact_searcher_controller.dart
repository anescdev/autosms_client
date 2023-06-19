import 'package:autosms_client/models/group_model.dart';
import 'package:autosms_client/models/manager_element_model.dart';
import 'package:get/get.dart';

import '../../models/contact_model.dart';

class ContactSearcherController extends GetxController {
  ContactSearcherController(
      {required this.selected,
      this.readOnly = false,
      required this.founded,
      required this.includeGroups});
  final RxList<ManagerElement> selected;
  bool readOnly;
  bool includeGroups;
  RxBool hasVal = false.obs;
  RxBool notFound = false.obs;
  RxBool isSearching = false.obs;
  String val = "";
  final RxList<ManagerElement> founded;
  final int limit = 25;
  int offset = 0;

  @override
  void onInit() {
    super.onInit();
    if (readOnly) {}
  }

  void onComplete() async {
    founded.removeWhere((element) => !selected.contains(element));
    if (val.isNotEmpty) {
      isSearching.value = true;
      hasVal.value = true;
      List<Contact> list = await Contact.getAllByName(limit, offset, val);
      List<Group> group = [];
      if (includeGroups) {
        group = await Group.getAllByName(limit, offset, val);
      }
      if (list.isEmpty && group.isEmpty) {
        notFound.value = true;
      } else {
        for (var actContact in selected) {
          list.removeWhere((element) => element.id == actContact.id);
          group.removeWhere((element) => element.id == actContact.id);
        }
        founded.addAll(list);
        if (includeGroups) founded.addAll(group);
        notFound.value = false;
      }
      isSearching.value = false;
    } else {
      hasVal.value = false;
    }
  }
}
