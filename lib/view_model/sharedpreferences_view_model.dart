import 'package:flutter/foundation.dart';
import 'package:ows_bigcareer/model/shared_preference/shared_preferens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ows_bigcareer/model/models/model_app_user.dart';
import 'package:ows_bigcareer/model/models/model_search_job.dart';
class SharedPreferencesVM extends ChangeNotifier {
  AppPreferences appPreferences;

  SharedPreferencesVM({required this.appPreferences});

  late String userLanguage;
  late AppUser userDetails;
  late ModelSearchJob searchDetails;
  late int userType;
  late int freelancerUserType;
  late bool userLoginStatus;
  late List<String> userRecentSearches;
  late List<String> jobMatchList;
  late SharedPreferences sharedPreferences;
  late String mobile;

  String get getUserMobile =>appPreferences.userMobile;


  Future<void> setJobSearchDetails(ModelSearchJob searchJob) async {
    print('setJobSearchDetails ${searchJob.toJson()}');
    await appPreferences.addJobSearchDetails(searchJob);
  }

  Future<ModelSearchJob> getJobSearchDetails() async {
    searchDetails = await appPreferences.fetchJobSearchDetails();
    print('-getJobSearchDetails---------------${searchDetails.toJson()}');
    return searchDetails;
  }

  SharedPreferences getSharedPreference() {
    sharedPreferences = appPreferences.fetchSharedPreferences();
    return sharedPreferences;
  }

  Future<void> setJobMatchList(List<String> list) async {
    await appPreferences.addMatchList(list);
  }

  Future<List<String>> getJobMatchList() async {
    jobMatchList = await appPreferences.fetchMatchList();
    return jobMatchList;
  }

  Future<void> removeJobMatchList() async {
    await appPreferences.deleteMatchList();
  }

  Future<void> setRecentSearches(String searchText) async {
    await appPreferences.addRecentSearchesText(searchText);
  }

  Future<List<String>> getRecentSearches() async {
    userRecentSearches = await appPreferences.fetchRecentSearches();
    return userRecentSearches;
  }

  Future<void> removeRecentSearches() async {
    await appPreferences.deleteRecentSearches();
  }

  Future<void> setSkillsSearches(String searchText) async {
    await appPreferences.addSkillsSearchesText(searchText);
  }

  Future<List<String>> getSkillsSearches() async {
    userRecentSearches = await appPreferences.fetchSkillsSearches();
    return userRecentSearches;
  }

  Future<void> removeSkillsSearches() async {
    await appPreferences.deleteSkillsSearches();
  }

  Future<void> removeSkillsSearchesValue(String value) async {
    print('-removeSkillsSearchesValue---------------${value}');
    await appPreferences.deleteSkillsSearchesValue(value);
  }

  Future<void> setUserDetails(AppUser userDetails) async {
    await appPreferences.addUserDetails(userDetails);
  }

  Future<AppUser> getUserDetails() async {
    userDetails = await appPreferences.fetchUserDetails();
    return userDetails;
  }



  Future<void> setUserLanguage(String newUserLanguage) async {
    await appPreferences.addUserLanguage(newUserLanguage);
    userLanguage = newUserLanguage;
  }

  Future<String> getUserLanguage() async {
    userLanguage = await appPreferences.fetchUserLanguage();
    return userLanguage;
  }

  Future<void> setLoginStatus(bool status) async {
    await appPreferences.addLoginStatus(status);
  }

  Future<bool> getLoginStatus() async {
    userLoginStatus = await appPreferences.fetchLoginStatus();
    return userLoginStatus;
  }

  Future<void> setFreelancerLoginStatus(bool status) async {
    await appPreferences.addFreelancerLoginStatus(status);
  }

  Future<bool> getFreelancerLoginStatus() async {
    userLoginStatus = await appPreferences.fetchFreelancerLoginStatus();
    return userLoginStatus;
  }

  Future<void> setUserType(int type) async {
    await appPreferences.addUserType(type);
    userType = type;
  }

  Future<int> getUserType() async {
    userType = await appPreferences.fetchUserType();
    return userType;
  }

  Future<void> setFreelancerUserType(int type) async {
    await appPreferences.addFreelancerUserType(type);
    freelancerUserType = type;
  }

  Future<int> getFreelanceUserType() async {
    freelancerUserType = await appPreferences.fetchFreelancerUserType();
    return freelancerUserType;
  }
}
