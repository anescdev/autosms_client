import 'dart:typed_data';

import 'package:dio/dio.dart' as dio;

import '../services/http_services.dart';

class Profile {
  String id;
  String name;
  String lastName;
  String cellNumber;
  String email;
  Uint8List? photo;
  Profile(
      {required this.id,
      required this.name,
      required this.lastName,
      required this.cellNumber,
      required this.email,
      this.photo});
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
        id: json["profile"]["_id"],
        name: json["profile"]["name"],
        lastName: json["profile"]["lastName"],
        cellNumber: json["profile"]["cellNumber"],
        email: json["email"],
        photo: json["profile"].containsKey("photo")
            ? Uint8List.fromList(json["profile"]["photo"])
            : null);
  }
  static Future<Profile?> getProfile() async {
    try {
      dio.Response res = await HttpService.instance.httpClient.get("/profile");
      if (res.statusCode == 200) {
        return Profile.fromJson(res.data);
      }
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
    return null;
  }

  Future<bool> updateProfile(Profile newProfile) async {
    bool res = false;
    Map<String, dynamic> profileJson = {};
    if (name.compareTo(newProfile.name) != 0) {
      profileJson["name"] = newProfile.name;
    }
    if (lastName.compareTo(newProfile.lastName) != 0) {
      profileJson["lastName"] = newProfile.lastName;
    }
    if (cellNumber.compareTo(newProfile.cellNumber) != 0) {
      profileJson["cellNumber"] = newProfile.cellNumber;
    }
    try {
      res = (await HttpService.instance.httpClient
                  .put("/profile", data: {"profile": profileJson}))
              .statusCode ==
          200;
    } on dio.DioError catch (e) {
      if (e.response != null) {
        switch (e.response!.statusCode) {
          case 400:
            HttpService.instance.show400Error();
            break;
          default:
            HttpService.instance.showNotConsideredError();
            print(e.response);
        }
      } else {
        HttpService.instance.show5xxError();
      }
    }
    try {
      if (email.compareTo(newProfile.email) != 0) {
        res = res &&
            (await HttpService.instance.httpClient.put("/user", data: {
                  "user": {"email": newProfile.email}
                }))
                    .statusCode ==
                200;
      }
      return res;
    } on dio.DioError catch (e) {
      if (e.response != null) {
        switch (e.response!.statusCode) {
          case 404:
            HttpService.instance.show404Error();
            break;
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
}
