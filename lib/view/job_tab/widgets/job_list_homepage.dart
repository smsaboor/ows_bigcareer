
import 'package:flutter/material.dart';
import 'package:ows_bigcareer/model/apis/api_response.dart';
import 'package:ows_bigcareer/model/models/model_jobs_final.dart';
import 'package:ows_bigcareer/view_model/api_view_model.dart';
import 'package:provider/provider.dart';
import '../card_job/header.dart';
import '../card_job/title_job.dart';
import '../card_job/card_image.dart';
import '../card_job/bottom_job_card.dart';
import 'package:flutter_package1/loading/loading1.dart';

class JobsListHomePage extends StatefulWidget {
  const JobsListHomePage({Key? key, required this.userMobile})
      : super(key: key);
  final userMobile;
  @override
  State<JobsListHomePage> createState() => _JobsListHomePageState();
}

class _JobsListHomePageState extends State<JobsListHomePage> {
  bool dataLoad = true;
  List<ModelJobsFinal>? fetchedJobs;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ApiViewModel>(context, listen: false)
        .fetchDataJobsHomePage(ModelJobsFinal(), 'latest_job_post_api.php', null);
    super.initState();
  }

  Widget getJobsHomePageWidget(BuildContext context, ApiResponseJobHomePage apiResponse) {
    final width = MediaQuery.of(context).size.width;
    List<dynamic>? mediaList = apiResponse.data as List<dynamic>?;
    switch (apiResponse.status) {
      case Status.LOADING:
        return  Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.width + 210,
            width: MediaQuery.of(context).size.width * .95,
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
              child: Container(
                  height: MediaQuery.of(context).size.width + 210,
                  width: MediaQuery.of(context).size.width * .95,
                  child: LoadingWidget.rectangular(
                      height: MediaQuery.of(context).size.height * .2,
                      width: MediaQuery.of(context).size.width)),
            ),
          ),
        );
      case Status.COMPLETED:
        return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: mediaList!.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    child: Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width + 210,
                        width: MediaQuery.of(context).size.width * .95,
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
                                jobs: mediaList![index],
                                apiResponse: apiResponse,
                                height: 28.0,
                                width: 110.0,
                              ),
                              TitleJob(
                                jobs: mediaList![index],
                                height: 100.0,
                              ),
                              ImageJobCard(
                                jobs: mediaList![index],
                                height: width,
                                width: width,
                              ),
                              BottomCardJob(
                                userMobile:widget.userMobile,
                                jobs: mediaList![index],
                                height: 50.0,
                                width: width * .95,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              );
            });
      case Status.ERROR:
        return const Center(
          child: Text('Error in loading data'),
        );
      case Status.INITIAL:
      default:
      return  Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.width + 210,
          width: MediaQuery.of(context).size.width * .95,
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
            child: Container(
                height: MediaQuery.of(context).size.width + 210,
                width: MediaQuery.of(context).size.width * .95,
                child: LoadingWidget.rectangular(
                    height: MediaQuery.of(context).size.height * .2,
                    width: MediaQuery.of(context).size.width)),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ApiResponseJobHomePage apiResponse = Provider.of<ApiViewModel>(context).responseJobHomePage;
    return getJobsHomePageWidget(context, apiResponse);
  }
}
