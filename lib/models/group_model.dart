import 'package:autosms_client/models/contact_model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

import '../services/http_services.dart';
import 'manager_element_model.dart';

class Group extends ManagerElement {
  List<Contact> groupElements;
  int members;
  Group(
      {required super.id,
      required super.name,
      this.members = 0,
      required this.groupElements});
  factory Group.fromJson(Map<String, dynamic> json) {
    List<Contact> groupsElements = [];
    for (var actJson in json["groupElements"]) {
      if (actJson is Map<String, dynamic>) {
        groupsElements.add(Contact.fromJson(actJson));
      }
    }
    return Group(
        id: json["_id"],
        name: json["name"],
        members: json["groupElements"].length,
        groupElements: groupsElements);
  }
  @override
  Map<String, dynamic> toJson(bool excludeId) {
    Map<String, dynamic> json = {};
    if (!excludeId) json["_id"] = id;
    json["name"] = name;
    json["groupElements"] = [];
    for (var actContact in groupElements) {
      json["groupElements"].add(actContact.id);
    }
    return json;
  }

  @override
  Future<bool> deleteManagerElement() async {
    try {
      Map<String, dynamic> body = {"idManager": id};
      dio.Response res =
          await HttpService.instance.httpClient.delete("/group", data: body);
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

  Future<String?> addGroup() async {
    try {
      Map<String, dynamic> body = {"group": toJson(true)};
      dio.Response res =
          await HttpService.instance.httpClient.post("/group", data: body);
      if (res.statusCode == 201) return res.data as String;
    } on dio.DioError catch (e) {
      if (e.response != null) {
        switch (e.response!.statusCode) {
          case 401:
            HttpService.instance.show401Error();
            break;
          case 500:
            Get.snackbar("Error", "No se pudo crear el grupo");
            break;
          default:
            HttpService.instance.showNotConsideredError();
            print(e.response);
        }
      } else {
        HttpService.instance.show5xxError();
      }
    }
    return null;
  }

  static Future<List<Group>> getAll(int limit, int offset) async {
    List<Group> groupsFounded = [];
    try {
      for (var actJsonGroup in (await HttpService.instance.httpClient.get(
              "/groups",
              queryParameters: Map.fromEntries(
                  [MapEntry("limit", limit), MapEntry("offset", offset)])))
          .data["groups"]) {
        groupsFounded.add(Group.fromJson(actJsonGroup));
      }
    } on dio.DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) HttpService.instance.show401Error();
      } else {
        HttpService.instance.show5xxError();
      }
    }
    return groupsFounded;
  }
}
