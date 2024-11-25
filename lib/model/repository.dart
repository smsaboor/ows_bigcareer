import 'package:ows_bigcareer/model/services/base_service.dart';
import 'package:ows_bigcareer/model/services/api_service.dart';

class Repository {
  final BaseService _apiService = ApiService();

  Future<List<dynamic>> fetchDataList(object, String url,var body) async {
    print('-fetchDataList--response33----------${object.runtimeType}');
    print('-fetchDataList--url:($url)-----object:${object.runtimeType}--------body:$body');
    dynamic response = await _apiService.getApiResponse(url,body);
    print('-fetchDataList--response----------$response');
    print('-fetchDataList--response----------end');
    final jsonData = response as List;
    print('-fetchDataList--response----------end2');
    print('-fetchDataList--response33----------${jsonData[0]}');
    print('-fetchDataList--response33----------${jsonData[0]['date_time']}');
    print('-fetchDataList--response33----------${jsonData[0]['date_time'].runtimeType}');
    List<dynamic> dataList = jsonData.map((tagJson) => object.fromJson(tagJson)).toList();
    print('-fetchDataList--response----------end3');
    print('-fetchDataList dataList url($url)---fetchDataList dataList runtimeType(${dataList.runtimeType})----------${dataList.length}');
    return dataList;
  }
  Future<List<dynamic>> fetchDataResponse(object, String url,var body) async {
    print('-fetchDataResponse($url)-------------$body');
    dynamic response = await _apiService.getApiResponse(url,body);
    print('-response($url)---fetchDataList(${object.runtimeType})----------$response');
    final jsonData = response['data'] as List;
    List<dynamic> dataList = jsonData.map((tagJson) => object.fromJson(tagJson)).toList();
    print('-dataList($url)---fetchDataList(${object.runtimeType})----------${dataList.length}');
    return dataList;
  }
}

































