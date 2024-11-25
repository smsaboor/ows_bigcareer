import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_package1/components.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ows_bigcareer/model/firebase/firebase_service.dart';
import 'package:ows_bigcareer/view/freelancer/freelancer/freelancer_static.dart';

class LikedFP extends StatefulWidget {
  const LikedFP({super.key, required this.userMobile});

  final userMobile;

  @override
  State<LikedFP> createState() => _LikedFPState();
}

class _LikedFPState extends State<LikedFP> with SingleTickerProviderStateMixin {
  FirebaseService firebaseService = FirebaseService();
  late TabController _tabController;
  bool userData = true;
  late Future<QuerySnapshot> likedJobs;
  double _initialRating = 2.0;
  IconData? _selectedIcon;
  bool viewFilter = false;
  late double _rating;

  // getUserDetails() async {
  //   var sharedPreferencesVM =
  //       Provider.of<SharedPreferencesVM>(context, listen: false);
  //   var appUser = await sharedPreferencesVM.getUserDetails();
  //   setState(() {
  //     mobile = appUser.mobile;
  //     userData = false;
  //   });
  // }

  Future<QuerySnapshot> getFreelancers() async {
    print('---------------${widget.userMobile}');
    likedJobs = FirebaseFirestore.instance
        .collection('favoriteFreelancers')
        .doc(widget.userMobile)
        .collection(widget.userMobile!)
        .get();
    return likedJobs;
  }

  Future<QuerySnapshot> getProjects() async {
    print('---------------${widget.userMobile}');
    likedJobs = FirebaseFirestore.instance
        .collection('favoriteProjects')
        .doc(widget.userMobile)
        .collection(widget.userMobile!)
        .get();
    return likedJobs;
  }

  @override
  void initState() {
    // TODO: implement initState
    _rating = _initialRating;
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40.0),
            child: AppBar(
              title: const Text('Liked'),
              centerTitle: true,
              elevation: 0,
            )),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(
            //   height: 35,
            //   color: Colors.indigo,
            //   child: const Center(
            //     child: Text(
            //       "Profile",
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            // ),
            TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.indigo,
              indicatorColor: Colors.indigo,
              tabs: const [
                Tab(
                  icon: Icon(Icons.people),
                  child: Text('Freelancers'),
                ),
                Tab(
                  icon: Icon(Icons.folder),
                  child: Text('Projects'),
                )
              ],
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [getFreelancersTab(), getProjectsTab()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getFreelancersTab() {
    return FutureBuilder<QuerySnapshot>(
        future: getFreelancers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(backgroundColor: Colors.blue),
            );
          }
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return ListView(
                children: documents.map((doc) {
              return GestureDetector(
                onTap: () {},
                child: Center(
                  child: SizedBox(
                    height: 320,
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
                          SizedBox(
                            height: 260,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    color: Colors.white38,
                                    width: double.infinity,
                                    height: 80,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: SizedBox(
                                            height: 60,
                                            width: 60,
                                            child: Image.network(
                                              doc['image'],
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 8, right: 8),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 18.0),
                                                child: Text(
                                                  doc['name'],
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 18.0),
                                                child: Row(
                                                  children: const [
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                      size: 16,
                                                    ),
                                                    Text(
                                                      '5.0',
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 18.0),
                                                child: Text(
                                                  doc['country'],
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        SizedBox(
                                          child: IconButton(
                                              onPressed: () async {
                                                await firebaseService
                                                    .deleteFreelancers(
                                                        widget.userMobile!,
                                                        doc['id']);
                                                setState(() {});
                                              },
                                              icon: const Icon(
                                                Icons.favorite,
                                                color: Colors.indigo,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18.0, top: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${doc['currency']} ${doc['amount']} ',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          doc['paymentMode'],
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
                                  height: 40,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18.0, top: 10),
                                    child: Column(
                                      children: [
                                        Text(
                                          doc['title'],
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
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0, right: 10, left: 18),
                                    child: Text(
                                      doc['about'],
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
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .50,
                                        child: Text(
                                          doc['skills'],
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
                          SizedBox(
                              height: 35,
                              width: MediaQuery.of(context).size.width * .9,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: Colors.indigo),
                                  onPressed: () {
                                    // navigateTo(context, HireFreelancer(freelancer: freelancersList![index],));
                                  },
                                  child: const Center(
                                    child: Text(
                                      'Hire',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ))),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList());
          }
          if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(child: Text('No Data'));
        });
  }

  getProjectsTab() {
    return FutureBuilder<QuerySnapshot>(
        future: getProjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(backgroundColor: Colors.blue),
            );
          }
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return ListView(
                children: documents.map((doc) {
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
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomLeft: Radius.circular(0),
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
                                                  '${doc['amount']} ${doc['currency']} / ${doc['paymentMode']}',
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
                                              firebaseService.deleteProjects(
                                                  widget.userMobile!,
                                                  doc['id']);
                                              setState(() {});
                                            },
                                            icon: const Icon(
                                              Icons.bookmark,
                                              color: Colors.indigo,
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
                                          doc['title'],
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
                                      doc['details'],
                                      maxLines: 3,
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 18.0, top: 4.0, right: 79),
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
                                        '',
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
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .50,
                                        child: Text(
                                          doc['skills'],
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
            }).toList());
          }
          if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(child: Text('No Data'));
        });
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
