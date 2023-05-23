import 'manager_element_model.dart';

class Group extends ManagerElement {
  List<String> groupElements;
  Group({required super.id, required super.name, required this.groupElements});
  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
        id: json["_id"],
        name: json["name"],
        groupElements: json["groupElements"]);
  }
}
