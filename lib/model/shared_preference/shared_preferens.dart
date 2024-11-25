import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ows_bigcareer/model/models/model_app_user.dart';
import 'package:ows_bigcareer/model/models/model_search_job.dart';
class AppPreferences {
  static late SharedPreferences preferences;
  static const _keyUserDetails = 'userDetails';
  static const _keyjobSearch = 'jobSearch';
  static const _keyUserLanguage = 'userLanguage';
  static const _keyLogin = 'login';
  static const _keyFreelancerLogin = 'freelancerLogin';
  static const _keyUserType = 'userType';
  static const _keyFreelancerUserType = 'userType';
  static const _keyRecentSearches = 'recentSearches';
  static const _keySkillsSearches = 'skillsSearches';
  static const _keyMatchList = 'matchList';
  static const _keySearchHints = 'searchHints';

  static Future init() async =>
      preferences = await SharedPreferences.getInstance();

  SharedPreferences fetchSharedPreferences() {
    return preferences;
  }

  String? _mobile;
  String get userMobile {
    if(_mobile!.isEmpty){
      fetchUserDetails();
      return _mobile!;
    }else{
      return _mobile!;
    }
  }

  //----------------------Search Job Details
  static const searchDetails = ModelSearchJob(
      stateId: '23',
      salary: '500000',
      education: 'Graduate',
      keyword:'india'
  );
  Future<void> addJobSearchDetails(ModelSearchJob searchJob) async {
    final json = jsonEncode(searchJob.toJson());
    await preferences.setString(_keyjobSearch, json);
  }
  Future<ModelSearchJob> fetchJobSearchDetails() async {
    final json = preferences.getString(_keyjobSearch);
    print('fetchJobSearchDetails---------${json}');
    return json == null ? searchDetails : ModelSearchJob.fromJson(jsonDecode(json));
  }

  //----------------------User Details
  static const myUser = AppUser(
    name: 'Mr Guest',
    email: 'guest@gmail.com',
    mobile: '0000000000',
    uid: '00000',
    pwd: '00000',
    image:'https://i.pinimg.com/736x/86/63/78/866378ef5afbe8121b2bcd57aa4fb061.jpg'
  );
  Future<void> addUserDetails(AppUser user) async {
    final json = jsonEncode(user.toJson());
    await preferences.setString(_keyUserDetails, json);
  }
  Future<AppUser> fetchUserDetails() async {
    final json = preferences.getString(_keyUserDetails);
    _mobile=jsonDecode(json!)['mobile'];
    print('fetchUserDetails---------${json}');
    return json == null ? myUser : AppUser.fromJson(jsonDecode(json));
  }

//----------------------MatchList
  Future<void> addMatchList(List<String> matchList) async {
    if (matchList.isEmpty) return; //Should not be null
    //Use `Set` to avoid duplication of recentSearches
    Set<String> setMatchList = matchList.toSet();
    preferences.setStringList(_keyMatchList, setMatchList.toList());
  }

  Future<List<String>> fetchMatchList() async {
    final allMatches = preferences.getStringList(_keyMatchList);
    return allMatches!.toList();
  }

  Future<void> deleteMatchList() async {
    Set<String> allMatches =
        preferences.getStringList(_keyRecentSearches)?.toSet() ?? {};
    //Place it at first in the set
    allMatches = {};
    preferences.setStringList(_keyRecentSearches, allMatches.toList());
  }

  //----------------------RecentSearches
  Future<void> addRecentSearchesText(String searchText) async {
    if (searchText == null) return; //Should not be null
    //Use `Set` to avoid duplication of recentSearches
    Set<String> allSearches =
        preferences.getStringList(_keyRecentSearches)?.toSet() ?? {};
    //Place it at first in the set
    allSearches = {searchText, ...allSearches};
    preferences.setStringList(_keyRecentSearches, allSearches.toList());
  }

