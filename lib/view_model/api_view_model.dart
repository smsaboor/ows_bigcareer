import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ows_bigcareer/model/apis/api_response.dart';
import 'package:ows_bigcareer/model/repository.dart';

class ApiViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');
  ApiResponseJobHomePage _apiResponseJobsHomePage = ApiResponseJobHomePage.initial('Empty data');
  ApiResponseLatestJobHomePage _apiResponseLatestJobs = ApiResponseLatestJobHomePage.initial('Empty data');
  ApiResponse2 _apiResponse2 = ApiResponse2.initial('Empty data');
  ApiResponse3 _apiResponse3 = ApiResponse3.initial('Empty data');
  ApiResponseFreelancer _apiResponseFreelancer = ApiResponseFreelancer.initial('Empty data');
  ApiResponseJobs _apiResponseAppliedJobs = ApiResponseJobs.initial('Empty data');
  ApiResponseJobSearchKeywords _apiFetchJobSearchKeywords = ApiResponseJobSearchKeywords.initial('Empty data');
  ApiResponseJobSearch _apiFetchJobSearch = ApiResponseJobSearch.initial('Empty data');
  ApiResponseFilterJob _apiFetchFilterJob = ApiResponseFilterJob.initial('Empty data');
  ApiResponseProjects _apiResponseProjects = ApiResponseProjects.initial('Empty data');
  dynamic _data;
  ApiResponseJobHomePage get responseJobHomePage {
    return _apiResponseJobsHomePage;
  }
  ApiResponseLatestJobHomePage get responseLatestJobHomePage {
    return _apiResponseLatestJobs;
  }
  ApiResponseFilterJob get responseFilterJob {
    return _apiFetchFilterJob;
  }
  ApiResponseJobSearchKeywords get responseJobSearchKeywords {
    return _apiFetchJobSearchKeywords;
  }
  ApiResponseJobSearch get responseJobSearch {
    return _apiFetchJobSearch;
  }
  ApiResponseJobs get responseAppliedJob {
    return _apiResponseAppliedJobs;
  }
  ApiResponse3 get response3 {
    return _apiResponse3;
  }
  ApiResponse2 get response2 {
    return _apiResponse2;
  }
  ApiResponse get response {
    return _apiResponse;
  }
  ApiResponseFreelancer get responseFreelancer {
    return _apiResponseFreelancer;
  }
  ApiResponseProjects get responseProjects {
    return _apiResponseProjects;
  }
  dynamic get data {
    return _data;
  }
  Future<void> fetchDataFilterJob(object,String value, var body) async {
    _apiFetchFilterJob = ApiResponseFilterJob.loading('Fetching $value data');
    notifyListeners();
    try {
      print('---fetchDataFilterJob---1-----');
      List<dynamic> dataList = await Repository().fetchDataList(object,value,body);
      print('---fetchDataFilterJob--2---${dataList.length}---');
      _apiFetchFilterJob = ApiResponseFilterJob.completed(dataList);
    } catch (e) {
      print('---fetchDataFilterJob---3-----');
      _apiFetchFilterJob = ApiResponseFilterJob.error(e.toString());
    }
    notifyListeners();
  }
  Future<void> fetchDataJobSearch(object,String value, var body) async {
    _apiFetchJobSearch = ApiResponseJobSearch.loading('Fetching $value data');
    notifyListeners();
    try {
      print('---fetchDataJobSearch---1-----');
      List<dynamic> dataList = await Repository().fetchDataList(object,value,body);
      print('---fetchDataJobSearch--2---${dataList.length}---');
      _apiFetchJobSearch = ApiResponseJobSearch.completed(dataList);
    } catch (e) {
      print('---fetchDataJobSearch---3-----');
      _apiFetchJobSearch = ApiResponseJobSearch.error(e.toString());
    }
    notifyListeners();
  }
  Future<void> fetchData(object,String value, var body) async {
    _apiResponse = ApiResponse.loading('Fetching $value data');
    notifyListeners();
    try {
      List<dynamic> dataList = await Repository().fetchDataList(object,value,body);
      _apiResponse = ApiResponse.completed(dataList);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }
  Future<void> fetchDataJobsHomePage(object,String value, var body) async {
    _apiResponseJobsHomePage = ApiResponseJobHomePage.loading('Fetching $value data');
    notifyListeners();
    try {
      List<dynamic> dataList = await Repository().fetchDataList(object,value,body);
      _apiResponseJobsHomePage = ApiResponseJobHomePage.completed(dataList);
    } catch (e) {
      _apiResponseJobsHomePage = ApiResponseJobHomePage.error(e.toString());
      print(e);
    }
    notifyListeners();
  }
  Future<void> fetchDataHomePageLatestJobs(object,String value, var body) async {
    _apiResponseLatestJobs = ApiResponseLatestJobHomePage.loading('Fetching $value data');
    notifyListeners();
    try {
      List<dynamic> dataList = await Repository().fetchDataList(object,value,body);
      _apiResponseLatestJobs = ApiResponseLatestJobHomePage.completed(dataList);
    } catch (e) {
      _apiResponseLatestJobs = ApiResponseLatestJobHomePage.error(e.toString());
      print(e);
    }
    notifyListeners();
  }
  Future<void> fetchDataAppliedJobs(object,String value, var body) async {
    _apiResponseAppliedJobs = ApiResponseJobs.loading('Fetching $value data');
    notifyListeners();
    try {
      List<dynamic> dataList = await Repository().fetchDataList(object,value,body);
      _apiResponseAppliedJobs = ApiResponseJobs.completed(dataList);
    } catch (e) {
      _apiResponseAppliedJobs = ApiResponseJobs.error(e.toString());
      print(e);
    }
    notifyListeners();
  }
  Future<void> fetchJobSearchKeywords(object,String value, var body) async {
    _apiFetchJobSearchKeywords = ApiResponseJobSearchKeywords.loading('Fetching $value data');
    notifyListeners();
    try {
      List<dynamic> dataList = await Repository().fetchDataList(object,value,body);
      _apiFetchJobSearchKeywords = ApiResponseJobSearchKeywords.completed(dataList);
    } catch (e) {
      _apiFetchJobSearchKeywords = ApiResponseJobSearchKeywords.error(e.toString());
      print(e);
    }
    notifyListeners();
  }
  Future<void> fetchDataTwo(object,String value, var body) async {
    _apiResponse2 = ApiResponse2.loading('Fetching $value data');
    notifyListeners();
    try {
      List<dynamic> dataList = await Repository().fetchDataResponse(object,value,body);
      _apiResponse2 = ApiResponse2.completed(dataList);
    } catch (e) {
      _apiResponse2 = ApiResponse2.error(e.toString());
    }
    notifyListeners();
  }
  Future<void> fetchDataThree(object,String value, var body) async {
    _apiResponse3 = ApiResponse3.loading('Fetching $value data');
    notifyListeners();
    try {
      List<dynamic> dataList = await Repository().fetchDataResponse(object,value,body);
      _apiResponse3 = ApiResponse3.completed(dataList);
    } catch (e) {
      _apiResponse3 = ApiResponse3.error(e.toString());
      print(e);
    }
    notifyListeners();
  }
  Future<void> fetchDataFreelancer(object,String value, var body) async {
    _apiResponseFreelancer = ApiResponseFreelancer.loading('Fetching $value data');
    notifyListeners();
    try {
      List<dynamic> dataList = await Repository().fetchDataList(object,value,body);
      _apiResponseFreelancer = ApiResponseFreelancer.completed(dataList);
    } catch (e) {
      _apiResponseFreelancer = ApiResponseFreelancer.error(e.toString());
      print(e);
    }
    notifyListeners();
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
