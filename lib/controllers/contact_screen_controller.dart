import 'package:get/get.dart';

enum ManagerElementType { contact, group }

class ContactScreenController extends GetxController {
  Rx<ManagerElementType> typeElement = ManagerElementType.contact.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void onFilterChange(Set<ManagerElementType> value) {
    typeElement.value = value.first;
  }
}
