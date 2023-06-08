import 'package:autosms_client/models/manager_element_model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

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
  @override
  Map<String, dynamic> toJson(bool excludeId) {
    Map<String, dynamic> json = {};
    if (!excludeId) json["_id"] = id;
    json["name"] = name;
    json["lastName"] = lastName;
    json["phoneNumber"] = phoneNumber;
    json["email"] = email;
    return json;
  }

  @override
  Future<bool> deleteManagerElement() async {
    try {
      Map<String, dynamic> body = {"idManager": id};
      dio.Response res =
          await HttpService.instance.httpClient.delete("/contact", data: body);
      if (res.statusCode == 200) return true;
    } on dio.DioError catch (e) {
      if (e.response != null) {
        switch (e.response!.statusCode) {
          case 401:
            HttpService.instance.show401Error();
            break;
          case 404:
            HttpService.instance.show404Error();
          default:
            HttpService.instance.showNotConsideredError();
            print(e.response);
        }
      } else {
        HttpService.instance.show5xxError();
      }
    }
    return false;
  }

  Future<String?> addContact() async {
    try {
      Map<String, dynamic> body = {"contact": toJson(true)};
      dio.Response res =
          await HttpService.instance.httpClient.post("/contact", data: body);
      if (res.statusCode == 201) return res.data as String;
    } on dio.DioError catch (e) {
      if (e.response != null) {
        switch (e.response!.statusCode) {
          case 401:
            HttpService.instance.show401Error();
            break;
          case 500:
            Get.snackbar("Error", "No se pudo crear el contacto");
            break;
          default:
            HttpService.instance.showNotConsideredError();
        }
      } else {
        HttpService.instance.show5xxError();
      }
    }
    return null;
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
    } on dio.DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) HttpService.instance.show401Error();
      } else {
        HttpService.instance.show5xxError();
      }
    }
    return contactsFounded;
  }

  static Future<List<Contact>> getAllByName(
      int limit, int offset, String name) async {
    List<Contact> contactsFounded = [];
    if (name.isNotEmpty) {
      try {
        for (var actJsonContact in (await HttpService.instance.httpClient.get(
                "/contacts",
                queryParameters: Map.fromEntries([
                  MapEntry("limit", limit),
                  MapEntry("offset", offset),
                  MapEntry("name", name)
                ])))
            .data["contacts"]) {
          contactsFounded.add(Contact.fromJson(actJsonContact));
        }
      } on dio.DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 401) {
            HttpService.instance.show401Error();
          }
        } else {
          HttpService.instance.show5xxError();
        }
      }
    }
    return contactsFounded;
  }
}
