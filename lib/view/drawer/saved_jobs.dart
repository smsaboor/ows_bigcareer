import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_package1/components.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ows_bigcareer/model/firebase/firebase_service.dart';
import 'package:ows_bigcareer/model/models/model_jobs_final.dart';
import 'package:ows_bigcareer/view/gov_job/apply_for_job.dart';
import 'package:ows_bigcareer/view/job_tab/card_job/bottom_job_card.dart';
import 'package:ows_bigcareer/view/job_tab/card_job/card_image.dart';
import 'package:ows_bigcareer/view/job_tab/card_job/header.dart';
import 'package:ows_bigcareer/view/job_tab/card_job/title_job.dart';

class SavedJobs extends StatefulWidget {
  const SavedJobs({super.key, required this.userMobile});

  final userMobile;

  @override
  State<SavedJobs> createState() => _SavedJobsState();
}

class _SavedJobsState extends State<SavedJobs> {
  bool data = true;
  late Future<QuerySnapshot> likedJobs;

  //
  // getUserDetails() async {
  //   var sharedPreferencesVM = Provider.of<SharedPreferencesVM>(context, listen: false);
  //   var appUser = await sharedPreferencesVM.getUserDetails();
  //   setState(() {
  //     mobile = appUser.mobile;
  //   });
  // }
  FirebaseService firebaseService = FirebaseService();

  Future<QuerySnapshot> getJobs() async {
    print('----getJobs-----------${widget.userMobile}');
    likedJobs = FirebaseFirestore.instance
        .collection('likedJobs')
        .doc(widget.userMobile)
        .collection(widget.userMobile!)
        .get();
    return likedJobs;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Jobs'),
        centerTitle: true,
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: getJobs(),
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
                ModelJobsFinal jobsFinal = ModelJobsFinal(
                  salary: doc['salary'],
                  companyLogo: doc['company_logo'],
                  lastDate: doc['last_date'],
                  companyName: doc['company_name'],
                  declaration: doc['declaration'],
                  educationQualication: doc['education_qualication'],
                  eligibity: doc['eligibity'],
                  experience: doc['experience'],
                  howToApply: doc['howToApply'],
                  jobDescription: doc['job_description'],
                  jobId: doc['job_id'],
                  jobLocationId: doc['job_location_id'],
                  jobTitle: doc['job_title'],
                  noOpenings: doc['no_openings'],
                  other: doc['other'],
                  postDate: doc['post_date'],
                  postedDate: doc['posted_date'],
                  requirements: doc['requirements'],
                  responsibilities: doc['responsibilities'],
                  successCode: doc['success_code'],
                  totalApplied: doc['total_applied'],
                );
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeaderJobCard(
                              jobs: jobsFinal,
                              apiResponse: null,
                              height: 28.0,
                              width: 110.0,
                            ),
                            const SizedBox(height: 5,),
                            TitleJob(
                              jobs: jobsFinal,
                              height: 100.0,
                            ),
                            const SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 18.0, top: 3.0, right: 37),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Post Date',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  const Spacer(),
                                  Text(
                                    jobsFinal.postDate!,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 18.0, top: 4.0, right: 79),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Vacancy',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  const Spacer(),
                                  Text(
                                    jobsFinal.noOpenings ?? '',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.indigo,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 18.0, top: 3.0, right: 27),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Last Date',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.redAccent),
                                    ),
                                    const Spacer(),
                                    Text(
                                      jobsFinal.lastDate ?? '',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ]),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 18.0, top: 3.0, right: 27),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Eligibility',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  const Spacer(),
                                  Text(
                                    jobsFinal.educationQualication??'',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 18.0, top: 3.0, right: 27),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Salary',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  const Spacer(),
                                  Text(
                                    jobsFinal.salary??'',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 13,),
                            BottomCardJob(
                              userMobile: widget.userMobile,
                              jobs: jobsFinal,
                              height: 50.0,
                              width: width * .95,
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
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
