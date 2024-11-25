import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ows_bigcareer/model/firebase/firebase_service.dart';
import 'package:ows_bigcareer/view/gov_job/apply_for_job.dart';
import 'package:ows_bigcareer/view/job_tab/card_job/bottom_job_card.dart';

class CardJobStateWise extends StatefulWidget {
  const CardJobStateWise(
      {Key? key,
      required this.job,
      required this.index,
      required this.userMobile})
      : super(key: key);
  final job;
  final index;
  final userMobile;

  @override
  State<CardJobStateWise> createState() => _CardJobStateWiseState();
}

class _CardJobStateWiseState extends State<CardJobStateWise> {
  FirebaseService firebaseService = FirebaseService();

  bool isJobExistFlag = false;

  getJobExist() async {
    isJobExistFlag = await firebaseService.doesJobExist(widget.userMobile, widget.job);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getJobExist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
            height: 292,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(0),
                            bottomLeft: Radius.circular(20),
                          ),
                          color: Color(0xff1aa122)),
                      height: 28,
                      width: 110,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.job![widget.index].totalApplied,
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            const Text(
                              ' Job Applied',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      )),
                ),
                SizedBox(
                  height: 150,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 25),
                    child: Column(
                      children: [
                        Text(
                          widget.job![widget.index].jobTitle!,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0, right: 10),
                          child: Text(
                            widget.job![widget.index].jobDescription!,
                            maxLines: 3,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, top: 3.0, right: 27),
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
                        widget.job![widget.index].lastDate!,
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
                      const EdgeInsets.only(left: 18.0, top: 3.0, right: 37),
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
                        widget.job![widget.index].postDate!,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, top: 4.0, right: 79),
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
                        widget.job![widget.index].noOpenings!,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.indigo,
                            fontWeight: FontWeight.w600),
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
                        'Eligibility',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const Spacer(),
                      Text(
                        widget.job![widget.index].educationQualication!,
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
                        widget.job![widget.index].salary!,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          BottomCardJob(
            userMobile: widget.userMobile,
            jobs: widget.job![widget.index],
            height: 50.0,
            width: MediaQuery.of(context).size.width * .95,
          )
        ],
      ),
    );
  }
}
