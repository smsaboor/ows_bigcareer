import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:ows_bigcareer/model/apis/api_response.dart';
import 'package:ows_bigcareer/view/gov_job/gov_job.dart';
import 'package:ows_bigcareer/view_model/api_view_model.dart';
import 'package:provider/provider.dart';
import 'package:ows_bigcareer/model/models/model_flashing_jobs.dart';
import 'package:flutter_package1/loading/loading1.dart';

class BannerGovernmentJobs extends StatefulWidget {
  const BannerGovernmentJobs({Key? key, required this.userMobile})
      : super(key: key);
  final userMobile;

  @override
  State<BannerGovernmentJobs> createState() => _BannerGovernmentJobsState();
}

class _BannerGovernmentJobsState extends State<BannerGovernmentJobs> {
  bool loadData = true;
  List<Map<dynamic, dynamic>> map = [];
  List<AnimatedText>? listAnimatedText = [
    RotateAnimatedText('MM',
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
  ];

  getData() {
    Provider.of<ApiViewModel>(context, listen: false)
        .fetchData(ModelFlashingJobs(), 'latest_job_keyword_api.php', null);
    loadData = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  Widget getFlashingTextWidget(BuildContext context, ApiResponse apiResponse) {
    List<dynamic>? mediaList = apiResponse.data as List<dynamic>?;
    if (apiResponse.status == Status.COMPLETED) {
      for (int i = 0; i < mediaList!.length; i++) {
        ModelFlashingJobs data = mediaList[i];
        listAnimatedText!.add(
          RotateAnimatedText(data.jobName!,
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        );
      }
    }
    switch (apiResponse.status) {
      case Status.LOADING:
        return Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
              height: MediaQuery.of(context).size.height * .2,
              width: double.infinity,
              child: LoadingWidget.rectangular(
                  height: MediaQuery.of(context).size.height * .2,
                  width: MediaQuery.of(context).size.width)),
        );
      case Status.COMPLETED:
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                height: MediaQuery.of(context).size.height * .2,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/banner.png"))),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                ),
              ),
            ),
            Positioned(
                top: 25,
                left: 20,
                child: Container(
                  color: Colors.grey.withOpacity(0.1),
                  child: DefaultTextStyle(
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 40.0,
                      fontFamily: 'Horizon',
                    ),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: listAnimatedText!,
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                  ),
                )),
            Positioned(
                top: 70,
                left: 20,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: SizedBox(
                    height: 30,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        onPressed: () {
                          navigateTo(context,
                              GovernmentJobs(userMobile: widget.userMobile));
                        },
                        child: const Text(
                          'Government Jobs',
                          style: TextStyle(fontSize: 10),
                        )),
                  ),
                )),
          ],
        );
      case Status.ERROR:
        return const Center(
          child: Text('Please try again latter!!!'),
        );
      case Status.INITIAL:
      default:
        return Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
              height: MediaQuery.of(context).size.height * .2,
              width: double.infinity,
              child: LoadingWidget.rectangular(
                  height: MediaQuery.of(context).size.height * .2,
                  width: MediaQuery.of(context).size.width)),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    ApiResponse apiResponse = Provider.of<ApiViewModel>(context).response;
    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: getFlashingTextWidget(context, apiResponse));
  }
}
