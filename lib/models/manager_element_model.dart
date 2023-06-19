abstract class ManagerElement {
  String id;
  String name;
  ManagerElement({required this.id, required this.name});
  Map<String, dynamic> toJson(bool excludeId);
  Future<bool> deleteManagerElement();
}
