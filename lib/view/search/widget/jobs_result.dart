import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ows_bigcareer/model/apis/api_response.dart';
import 'package:ows_bigcareer/model/models/model_jobs_final.dart';
import 'package:ows_bigcareer/view/gov_job/apply_for_job.dart';
import 'package:ows_bigcareer/view_model/api_view_model.dart';
import 'package:provider/provider.dart';

class JobResults extends StatefulWidget {
  const JobResults({Key? key}) : super(key: key);

  @override
  State<JobResults> createState() => _JobResultsState();
}

class _JobResultsState extends State<JobResults> {
  @override
  Widget build(BuildContext context) {
    ApiResponseFilterJob apiResponseFilterJob = Provider.of<ApiViewModel>(context).responseFilterJob;
    List<dynamic>? dynamicDataList = apiResponseFilterJob!.data as List<dynamic>?;
    switch (apiResponseFilterJob!.status) {
      case Status.LOADING:
        return const Center(child: CircularProgressIndicator());
      case Status.COMPLETED:
        print('dynamicDataList 11${apiResponseFilterJob!.data}');
        return SizedBox(
          height: MediaQuery.of(context).size.height * .7,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  flex: 8,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: dynamicDataList!.length,
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemBuilder: (BuildContext context, int index) {
                      print('dynamicDataList 11${dynamicDataList.length}');
                      ModelJobsFinal data = dynamicDataList[index];
                      return data.successCode == "0"
                          ? Container()
                          : GestureDetector(
                        onTap: () {},
                        child: Center(
                          child: SizedBox(
                            height: 350,
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
                                    height: 292,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                              decoration:
                                              const BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius
                                                      .only(
                                                    topRight: Radius
                                                        .circular(10),
                                                    bottomRight:
                                                    Radius
                                                        .circular(
                                                        0),
                                                    bottomLeft: Radius
                                                        .circular(20),
                                                  ),
                                                  color: Color(
                                                      0xff1aa122)),
                                              height: 28,
                                              width: 110,
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  children: const [
                                                    Text(
                                                      '102',
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color: Colors
                                                              .white,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500),
                                                    ),
                                                    Text(
                                                      ' Job Applied',
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color: Colors
                                                              .white,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ),
                                        SizedBox(
                                          height: 150,
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                left: 12.0, top: 25),
                                            child: Column(
                                              children: [
                                                Text(
                                                  data!.jobTitle!,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      color:
                                                      Colors.black),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(
                                                      top: 18.0,
                                                      right: 10),
                                                  child: Text(
                                                    data.jobDescription!,
                                                    maxLines: 3,
                                                    style:
                                                    const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors
                                                            .black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 18.0,
                                              top: 3.0,
                                              right: 27),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Last Date',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    color:
                                                    Colors.redAccent),
                                              ),
                                              const Spacer(),
                                              Text(
                                                data.lastDate!,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 18.0,
                                              top: 3.0,
                                              right: 37),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Post Date',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    color: Colors.black),
                                              ),
                                              const Spacer(),
                                              Text(
                                                data.postDate!,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 18.0,
                                              top: 4.0,
                                              right: 79),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Vacancy',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    color: Colors.black),
                                              ),
                                              const Spacer(),
                                              Text(
                                                data.noOpenings!,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.indigo,
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 18.0,
                                              top: 3.0,
                                              right: 27),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Eligibility',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    color:
                                                    Colors.black),
                                              ),
                                              const Spacer(),
                                              Text(
                                                data.educationQualication!,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 18.0,
                                              top: 3.0,
                                              right: 27),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Salary',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    color:
                                                    Colors.black),
                                              ),
                                              const Spacer(),
                                              Text(
                                                data.salary!,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft:
                                            Radius.circular(10),
                                            bottomRight:
                                            Radius.circular(10),
                                          ),
                                          color: Color(0xff0a37ec)),
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          .9,
                                      height: 50,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                child: const Icon(
                                                  Icons
                                                      .thumb_up_alt_outlined,
                                                  color: Colors.white,
                                                ),
                                                onTap: () {
                                                  // firebaseServices.addLikedJobs(
                                                  //     widget.userMobile!, mediaList![index]);
                                                  // showToast(
                                                  //     msg: 'Like Button Clicked');
                                                },
                                              ),
                                              const Text(
                                                '30',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                child: const FaIcon(
                                                  FontAwesomeIcons
                                                      .comment,
                                                  color: Colors.white,
                                                ),
                                                onTap: () {
                                                  // firebaseServices
                                                  //     .getLikedJobs('7052665551');
                                                },
                                              ),
                                              const Text(
                                                '33',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                child: const Icon(
                                                  Icons.share,
                                                  color: Colors.white,
                                                ),
                                                onTap: () {
                                                  showToast(
                                                      msg:
                                                      'Share Button Clicked');
                                                },
                                              ),
                                              const Text(
                                                '5',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                child: const FaIcon(
                                                  FontAwesomeIcons
                                                      .paperPlane,
                                                  color: Colors.white,
                                                ),
                                                onTap: () {
                                                  navigateTo(
                                                      context,
                                                      ApplyForJob(
                                                        title:
                                                        'Apply For',
                                                        data: data!,
                                                      ));
                                                },
                                              ),
                                              const Text(
                                                '102',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11),
                                              ),
                                            ],
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )),
            ],
          ),
        );
      case Status.ERROR:
        return const Center(
          child: Text('Please try again latter!!!'),
        );
      case Status.INITIAL:
      default:
        return const Center(
          child: Text('Search the Jobs'),
        );
    }
  }
}
