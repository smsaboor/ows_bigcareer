import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ows_bigcareer/model/apis/api_response.dart';
import 'package:ows_bigcareer/model/repository.dart';

class FreelancerViewModel with ChangeNotifier {
  ApiResponse _apiResponseFreelancer = ApiResponse.initial('Empty data');
  dynamic _data;
  ApiResponse get responseFreelancer {
    return _apiResponseFreelancer;
  }
  dynamic get data {
    return _data;
  }

  Future<void> fetchDataFreelancer(object,String value, var body) async {
    _apiResponseFreelancer = ApiResponse.loading('Fetching $value data');
    notifyListeners();
    try {
      List<dynamic> dataList = await Repository().fetchDataList(object,value,body);
      _apiResponseFreelancer = ApiResponse.completed(dataList);
    } catch (e) {
      _apiResponseFreelancer = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }

  void setData(dynamic data) {
    _data = data;
    notifyListeners();
  }

}
