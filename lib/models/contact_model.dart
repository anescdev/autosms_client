import 'package:autosms_client/models/manager_element_model.dart';
import 'package:dio/dio.dart';

import '../services/http_services.dart';

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
  static Future<List<Contact>> getAll(int limit, int offset) async {
    List<Contact> contactsFounded = [];
    try {
      for (var actJsonContact in (await HttpService.instance.httpClient.get(
              "/contacts",
              queryParameters: Map.fromEntries(
                  [MapEntry("limit", limit), MapEntry("offset", offset)])))
          .data["contacts"]) {
        contactsFounded.add(Contact.fromJson(actJsonContact));
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) HttpService.instance.show401Error();
      } else {
        HttpService.instance.show5xxError();
      }
    }
    return contactsFounded;
  }
}
