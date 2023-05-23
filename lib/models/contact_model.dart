import 'package:autosms_client/models/manager_element_model.dart';

class Contact extends ManagerElement {
  String? lastName;
  String phoneNumber;
  String email;
  Contact(
      {required super.id,
      required super.name,
      this.lastName,
      required this.phoneNumber,
      required this.email});
  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
        id: json["_id"],
        name: json["name"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        email: json["email"]);
  }
}
