import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ows_bigcareer/core/constants/jobs2.dart';
import 'package:ows_bigcareer/model/firebase/firebase_service.dart';
import 'package:ows_bigcareer/model/models/model_jobs_final.dart';
import 'package:ows_bigcareer/model/models/model_jobs_homepage.dart';
import 'package:ows_bigcareer/view/gov_job/apply_for_job.dart';
import '../comment/comment.dart';
import 'package:flutter_share/flutter_share.dart';


class BottomCardJob extends StatefulWidget {
  BottomCardJob(
      {Key? key,
      required this.jobs,
      required this.height,
      required this.userMobile,
      required this.width})
      : super(key: key);
  final ModelJobsFinal jobs;
  final height, width, userMobile;

  @override
  State<BottomCardJob> createState() => _BottomCardJobState();
}

class _BottomCardJobState extends State<BottomCardJob> {
  FirebaseService firebaseServices = FirebaseService();
  bool isJobExist = false;
  int totalLikedOnJob = 0;
  int totalCommentsOnJob = 0;
  int totalShareOnJob = 0;
  bool loading = false;

  getJobExist() async {
    setState(() {
      isJobExist = false;
    });
    isJobExist =
        await firebaseServices.doesJobExist(widget.userMobile, widget.jobs);
    setState(() {});
  }

  getTotalLikedOnJob() async {
    totalLikedOnJob =
        await firebaseServices.totalLikedOnJob(widget.jobs.jobId!);
    setState(() {});
  }
  getTotalCommentsOnJob() async {
    totalCommentsOnJob = await firebaseServices.totalCommentsOnJob(widget.jobs.jobId!);
    setState(() {});
  }
  getTotalShareOnJob() async {
    totalShareOnJob = await firebaseServices.totalShareOnJob(widget.jobs.jobId!);
    setState(() {});
  }

  Future<void> share() async {
    await getTotalShareOnJob();
    setState(() {
    });
    FirebaseFirestore.instance
        .collection("totalShareOnJob")
        .doc(widget.jobs.jobId!)
        .update({"total": (totalShareOnJob+1).toString()}).then((value) => value);
    await FlutterShare.share(
        title: 'Hello',
        text: widget.jobs.jobTitle??'',
        linkUrl: 'https://bigcareer.co.in',
        chooserTitle: 'Hi, New Vacancy');
    await getTotalShareOnJob();
  }

  // incrementAndDecrementOnJob(bool increment) async {
  //   totalJobExist=await firebaseServices.incrementAndDecrementOnLikedJob(increment,widget.jobs.jobId!);
  //   setState(() {
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    getJobExist();
    getTotalLikedOnJob();
    getTotalCommentsOnJob();
    getTotalShareOnJob();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            color: Color(0xff0a37ec)),
        width: widget.width,
        height: widget.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            loading
                ? const SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Icon(
                          isJobExist
                              ? Icons.thumb_up
                              : Icons.thumb_up_alt_outlined,
                          color: Colors.white,
                        ),
                        onTap: () async {
                          setState(() {
                            loading = true;
                          });
                          await firebaseServices.addAndRemoveLikedJobs(
                              isJobExist, widget.userMobile!, widget.jobs);
                          print('statment 2');
                          await getJobExist();
                          print('statment 3');
                          isJobExist
                              ? firebaseServices
                                  .incrementAndDecrementOnLikedJob(
                                      totalLikedOnJob + 1, widget.jobs.jobId!)
                              : totalLikedOnJob == 0
                                  ? firebaseServices
                                      .incrementAndDecrementOnLikedJob(
                                          0, widget.jobs.jobId!)
                                  : firebaseServices
                                      .incrementAndDecrementOnLikedJob(
                                          totalLikedOnJob - 1,
                                          widget.jobs.jobId!);
                          print('statment 4');
                          await getTotalLikedOnJob();
                          setState(() {
                            loading = false;
                          });
                        },
                      ),
                      Text(
                        '$totalLikedOnJob',
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ],
                  ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: const FaIcon(
                    FontAwesomeIcons.comment,
                    color: Colors.white,
                  ),
                  onTap: () {
                    navigateTo(context, CommentsHome(userMobile: widget.userMobile,job: widget.jobs,));
                  },
                ),
                Text(
                  '$totalCommentsOnJob',
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                  onTap: () {
                    share();
                  },
                ),
                Text(
                  '$totalShareOnJob',
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: const FaIcon(
                    FontAwesomeIcons.paperPlane,
                    color: Colors.white,
                  ),
                  onTap: () {
                    navigateTo(context,
                        ApplyForJob(title: 'Apply For', data: widget.jobs));
                  },
                ),
                Text(
                  widget.jobs.totalApplied!,
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ],
            )
          ],
        ));
  }
}
