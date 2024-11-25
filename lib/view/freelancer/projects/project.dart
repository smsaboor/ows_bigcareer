import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ows_bigcareer/core/constants/projects.dart';
import 'package:ows_bigcareer/model/firebase/firebase_service.dart';
import 'package:ows_bigcareer/model/models/model_display_all_projects.dart';
import 'package:ows_bigcareer/view/freelancer/projects/add_new_project.dart';
import 'package:ows_bigcareer/view/freelancer/projects/rating.dart';
import 'package:ows_bigcareer/view/search/search_bar_projects.dart';

class Projects extends StatefulWidget {
  const Projects({Key? key, required this.userMobile}) : super(key: key);
  final userMobile;

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  late final _ratingController;
  late double _rating;
  FirebaseService firebaseServices = FirebaseService();
  double _initialRating = 2.0;
  IconData? _selectedIcon;
  bool viewFilter = false;

  List<ModelDisplayAllProjects>? projectsList;

  final TextEditingController _controllerSearchKeyword =
      TextEditingController();

  @override
  void initState() {
    getFreelancersList();
    super.initState();
    _ratingController = TextEditingController(text: '3.0');
    _rating = _initialRating;
  }

  onTapSearchKeywords() async {
    if (_controllerSearchKeyword.text.isEmpty) {
      setState(() {
        viewFilter = false;
      });
      setState(() {});
    }
  }

  getFreelancersList() {
    projectsList =
        projectsJson.map((i) => ModelDisplayAllProjects.fromJson(i)).toList();
    print('freelancersList length${projectsList!.length}');
  }
  onSearchTextChanged(String text) async {
    if (text.isEmpty) {
      setState(() {
        viewFilter = false;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Projects',
          style: TextStyle(color: Colors.indigo),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: SearchBarProjects(
                      controller: _controllerSearchKeyword,
                      onSubmited: (val) {
                        _controllerSearchKeyword.text = val.toString();
                        setState(() {
                          viewFilter = true;
                        });
                      },
                      onTap: onTapSearchKeywords,
                      onChanged: onSearchTextChanged),
                )),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: projectsJson.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Center(
                      child: SizedBox(
                        height: 320,
                        width: MediaQuery.of(context).size.width * .9,
                        child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          color: Colors.white,
                          elevation: 2,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 260,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          Container(
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(0),
                                                    bottomRight:
                                                        Radius.circular(20),
                                                  ),
                                                  color: Colors.indigo),
                                              height: 32,
                                              width: 150,
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '${projectsJson[index]['budgetMin']}-${projectsJson[index]['budgetMax']} ${projectsJson[index]['currency']} / ${projectsJson[index]['paymentMode']}',
                                                      style: const TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          const Spacer(),
                                          SizedBox(
                                            child: IconButton(
                                                onPressed: () {
                                                  firebaseServices.addProjects(
                                                      widget.userMobile!,
                                                      projectsList![index]);
                                                  showToast(
                                                      msg:
                                                          'Like Button Clicked');
                                                },
                                                icon: const Icon(
                                                  Icons.bookmark_add_outlined,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 18.0, top: 10),
                                        child: Column(
                                          children: [
                                            Text(
                                              '${projectsJson[index]['title']}',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 60,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 0, right: 10, left: 18),
                                        child: Text(
                                          '${projectsJson[index]['details']}',
                                          maxLines: 3,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 18.0, top: 4.0, right: 79),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'bids',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                          const Spacer(),
                                          Text(
                                            '${projectsJson[index]['bids']}',
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.indigo,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 18.0, top: 3.0, right: 0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .29,
                                            child: const Text(
                                              'Skills',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.redAccent),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .50,
                                            child: Text(
                                              '${projectsJson[index]['skills']}',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 18, bottom: 8.0, right: 10),
                                child: SizedBox(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      _ratingBar(),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text(
                                        '0.0',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      const Spacer(),
                                      const Text(
                                        '1 hour ago',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          onPressed: () {
            navigateTo(context, AddNewProject(userMobile: widget.userMobile,));
          },
          child: const Icon(Icons.add)),
    );
  }

  Widget _ratingBar() {
    return RatingBar.builder(
      initialRating: _initialRating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      unratedColor: Colors.black.withAlpha(50),
      itemCount: 5,
      itemSize: 20.0,
      itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
      itemBuilder: (context, _) => Icon(
        _selectedIcon ?? Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        setState(() {
          _rating = rating;
        });
      },
      updateOnDrag: true,
    );
  }
}
