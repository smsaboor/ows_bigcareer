import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ows_bigcareer/model/apis/api_response.dart';
import 'package:ows_bigcareer/model/repository.dart';

class ProjectsViewModel with ChangeNotifier {
  ApiResponseProjects _apiResponseProjects = ApiResponseProjects.initial('Empty data');
  dynamic _data;

  ApiResponseProjects get responseProjects {
    return _apiResponseProjects;
  }
  dynamic get data {
    return _data;
  }

  Future<void> fetchDataProjects(object,String value, var body) async {
    _apiResponseProjects = ApiResponseProjects.loading('Fetching $value data');
    notifyListeners();
    try {
      List<dynamic> dataList = await Repository().fetchDataList(object,value,body);
      _apiResponseProjects = ApiResponseProjects.completed(dataList);
    } catch (e) {
      _apiResponseProjects = ApiResponseProjects.error(e.toString());
      print(e);
    }
    notifyListeners();
  }
  void setData(dynamic data) {
    _data = data;
    notifyListeners();
  }

}
