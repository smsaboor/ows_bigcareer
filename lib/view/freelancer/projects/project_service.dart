import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_package1/components.dart';
import 'package:ows_bigcareer/model/apis/urls.dart';

const baseURL = 'https://cabeloclinic.com/website/medlife/php_auth_api';

class DioServices {
  static Future<String> uploadImage(FormData data) async {
    try {
      print('-create1--------------${data}');
      Response response =
          await Dio().post("${API_BASE_URL}insert_image_api.php", data: data);
      print('-create2--------------${response.data}');
      print('-create2--------------${response.data.runtimeType}');
      // var json = jsonDecode(response.data);
      print('-create3--------------${json}');
      if (response.data['status'] == "1") {
        return response.data['image'];
      } else {
        return 'error image not loaded';
      }
    } catch (e) {
      return 'error exception';
    }
  }

  static Future<String> postData(FormData data) async {
    try {
      print('-postData1--------------${data.fields}');
      Response response = await Dio()
          .post("${API_BASE_URL}add_project_api.php", data: data)
          .timeout(const Duration(seconds: 10));
      print('-postData2--------------${response.data}');
      print('-postData3--------------${response.data.runtimeType}');
      if (response.data['status'] == "1") {
        return response.data['message'];
      } else {
        return 'error image not loaded';
      }
    } catch (e) {
      return 'error exception';
    }
  }

  static Future postDataFreelancer(String api, FormData data) async {
    try {
      Response response = await Dio()
          .post("$API_BASE_URL$api", data: data)
          .timeout(const Duration(seconds: 10));
      print('-postData2--------------${response.data}');
      return response.data[0];
    } catch (e) {
      showToast(msg: 'server error please try again!');
    }
  }
  static Future postDataFreelancer2(String api, FormData data) async {
    print('-postDataFreelancer2--------------${data.fields}');
    try {
      Response response = await Dio()
          .post("$API_BASE_URL$api", data: data)
          .timeout(const Duration(seconds: 10));
      print('-postData2--------------${response.data}');
      return response.data;
    } catch (e) {
      showToast(msg: 'error');
    }
  }
  static Future<dynamic> fetch() async {
    try {
      var response = await Dio()
          .get("$baseURL/profiles")
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        return response.data;
      } else {
        // AppSnack.showSnack('Login fail','Invalid pin');
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
