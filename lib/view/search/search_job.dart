import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ows_bigcareer/model/apis/api_response.dart';
import 'package:ows_bigcareer/model/models/model_jobs_final.dart';
import 'package:ows_bigcareer/model/models/model_most_job_searched_keyword.dart';
import 'package:ows_bigcareer/model/models/model_search_job.dart';
import 'package:ows_bigcareer/view/gov_job/apply_for_job.dart';
import 'package:ows_bigcareer/view/search/json_statewithcities.dart';
import 'package:ows_bigcareer/view/search/model_state_with_cities.dart';
import 'package:ows_bigcareer/view/search/popup_location.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ows_bigcareer/view/search/search_filter.dart';
import 'package:ows_bigcareer/view_model/api_view_model.dart';
import 'package:ows_bigcareer/view_model/sharedpreferences_view_model.dart';
import 'package:provider/provider.dart';
import 'widget/search_bar_location.dart';
import 'widget/most_searched_keyword.dart';
import 'widget/search_bar_job.dart';
import 'widget/search_appbar.dart';
import 'widget/recent_list.dart';
import 'widget/jobs_result.dart';

const String url = 'https://jsonplaceholder.typicode.com/users';

class SearchJob extends StatefulWidget {
  const SearchJob({Key? key}) : super(key: key);
  @override
  State<SearchJob> createState() => _SearchJobState();
}

class _SearchJobState extends State<SearchJob> {
  bool viewFilter = false;

  List<String> _searchResult2 = [];
  final List<UserDetails> _userDetails = [];

  final List<String> list = [];

  final TextEditingController _controllerSearchKeyword =
      TextEditingController();
  final TextEditingController _controllerSearchLocation =
      TextEditingController();
  final TextEditingController _controllerSearchLocationId =
      TextEditingController();
  var sharedPreferencesVM;

  Future<void> getUserDetails() async {
    final response = await http.get(Uri.parse(url));
    final responseJson = json.decode(response.body);
    setState(() {
      for (Map user in responseJson) {
        _userDetails.add(UserDetails.fromJson(user));
      }
    });
  }

  List<StatesWithCities>? listStatesWithCities;

  int selecteState = 0;
  int selecteCity = 0;

  getStatesWithCities() {
    listStatesWithCities =
        jsonStatesWithCity.map((i) => StatesWithCities.fromJson(i)).toList();
  }

