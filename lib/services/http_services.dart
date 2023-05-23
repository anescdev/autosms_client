import 'dart:io';

import 'package:autosms_client/services/http_dtos.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class HttpService {
  late dio.Dio _httpClient;
  late PersistCookieJar _cookieJar;
  HttpService() {
    _httpClient = dio.Dio(dio.BaseOptions(
        baseUrl: "http://10.0.2.2:7654",
        connectTimeout: const Duration(seconds: 8),
        receiveTimeout: const Duration(seconds: 10)));
  }
  Future<void> setupCookieManager() async {
    final Directory path = await getApplicationSupportDirectory();
    _cookieJar = PersistCookieJar(
        ignoreExpires: true, storage: FileStorage("${path.path}/.cks"));
    _httpClient.interceptors.add(CookieManager(_cookieJar));
  }

  Future<bool> auth(String username, String password) async {
    try {
      const String dir = "/auth";
      dio.Response res = await _httpClient
          .post(dir, data: {"username": username, "password": password});
      if (res.statusCode == 200) {
        return true;
      }
      return false;
    } on dio.DioError catch (e) {
      if (e.response != null) {
        Get.snackbar("Error", e.response!.data);
      } else {
        Get.snackbar(
            "Error", "Hubo un error al intentar conectar con el servidor");
        print(e);
      }
      return false;
    }
  }

  Future<DashboardDto?> getDashboardValues() async {
    try {
      dio.Response res = await _httpClient.get("/dashboard-data");
      return DashboardDto.fromJson(res.data["dashboardData"]);
    } on dio.DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          Get.snackbar("Error", "La sesión caducó o no existe");
          return DashboardDto(
              messagesCount: null,
              contactsCount: null,
              activeSubscription: null,
              nextPayDate: null,
              userName: null);
        }
      } else {
        Get.snackbar(
            "Error", "Hubo un error al intentar conectar con el servidor");
        print(e);
      }
    }
    return null;
  }

  Future<bool> checkAuth() async {
    try {
      await _httpClient.get("/check-auth");
      print(await _cookieJar
          .loadForRequest(Uri.parse(_httpClient.options.baseUrl)));
      dio.Response res = await _httpClient.get("/check-auth");
      if (res.statusCode == 200) return true;
      return false;
    } on dio.DioError catch (e) {
      if (e.response != null) {
        print(e);
        print(e.response);
      } else {
        Get.snackbar(
            "Error", "Hubo un error al intentar conectar con el servidor");
      }
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      dio.Response res = await _httpClient.get("/logout");
      if (res.statusCode == 200) {
        Get.snackbar("Sesión cerrada", "La sesión se cerró correctamente");
        return true;
      }
      return false;
    } on dio.DioError catch (e) {
      if (e.response != null) {
        Get.snackbar("Error", "No se pudo cerrar la sesión");
      } else {
        Get.snackbar(
            "Error", "Hubo un error al intentar conectar con el servidor");
      }
      return false;
    }
  }
}
