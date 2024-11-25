import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ows_bigcareer/model/apis/api_response.dart';
import 'package:ows_bigcareer/model/repository.dart';

class JobsViewModel with ChangeNotifier {
  ApiResponse _apiResponseJobsHomePage = ApiResponse.initial('Empty data');
  ApiResponse _apiResponseLatestJobs = ApiResponse.initial('Empty data');
  ApiResponse _apiResponseAppliedJobs = ApiResponse.initial('Empty data');
  ApiResponse _apiFetchJobSearchKeywords = ApiResponse.initial('Empty data');
  ApiResponse _apiFetchJobSearch = ApiResponse.initial('Empty data');
  ApiResponse _apiFetchFilterJob = ApiResponse.initial('Empty data');

  dynamic _data;
  ApiResponse get responseJobHomePage {
    return _apiResponseJobsHomePage;
  }
  ApiResponse get responseLatestJobHomePage {
    return _apiResponseLatestJobs;
  }
  ApiResponse get responseFilterJob {
    return _apiFetchFilterJob;
  }
  ApiResponse get responseJobSearchKeywords {
    return _apiFetchJobSearchKeywords;
  }
  ApiResponse get responseJobSearch {
    return _apiFetchJobSearch;
  }
  ApiResponse get responseAppliedJob {
    return _apiResponseAppliedJobs;
  }

  dynamic get data {
    return _data;
  }
  Future<void> fetchDataFilterJob(object,String value, var body) async {
    _apiFetchFilterJob = ApiResponse.loading('Fetching $value data');
    notifyListeners();
    try {
      print('---fetchDataFilterJob---1-----');
      List<dynamic> dataList = await Repository().fetchDataList(object,value,body);
      print('---fetchDataFilterJob--2---${dataList.length}---');
      _apiFetchFilterJob = ApiResponse.completed(dataList);
    } catch (e) {
      print('---fetchDataFilterJob---3-----');
      _apiFetchFilterJob = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }
  Future<void> fetchDataJobSearch(object,String value, var body) async {
    _apiFetchJobSearch = ApiResponse.loading('Fetching $value data');
    notifyListeners();
    try {
      print('---fetchDataJobSearch---1-----');
      List<dynamic> dataList = await Repository().fetchDataList(object,value,body);
      print('---fetchDataJobSearch--2---${dataList.length}---');
      _apiFetchJobSearch = ApiResponse.completed(dataList);
    } catch (e) {
      print('---fetchDataJobSearch---3-----');
      _apiFetchJobSearch = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  Future<void> fetchDataJobsHomePage(object,String value, var body) async {
    _apiResponseJobsHomePage = ApiResponse.loading('Fetching $value data');
    notifyListeners();
    try {
      List<dynamic> dataList = await Repository().fetchDataList(object,value,body);
      _apiResponseJobsHomePage = ApiResponse.completed(dataList);
    } catch (e) {
      _apiResponseJobsHomePage = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }
  Future<void> fetchDataHomePageLatestJobs(object,String value, var body) async {
    _apiResponseLatestJobs = ApiResponse.loading('Fetching $value data');
    notifyListeners();
    try {
      List<dynamic> dataList = await Repository().fetchDataList(object,value,body);
      _apiResponseLatestJobs = ApiResponse.completed(dataList);
    } catch (e) {
      _apiResponseLatestJobs = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }
  Future<void> fetchDataAppliedJobs(object,String value, var body) async {
    _apiResponseAppliedJobs = ApiResponse.loading('Fetching $value data');
    notifyListeners();
    try {
      List<dynamic> dataList = await Repository().fetchDataList(object,value,body);
      _apiResponseAppliedJobs = ApiResponse.completed(dataList);
    } catch (e) {
      _apiResponseAppliedJobs = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }
  Future<void> fetchJobSearchKeywords(object,String value, var body) async {
    _apiFetchJobSearchKeywords = ApiResponse.loading('Fetching $value data');
    notifyListeners();
    try {
      List<dynamic> dataList = await Repository().fetchDataList(object,value,body);
      _apiFetchJobSearchKeywords = ApiResponse.completed(dataList);
    } catch (e) {
      _apiFetchJobSearchKeywords = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }

  void setData(dynamic data) {
    _data = data;
    notifyListeners();
  }

}
