import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ows_bigcareer/model/apis/urls.dart';
import 'package:ows_bigcareer/model/firebase/firebase_service.dart';
import 'package:ows_bigcareer/model/models/model_display_all_projects.dart';
import 'package:http/http.dart' as http;

class MyProjectsListWidget extends StatefulWidget {
  final List<dynamic> _mediaList;
  final Function _function;
  final userMobile;
  MyProjectsListWidget(this.userMobile, this._mediaList, this._function);
  @override
  _MyProjectsListWidgetState createState() => _MyProjectsListWidgetState();
}

class _MyProjectsListWidgetState extends State<MyProjectsListWidget> {
  double _initialRating = 2.0;
  late final _ratingController;
  late double _rating;
  IconData? _selectedIcon;
  FirebaseService firebaseServices = FirebaseService();
  bool deleteFlag = false;

  deleteProject(String userId, String projectId) async {
    setState(() {
      deleteFlag = true;
    });
    http.Response response = await http.post(
        Uri.parse('${API_BASE_URL}delete_user_project_api.php'),
        body: {"user_id": userId, "id": projectId});
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print('-deleteProject--------------${json}');
      if (json[0]["response"] == "1") {
        setState(() {
          deleteFlag = false;
        });
        showToast(msg: json[0]["message"]);
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        setState(() {
          deleteFlag = false;
        });
        showToast(msg: json[0]["message"]);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ratingController = TextEditingController(text: '3.0');
    _rating = _initialRating;
  }

  Widget _buildProjectItem(ModelDisplayAllProjects projects) {
    return GestureDetector(
      onTap: () {},
      child: Center(
        child: SizedBox(
          height: 410,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Container(
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(20),
                                  ),
                                  color: Colors.indigo),
                              height: 32,
                              width: 150,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${projects.amount} ${projects.currency} / ${projects.paymentMode}',
                                      style: const TextStyle(
                                          fontSize: 11,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              )),
                          const Spacer(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0, top: 10),
                        child: Column(
                          children: [
                            Text(
                              '${projects.title}',
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
                        padding:
                            const EdgeInsets.only(top: 0, right: 10, left: 18),
                        child: Text(
                          '${projects.details}',
                          maxLines: 3,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 18.0, top: 4.0, right: 78),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                            '${projects.amount} ${projects.currency} / ${projects.paymentMode}',
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.indigo,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 18.0, top: 3.0, right: 0),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * .29,
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
                            width: MediaQuery.of(context).size.width * .50,
                            child: Text(
                              '${projects.skills}',
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
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Row(
                    children: [
                      buildImage(projects.image1 ?? '', 'Image 1'),
                      const Spacer(),
                      buildImage(projects.image2 ?? '', 'Image 2'),
                      const Spacer(),
                      buildImage(projects.image3 ?? '', 'Image 3'),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18, bottom: 8.0, right: 10),
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
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: SizedBox(
                      height: 35,
                      width: MediaQuery.of(context).size.width * .9,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(5)),
                              backgroundColor: Colors.indigo),
                          onPressed: () {
                            deleteProject(widget.userMobile, projects.id!);
                          },
                          child: deleteFlag
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : const Center(
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ))),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImage(String image, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(title),
                content: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .6,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/loading.gif',
                      image: image ?? '',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.clear))
                ],
              );
            });
      },
      child: Container(
        width: MediaQuery.of(context).size.width*.2,
        height: MediaQuery.of(context).size.width*.2,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/loading.gif',
            image: image ?? '',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: widget._mediaList.length,
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemBuilder: (BuildContext context, int index) {
            ModelDisplayAllProjects data = widget._mediaList[index];
            return InkWell(
              onTap: () {},
              child: data.title == null
                  ? const Center(
                      child: Text('Data Not Found'),
                    )
                  : _buildProjectItem(data),
            );
          },
        ),
      ]),
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