  Future<List<String>> fetchRecentSearchesWithQuery(String query) async {
    final allSearches = preferences.getStringList(_keyRecentSearches);
    return allSearches!.where((search) => search.startsWith(query)).toList();
  }

  Future<List<String>> fetchRecentSearches() async {
    final allSearches = preferences.getStringList(_keyRecentSearches);
    return allSearches!.toList();
  }

  Future<void> deleteRecentSearches() async {
    Set<String> allSearches =
        preferences.getStringList(_keyRecentSearches)?.toSet() ?? {};
    //Place it at first in the set
    allSearches = {};
    preferences.setStringList(_keyRecentSearches, allSearches.toList());
  }

  //----------------------Skills Required
  Future<void> addSkillsSearchesText(String searchText) async {
    if (searchText == null) return; //Should not be null
    //Use `Set` to avoid duplication of recentSearches
    Set<String> allSearches =
        preferences.getStringList(_keySkillsSearches)?.toSet() ?? {};
    //Place it at first in the set
    allSearches = {searchText, ...allSearches};
    preferences.setStringList(_keySkillsSearches, allSearches.toList());
  }

  Future<List<String>> fetchSkillsSearchesWithQuery(String query) async {
    final allSearches = preferences.getStringList(_keySkillsSearches);
    return allSearches!.where((search) => search.startsWith(query)).toList();
  }

  Future<List<String>> fetchSkillsSearches() async {
    final allSearches = preferences.getStringList(_keySkillsSearches);
    return allSearches!.toList();
  }

  Future<void> deleteSkillsSearches() async {
    Set<String> allSearches =
        preferences.getStringList(_keySkillsSearches)?.toSet() ?? {};
    //Place it at first in the set
    allSearches = {};
    preferences.setStringList(_keySkillsSearches, allSearches.toList());
  }

  Future<void> deleteSkillsSearchesValue(String value) async {
    Set<String> allSearches =
        preferences.getStringList(_keySkillsSearches)?.toSet() ?? {};
    allSearches.remove(value);
    preferences.setStringList(_keySkillsSearches, allSearches.toList());
  }



  //----------------------User Language
  Future<void> addUserLanguage(String lang) async {
    preferences.setString(_keyUserLanguage, lang);
  }

  Future<String> fetchUserLanguage() async {
    try {
      var language = preferences.getString(_keyUserLanguage);
      return language!;
    } catch (e) {
      return '';
    }
  }

  //----------------------LoginStatus
  Future<void> addLoginStatus(bool login) async {
    preferences.setBool(_keyLogin, login);
  }

  Future<bool> fetchLoginStatus() async {
    try {
      var status = preferences.getBool(_keyLogin) ?? false;
      return status;
    } catch (e) {
      return false;
    }
  }

//----------------------Freelancer LoginStatus
  Future<void> addFreelancerLoginStatus(bool login) async {
    preferences.setBool(_keyFreelancerLogin, login);
  }

  Future<bool> fetchFreelancerLoginStatus() async {
    try {
      var status = preferences.getBool(_keyFreelancerLogin) ?? false;
      return status;
    } catch (e) {
      return false;
    }
  }

  //----------------------Freelancer UserType
  Future<void> addFreelancerUserType(int type) async {
    preferences.setInt(_keyFreelancerUserType, type);
  }

  Future<int> fetchFreelancerUserType() async {
    try {
      // await getSharedPreferences();
      var status = preferences.getInt(_keyFreelancerUserType);
      return status!;
    } catch (e) {
      return 1;
    }
  }

  //----------------------UserType
  Future<void> addUserType(int type) async {
    preferences.setInt(_keyUserType, type);
  }

  Future<int> fetchUserType() async {
    try {
      // await getSharedPreferences();
      var status = preferences.getInt(_keyUserType);
      return status!;
    } catch (e) {
      return 1;
    }
  }

  Future<void> getSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }
}


