import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ows_bigcareer/core/constants/freelancers.dart';
import 'package:flutter/scheduler.dart';
import 'package:ows_bigcareer/model/firebase/firebase_service.dart';
import 'package:ows_bigcareer/model/models/model_freelancers.dart';
import 'hire_freelancer.dart';

class FreelancerProfile extends StatefulWidget {
  const FreelancerProfile({Key? key, required this.freelancer,required this.mobile})
      : super(key: key);
  final ModelFreelancers freelancer;
  final mobile;

  @override
  State<FreelancerProfile> createState() => _FreelancerProfileState();
}

class _FreelancerProfileState extends State<FreelancerProfile> {
  late final _ratingController;
  late double _rating;
  FirebaseService firebaseService=FirebaseService();

  double _initialRating = 2.0;
  IconData? _selectedIcon;
  bool viewFilter = false;

  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  VoidCallback? _showPersistantBottomSheetCallBack;

  final TextEditingController _controllerSearchKeyword =
      TextEditingController();

  bool doesFreelacerExistFlag = false;

  getFreelancerExist() async {
    doesFreelacerExistFlag = await firebaseService.doesFreelancerExist(
        widget.mobile, widget.freelancer);
    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    getFreelancerExist();
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
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.indigo),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.chat_bubble_outline,
                color: Colors.black,
              ))
        ],
        backgroundColor: Colors.white,
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          print('----onPressed--------${widget.mobile}--------${widget.freelancer.f_id}-');
          if(widget.mobile==widget.freelancer.f_id){
            showToast(msg: "you wouldn't Hire your self");
          }else{
            navigateTo(context, HireFreelancer(
              userMobile:widget.mobile,
              freelancer: widget.freelancer,));
          }
        },
        child: Container(
            height: 45.0,
            width: MediaQuery.of(context).size.width * 0.92,
            decoration: BoxDecoration(
                color: Colors.indigo, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                'Hire ${widget.freelancer.name}',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(height: 1, color: Colors.grey, width: double.infinity),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Center(
                      child: SizedBox(
                        height: 495,
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(0),
                              topLeft: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                            ),
                          ),
                          color: Colors.white,
                          elevation: 1,
                          child: Column(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                      color: Colors.white38,
                                      width: double.infinity,
                                      height: 240,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Spacer(),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child:  SizedBox(
                                                    child: IconButton(
                                                        onPressed: () {
                                                          firebaseService.addAndRemoveFreelancers(
                                                              doesFreelacerExistFlag,
                                                              widget.mobile!, widget.freelancer);
                                                          getFreelancerExist();
                                                        },
                                                        icon: doesFreelacerExistFlag
                                                            ? const Icon(
                                                          Icons.bookmark,
                                                        )
                                                            : const Icon(
                                                          Icons.bookmark_add_outlined,
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 100,
                                                  width: 100,
                                                  child: Image.network(
                                                    '${widget.freelancer.image}',
                                                    fit: BoxFit.fitWidth,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 18.0),
                                                  child: Text(
                                                    '${widget.freelancer.name}',
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: const [
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                      size: 16,
                                                    ),
                                                    Text(
                                                      '5.0 (1 review)',
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 18.0),
                                                  child: Text(
                                                    '${widget.freelancer.country}',
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      // Text(
                                                      //   '${widget.freelancer.currencySymbol}${widget.freelancer.cost} ${widget.freelancer.currencyName} /',
                                                      //   style: const TextStyle(
                                                      //       fontSize: 15,
                                                      //       fontWeight:
                                                      //           FontWeight.w600,
                                                      //       color:
                                                      //           Colors.black),
                                                      // ),
                                                      Text(
                                                        ' ${widget.freelancer.paymentMode}',
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .44,
                                                  child: Row(
                                                    children: const [
                                                      Text(
                                                        '100%',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Colors.green),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        'Jobs Completed',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Colors.black),
                                                      )
                                                    ],
                                                  )),
                                              const Spacer(),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .48,
                                                  child: Row(
                                                    children: const [
                                                      Text(
                                                        '100%',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Colors.green),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        'On Budget',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Colors.black),
                                                      )
                                                    ],
                                                  )),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .44,
                                                  child: Row(
                                                    children: const [
                                                      Text(
                                                        '100%',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Colors.green),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        'On Time',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Colors.black),
                                                      )
                                                    ],
                                                  )),
                                              const Spacer(),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .48,
                                                  child: Row(
                                                    children: const [
                                                      Text(
                                                        '100%',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Colors.green),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        'Repeate Hire Rate',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Colors.black),
                                                      )
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 18.0, top: 10),
                                      child: Column(
                                        children: [
                                          Text(
                                            '${widget.freelancer.title}',
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0, right: 10, left: 18),
                                      child: Text(
                                        '${widget.freelancer.about}',
                                        maxLines: 3,
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.black),
                                      ),
                                    ),
                                  ),
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
                                            '${widget.freelancer.skills!.replaceAll('[', '').replaceAll(']', '')}',
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
                              const SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            Center(
              child: SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(0),
                      topLeft: Radius.circular(0),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                  ),
                  color: Colors.white,
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(
                          height: 50,
                          child: Text(
                            'Projects Details',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showBottomSheet() {
    showModalBottomSheet<void>(
      // context and builder are
      // required properties in this widget
      context: context,
      builder: (BuildContext context) {
        // we set up a container inside which
        // we create center column and display text

        // Returning SizedBox instead of a Container
        return SizedBox(
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text('Geeks for Geeks'),
              ],
            ),
          ),
        );
      },
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
