import 'package:autosms_client/models/contact_model.dart';
import 'package:dio/dio.dart';
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
    return Group(
        id: json["_id"],
        name: json["name"],
        members: json["groupElements"].length,
        groupElements: json["groupElements"].length > 0 &&
                json["groupElements"][0] is String
            ? []
            : json["groupElements"]);
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
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) HttpService.instance.show401Error();
      } else {
        HttpService.instance.show5xxError();
      }
    }
    return groupsFounded;
  }
}
