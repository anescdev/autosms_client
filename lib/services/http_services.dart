import 'dart:io';

import 'package:autosms_client/models/contact_model.dart';
import 'package:autosms_client/models/email_model.dart';
import 'package:autosms_client/models/manager_element_model.dart';
import 'package:autosms_client/models/sms_model.dart';
import 'package:autosms_client/services/http_dtos.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../models/group_model.dart';
import '../models/message_model.dart';

class HttpService {
  late final dio.Dio httpClient;
  static final HttpService instance = HttpService._();
  late PersistCookieJar _cookieJar;
  HttpService._() {
    httpClient = dio.Dio(dio.BaseOptions(
        baseUrl: "http://10.0.2.2:7654",
        connectTimeout: const Duration(seconds: 8),
        receiveTimeout: const Duration(seconds: 10)));
  }
  Future<void> setupCookieManager() async {
    final Directory path = await getApplicationSupportDirectory();
    _cookieJar = PersistCookieJar(
        ignoreExpires: true, storage: FileStorage("${path.path}/.cks"));
    httpClient.interceptors.add(CookieManager(_cookieJar));
  }

  void show5xxError() {
    Get.snackbar("Error", "Hubo un error al intentar conectar con el servidor");
  }

  void showNotConsideredError() {
    Get.snackbar("Error", "No se tuvo en cuenta este código de error");
  }

  void show400Error() {
    Get.snackbar("Error", "Hubo un error con los datos enviados");
  }

  void show401Error() {
    Get.snackbar("Error", "La sesión caducó o no existe");
  }

  void show404Error() {
    Get.snackbar("Error", "Elemento no encontrado");
  }

  Future<bool> auth(String username, String password) async {
    try {
      const String dir = "/auth";
      dio.Response res = await httpClient
          .post(dir, data: {"username": username, "password": password});
      if (res.statusCode == 200) {
        return true;
      }
      return false;
    } on dio.DioError catch (e) {
      if (e.response != null) {
        Get.snackbar("Error", e.response!.data);
      } else {
        show5xxError();
        print(e);
      }
      return false;
    }
  }

  Future<DashboardDto?> getDashboardValues() async {
    try {
      dio.Response res = await httpClient.get("/dashboard-data");
      return DashboardDto.fromJson(res.data["dashboardData"]);
    } on dio.DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          show401Error();
          return DashboardDto(
              messagesCount: null,
              contactsCount: null,
              activeSubscription: null,
              nextPayDate: null,
              userName: null);
        }
      } else {
        show5xxError();
        print(e);
      }
    }
    return null;
  }

  Future<bool> checkAuth() async {
    try {
      await httpClient.get("/check-auth");
      await _cookieJar.loadForRequest(Uri.parse(httpClient.options.baseUrl));
      dio.Response res = await httpClient.get("/check-auth");
      if (res.statusCode == 200) return true;
      return false;
    } on dio.DioError catch (e) {
      if (e.response != null) {
      } else {
        show5xxError();
        print(e);
      }
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      dio.Response res = await httpClient.get("/logout");
      if (res.statusCode == 200) {
        Get.snackbar("Sesión cerrada", "La sesión se cerró correctamente");
        return true;
      }
      return false;
    } on dio.DioError catch (e) {
      if (e.response != null) {
        Get.snackbar("Error", "No se pudo cerrar la sesión");
      } else {
        show5xxError();
        print(e);
      }
      return false;
    }
  }

  Future<List<Message>?> getMessages(int limit, offset) async {
    try {
      List<Message> msgs = [];
      dio.Response res = await httpClient.get("/messages",
          queryParameters: {"limit": limit, "offset": offset});
      for (var actJson in res.data["messages"]) {
        List<ManagerElement> managerElementList =
            actJson["receptors"].map<ManagerElement>((e) {
          if ((e["__t"] as String).compareTo("Contact") == 0) {
            return Contact.fromJson(e);
          } else {
            return Group.fromJson(e);
          }
        }).toList();
        if ((actJson["__t"] as String).compareTo("Email") == 0) {
          msgs.add(Email.fromJson(actJson));
        } else {
          msgs.add(SmsMessage.fromJson(actJson));
        }
      }
      return msgs;
    } on dio.DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 404) {
          show404Error();
        } else {
          showNotConsideredError();
        }
      }
    }
    return null;
  }
}