  @override
  void initState() {
    getStatesWithCities();
    // TODO: implement initState
    _controllerSearchLocation.text = 'Uttar Pradesh';
    _controllerSearchLocationId.text = '23';
    sharedPreferencesVM =
        Provider.of<SharedPreferencesVM>(context, listen: false);
    sharedPreferencesVM.setJobSearchDetails(const ModelSearchJob(
        stateId: '23',
        salary: '500000',
        education: 'Graduate',
        keyword: 'india'));
    Provider.of<ApiViewModel>(context, listen: false).fetchJobSearchKeywords(
        ModelMostJobSearchedKeyword(),
        'most_searched_job_keywords_api.php',
        null);
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    ApiResponseJobSearchKeywords apiResponse = Provider.of<ApiViewModel>(context).responseJobSearchKeywords;
    List<dynamic>? dynamicDataList = apiResponse.data as List<dynamic>?;
    if (apiResponse.status == Status.COMPLETED) {
      for (int i = 0; i < dynamicDataList!.length; i++) {
        list.add(dynamicDataList![i].keyword);
      }
      sharedPreferencesVM.setJobMatchList(list);
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBarSearch(
          viewFilter: viewFilter,
          searchLocation: _controllerSearchLocation.text,
          searchKeyword: _controllerSearchKeyword.text,
          onLocationChanged: onLocationChanged,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: viewFilter
                  ? MediaQuery.of(context).size.height * .07
                  : MediaQuery.of(context).size.height * .18,
              child: Column(
                children: [
                  SizedBox(
                      height: 55,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15),
                        child: SearchBarJob(
                            controller: _controllerSearchKeyword,
                            onSubmited: (val) async{
                              _controllerSearchKeyword.text = val.toString();
                              if (_controllerSearchKeyword.text.isEmpty) {
                                showToast(msg: 'please enter a Keyword');
                              } else {
                                if (viewFilter) {
                                  Provider.of<ApiViewModel>(context,
                                          listen: false)
                                      .fetchDataFilterJob(ModelJobsFinal(),
                                          'all_filters_api.php', {
                                    "state_id":
                                        _controllerSearchLocationId.text,
                                    "salary": '500000',
                                    "keyword": _controllerSearchKeyword.text,
                                    "education": 'Graduate',
                                  });
                                  await sharedPreferencesVM.setRecentSearches(_controllerSearchKeyword.text);
                                } else {
                                  Provider.of<ApiViewModel>(context,
                                          listen: false)
                                      .fetchDataFilterJob(ModelJobsFinal(),
                                          'all_filters_api.php', {
                                    "state_id":
                                        _controllerSearchLocationId.text,
                                    "salary": '500000',
                                    "keyword": _controllerSearchKeyword.text,
                                    "education": 'Graduate',
                                  });
                                  await sharedPreferencesVM.setRecentSearches(_controllerSearchKeyword.text);
                                }
                                setState(() {
                                  viewFilter = true;
                                });
                              }
                            },
                            onTap: onTapSearchKeywords,
                            onChanged: onSearchTextChanged),
                      )),
                  viewFilter
                      ? Container()
                      : SizedBox(
                          height: 48,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 22.0, right: 20),
                            child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) {
                                        return FractionallySizedBox(
                                            heightFactor: 1,
                                            child: PopUpLocation(
                                              onLocationChanged:
                                                  (String stateIndex) {
                                                for (int i = 0; i < listStatesWithCities!.length; i++) {
                                                  if (listStatesWithCities![i].id == stateIndex) {
                                                    setState(() {
                                                      _controllerSearchLocation.text = listStatesWithCities![i].state!;
                                                      _controllerSearchLocationId.text = listStatesWithCities![i].id!;
                                                    });
                                                  }
                                                }
                                                setState(() {});
                                              },
                                            ));
                                      });
                                },
                                child: SearchBarLocation(
                                  controller: _controllerSearchLocation,
                                )),
                          )),
                ],
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * .8,
                width: MediaQuery.of(context).size.width,
                child: _buildBody())
          ],
        ),
      ),
    );
  }

  void onLocationChanged() async{
    if (_controllerSearchKeyword.text.isEmpty) {
      showToast(msg: 'please enter a Keyword');
    } else {
      if (viewFilter) {
        Provider.of<ApiViewModel>(context, listen: false)
            .fetchDataFilterJob(ModelJobsFinal(), 'all_filters_api.php', {
          "state_id": _controllerSearchLocationId.text,
          "salary": '500000',
          "keyword": _controllerSearchKeyword.text,
          "education": 'Graduate',
        });
        await sharedPreferencesVM.setRecentSearches(_controllerSearchKeyword.text);
      } else {
        Provider.of<ApiViewModel>(context, listen: false)
            .fetchDataFilterJob(ModelJobsFinal(), 'all_filters_api.php', {
          "state_id": _controllerSearchLocationId.text,
          "salary": '500000',
          "keyword": _controllerSearchKeyword.text,
          "education": 'Graduate',
        });
        await sharedPreferencesVM.setRecentSearches(_controllerSearchKeyword.text);
      }
      setState(() {
        viewFilter = true;
      });
    }
  }

  // Widget _buildJobsResults() {
  //   ApiResponseFilterJob apiResponseFilterJob = Provider.of<ApiViewModel>(context).responseFilterJob;
  //   List<dynamic>? dynamicDataList = apiResponseFilterJob!.data as List<dynamic>?;
  //   switch (apiResponseFilterJob!.status) {
  //     case Status.LOADING:
  //       return const Center(child: CircularProgressIndicator());
  //     case Status.COMPLETED:
  //       print('dynamicDataList 11${apiResponseFilterJob!.data}');
  //       return SizedBox(
  //         height: MediaQuery.of(context).size.height * .7,
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Expanded(
  //                 flex: 8,
  //                 child: ListView.separated(
  //                   shrinkWrap: true,
  //                   physics: const ScrollPhysics(),
  //                   scrollDirection: Axis.vertical,
  //                   itemCount: dynamicDataList!.length,
  //                   separatorBuilder: (context, index) {
  //                     return const Divider();
  //                   },
  //                   itemBuilder: (BuildContext context, int index) {
  //                     print('dynamicDataList 11${dynamicDataList.length}');
  //                     ModelJobsFinal data = dynamicDataList[index];
  //                     return data.successCode == "0"
  //                         ? Container()
  //                         : GestureDetector(
  //                             onTap: () {},
  //                             child: Center(
  //                               child: SizedBox(
  //                                 height: 320,
  //                                 width: MediaQuery.of(context).size.width * .9,
  //                                 child: Card(
  //                                   shape: const RoundedRectangleBorder(
  //                                     borderRadius: BorderRadius.only(
  //                                       topRight: Radius.circular(10),
  //                                       topLeft: Radius.circular(10),
  //                                       bottomLeft: Radius.circular(10),
  //                                       bottomRight: Radius.circular(10),
  //                                     ),
  //                                   ),
  //                                   color: Colors.white,
  //                                   elevation: 2,
  //                                   child: Column(
  //                                     children: [
  //                                       SizedBox(
  //                                         height: 262,
  //                                         child: Column(
  //                                           mainAxisAlignment:
  //                                               MainAxisAlignment.start,
  //                                           crossAxisAlignment:
  //                                               CrossAxisAlignment.start,
  //                                           children: [
  //                                             Align(
  //                                               alignment: Alignment.topRight,
  //                                               child: Container(
  //                                                   decoration:
  //                                                       const BoxDecoration(
  //                                                           borderRadius:
  //                                                               BorderRadius
  //                                                                   .only(
  //                                                             topRight: Radius
  //                                                                 .circular(10),
  //                                                             bottomRight:
  //                                                                 Radius
  //                                                                     .circular(
  //                                                                         0),
  //                                                             bottomLeft: Radius
  //                                                                 .circular(20),
  //                                                           ),
  //                                                           color: Color(
  //                                                               0xff1aa122)),
  //                                                   height: 28,
  //                                                   width: 110,
  //                                                   child: Center(
  //                                                     child: Row(
  //                                                       mainAxisAlignment:
  //                                                           MainAxisAlignment
  //                                                               .center,
  //                                                       children: const [
  //                                                         Text(
  //                                                           '102',
  //                                                           style: TextStyle(
  //                                                               fontSize: 11,
  //                                                               color: Colors
  //                                                                   .white,
  //                                                               fontWeight:
  //                                                                   FontWeight
  //                                                                       .w500),
  //                                                         ),
  //                                                         Text(
  //                                                           ' Job Applied',
  //                                                           style: TextStyle(
  //                                                               fontSize: 11,
  //                                                               color: Colors
  //                                                                   .white,
  //                                                               fontWeight:
  //                                                                   FontWeight
  //                                                                       .w500),
  //                                                         ),
  //                                                       ],
  //                                                     ),
  //                                                   )),
  //                                             ),
  //                                             SizedBox(
  //                                               height: 150,
  //                                               child: Padding(
  //                                                 padding:
  //                                                     const EdgeInsets.only(
  //                                                         left: 12.0, top: 25),
  //                                                 child: Column(
  //                                                   children: [
  //                                                     Text(
  //                                                       data!.jobTitle!,
  //                                                       style: const TextStyle(
  //                                                           fontSize: 15,
  //                                                           fontWeight:
  //                                                               FontWeight.w600,
  //                                                           color:
  //                                                               Colors.black),
  //                                                     ),
  //                                                     Padding(
  //                                                       padding:
  //                                                           const EdgeInsets
  //                                                                   .only(
  //                                                               top: 18.0,
  //                                                               right: 10),
  //                                                       child: Text(
  //                                                         data.jobDescription!,
  //                                                         maxLines: 3,
  //                                                         style:
  //                                                             const TextStyle(
  //                                                                 fontSize: 12,
  //                                                                 color: Colors
  //                                                                     .black),
  //                                                       ),
  //                                                     ),
  //                                                   ],
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                             Padding(
  //                                               padding: const EdgeInsets.only(
  //                                                   left: 18.0,
  //                                                   top: 3.0,
  //                                                   right: 37),
  //                                               child: Row(
  //                                                 mainAxisAlignment:
  //                                                     MainAxisAlignment.start,
  //                                                 children: [
  //                                                   const Text(
  //                                                     'Post Date',
  //                                                     style: TextStyle(
  //                                                         fontSize: 15,
  //                                                         fontWeight:
  //                                                             FontWeight.w600,
  //                                                         color: Colors.black),
  //                                                   ),
  //                                                   const Spacer(),
  //                                                   Text(
  //                                                     data.postDate!,
  //                                                     style: const TextStyle(
  //                                                         fontSize: 15,
  //                                                         color: Colors.black),
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                             Padding(
  //                                               padding: const EdgeInsets.only(
  //                                                   left: 18.0,
  //                                                   top: 4.0,
  //                                                   right: 79),
  //                                               child: Row(
  //                                                 mainAxisAlignment:
  //                                                     MainAxisAlignment.start,
  //                                                 children: [
  //                                                   const Text(
  //                                                     'Vacancy',
  //                                                     style: TextStyle(
  //                                                         fontSize: 15,
  //                                                         fontWeight:
  //                                                             FontWeight.w600,
  //                                                         color: Colors.black),
  //                                                   ),
  //                                                   const Spacer(),
  //                                                   Text(
  //                                                     data.noOpenings!,
  //                                                     style: const TextStyle(
  //                                                         fontSize: 15,
  //                                                         color: Colors.indigo,
  //                                                         fontWeight:
  //                                                             FontWeight.w600),
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                             Padding(
  //                                               padding: const EdgeInsets.only(
  //                                                   left: 18.0,
  //                                                   top: 3.0,
  //                                                   right: 27),
  //                                               child: Row(
  //                                                 mainAxisAlignment:
  //                                                     MainAxisAlignment.start,
  //                                                 children: [
  //                                                   const Text(
  //                                                     'Last Date',
  //                                                     style: TextStyle(
  //                                                         fontSize: 15,
  //                                                         fontWeight:
  //                                                             FontWeight.w600,
  //                                                         color:
  //                                                             Colors.redAccent),
  //                                                   ),
  //                                                   const Spacer(),
  //                                                   Text(
  //                                                     data.lastDate!,
  //                                                     style: const TextStyle(
  //                                                         fontSize: 15,
  //                                                         color: Colors.black,
  //                                                         fontWeight:
  //                                                             FontWeight.w500),
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                       Container(
  //                                           decoration: const BoxDecoration(
  //                                               borderRadius: BorderRadius.only(
  //                                                 bottomLeft:
  //                                                     Radius.circular(10),
  //                                                 bottomRight:
  //                                                     Radius.circular(10),
  //                                               ),
  //                                               color: Color(0xff0a37ec)),
  //                                           width: MediaQuery.of(context)
  //                                                   .size
  //                                                   .width *
  //                                               .9,
  //                                           height: 50,
  //                                           child: Row(
  //                                             mainAxisAlignment:
  //                                                 MainAxisAlignment.spaceEvenly,
  //                                             children: [
  //                                               Column(
  //                                                 mainAxisAlignment:
  //                                                     MainAxisAlignment.center,
  //                                                 children: [
  //                                                   GestureDetector(
  //                                                     child: const Icon(
  //                                                       Icons
  //                                                           .thumb_up_alt_outlined,
  //                                                       color: Colors.white,
  //                                                     ),
  //                                                     onTap: () {
  //                                                       // firebaseServices.addLikedJobs(
  //                                                       //     widget.userMobile!, mediaList![index]);
  //                                                       // showToast(
  //                                                       //     msg: 'Like Button Clicked');
  //                                                     },
  //                                                   ),
  //                                                   const Text(
  //                                                     '30',
  //                                                     style: TextStyle(
  //                                                         color: Colors.white,
  //                                                         fontSize: 11),
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                               Column(
  //                                                 mainAxisAlignment:
  //                                                     MainAxisAlignment.center,
  //                                                 children: [
  //                                                   GestureDetector(
  //                                                     child: const FaIcon(
  //                                                       FontAwesomeIcons
  //                                                           .comment,
  //                                                       color: Colors.white,
  //                                                     ),
  //                                                     onTap: () {
  //                                                       // firebaseServices
  //                                                       //     .getLikedJobs('7052665551');
  //                                                     },
  //                                                   ),
  //                                                   const Text(
  //                                                     '33',
  //                                                     style: TextStyle(
  //                                                         color: Colors.white,
  //                                                         fontSize: 11),
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                               Column(
  //                                                 mainAxisAlignment:
  //                                                     MainAxisAlignment.center,
  //                                                 children: [
  //                                                   GestureDetector(
  //                                                     child: const Icon(
  //                                                       Icons.share,
  //                                                       color: Colors.white,
  //                                                     ),
  //                                                     onTap: () {
  //                                                       showToast(
  //                                                           msg:
  //                                                               'Share Button Clicked');
  //                                                     },
  //                                                   ),
  //                                                   const Text(
  //                                                     '5',
  //                                                     style: TextStyle(
  //                                                         color: Colors.white,
  //                                                         fontSize: 11),
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                               Column(
  //                                                 mainAxisAlignment:
  //                                                     MainAxisAlignment.center,
  //                                                 children: [
  //                                                   GestureDetector(
  //                                                     child: const FaIcon(
  //                                                       FontAwesomeIcons
  //                                                           .paperPlane,
  //                                                       color: Colors.white,
  //                                                     ),
  //                                                     onTap: () {
  //                                                       navigateTo(
  //                                                           context,
  //                                                           ApplyForJob(
  //                                                             title:
  //                                                                 'Apply For',
  //                                                             data: data!,
  //                                                           ));
  //                                                     },
  //                                                   ),
  //                                                   const Text(
  //                                                     '102',
  //                                                     style: TextStyle(
  //                                                         color: Colors.white,
  //                                                         fontSize: 11),
  //                                                   ),
  //                                                 ],
  //                                               )
  //                                             ],
  //                                           )),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           );
  //                   },
  //                 )),
  //           ],
  //         ),
  //       );
  //     case Status.ERROR:
  //       return const Center(
  //         child: Text('Please try again latter!!!'),
  //       );
  //     case Status.INITIAL:
  //     default:
  //       return const Center(
  //         child: Text('Search the Jobs'),
  //       );
  //   }
  // }

  Widget _buildBody() {
    return viewFilter
        ? SingleChildScrollView(
            child: Column(
              children: [
                JobFilterBar(
                  searchText: _controllerSearchKeyword.text,
                  searchLocation: _controllerSearchLocation.text,
                  searchLocationId: _controllerSearchLocationId.text,
                ),
                viewFilter
                    ? JobResults()
                    : const Center(
                        child: Text('not '),
                      )
              ],
            ),
          )
        : _searchResult2.isNotEmpty || _controllerSearchKeyword.text.isNotEmpty
            ? MostSearchedKeyword(
                searchResult2: _searchResult2,
                controllerSearchKeyword: _controllerSearchKeyword,
              )
            : RecentList(
                controller: _controllerSearchKeyword,
                onTap: onLocationChanged,
              );
  }

  onTapSearchKeywords() async {
    _searchResult2.clear();
    if (_controllerSearchKeyword.text.isEmpty) {
      setState(() {
        viewFilter = false;
      });
      List<String> matchList = await sharedPreferencesVM.getJobMatchList();
      _searchResult2 = matchList.toList();
      setState(() {});
    }
  }

  onSearchTextChanged(String text) async {
    _searchResult2.clear();
    if (text.isEmpty) {
      setState(() {
        viewFilter = false;
      });
      return;
    }
    List<String> matchList = await sharedPreferencesVM.getJobMatchList();
    _searchResult2 =
        matchList.where((element) => element.contains(text)).toList();
    setState(() {});
    getFormatedText();
  }

  void getFormatedText() {
    for (int i = 0; i < _searchResult2.length; i++) {
      int value1 = _searchResult2[i].indexOf(_controllerSearchKeyword.text, 0);
      int value2 = _controllerSearchKeyword.text.length;
      int value3 = value2 - value1 - 1;
      print('getFormatedTexttttttttt$value3');
      print(
          'getFormatedText${_searchResult2[i].indexOf(_controllerSearchKeyword.text, 0)}');
    }
    Row(
      children: [
        const Text(''),
        const Text(''),
      ],
    );
  }

}

class UserDetails {
  final int? id;
  final String? firstName, lastName, profileUrl;

  UserDetails(
      {this.id,
      this.firstName,
      this.lastName,
      this.profileUrl =
          'https://i.amz.mshcdn.com/3NbrfEiECotKyhcUhgPJHbrL7zM=/950x534/filters:quality(90)/2014%2F06%2F02%2Fc0%2Fzuckheadsho.a33d0.jpg'});

  factory UserDetails.fromJson(Map<dynamic, dynamic> json) {
    return UserDetails(
      id: json['id'],
      firstName: json['name'],
      lastName: json['username'],
    );
  }
}
