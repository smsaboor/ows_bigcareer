import 'dart:convert';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:ows_bigcareer/model/apis/app_exception.dart';
import 'package:ows_bigcareer/model/services/base_service.dart';

class ApiService extends BaseService {
  @override
  Future getApiResponse(String url,var body) async {
    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(baseUrl+url),body: body);
      print('---getApiResponse----returnResponse  ------${response}');
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @visibleForTesting
  dynamic returnResponse(http.Response response) {
    print('-------returnResponse  ------${response.statusCode}');
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }
}
