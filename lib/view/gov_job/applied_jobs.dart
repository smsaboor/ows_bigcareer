import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:ows_bigcareer/model/apis/api_response.dart';
import 'package:ows_bigcareer/view_model/api_view_model.dart';
import 'package:provider/provider.dart';
import 'package:ows_bigcareer/model/models/model_job_applied_response.dart';
import 'full_display_applied_jobs.dart';

class AppliedJobs extends StatefulWidget {
  const AppliedJobs({super.key,required this.userMobile});
  final userMobile;
  @override
  _AppliedJobsState createState() => _AppliedJobsState();
}

class _AppliedJobsState extends State<AppliedJobs> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ApiViewModel>(context, listen: false).fetchDataAppliedJobs(
        ModelJobsAppliedResponse(), 'display_applied_jobs.php', {"user_id":widget.userMobile.toString()});
    super.initState();
  }

  Widget getAppliedJobsWidget(
      BuildContext context, ApiResponseJobs apiResponse) {
    List<dynamic>? mediaList = apiResponse.data as List<dynamic>?;
    switch (apiResponse.status) {
      case Status.LOADING:
        return const Center(child: CircularProgressIndicator());
      case Status.COMPLETED:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                flex: 4,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: mediaList!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          navigateTo(context, FullDisplayAppliedJob(data: mediaList[index],));
                        },
                        child: Center(
                          child: SizedBox(
                            height: 300,
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
                                    height: 170,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 80,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0, top: 25),
                                            child: Column(
                                              children: [
                                                Text(
                                                  mediaList![index].jobTitle??'',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 18.0, top: 3.0, right: 37),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Applicant:',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black),
                                              ),
                                              SizedBox(width: 50,),
                                              Text(
                                                mediaList![index].name??'',
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                            ],
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
                                                'Applied Date',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black),
                                              ),
                                              Spacer(),
                                              Text(
                                                mediaList![index].dateTime??'',
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
                                              left: 18.0, top: 3.0, right: 27),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Used Mobile',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.redAccent),
                                              ),
                                              SizedBox(width: 40,),
                                              Text(
                                                mediaList![index].mobile??'',
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
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0,right: 15),
                                    child: SizedBox(
                                      height: 110,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          mediaList![index].image1.toString().contains('http')?
                                          SizedBox(
                                            height: 100,
                                            width: 70,
                                            child: Image.network(mediaList![index].image1)):Container(),
                                        SizedBox(width: 3,),
                                          mediaList![index].image2.toString().contains('http')?
                                          SizedBox(
                                              height: 100,
                                              width: 70,
                                              child: Image.network(mediaList![index].image2)):Container(),
                                        SizedBox(width: 3,),
                                          mediaList![index].image3.toString().contains('http')?
                                          SizedBox(
                                              height: 100,
                                              width: 70,
                                              child: Image.network(mediaList![index].image3)):Container(),
                                        SizedBox(width: 3,),
                                          mediaList![index].image4.toString().contains('http')?
                                          SizedBox(
                                              height: 100,
                                              width: 70,
                                              child: Image.network(mediaList![index].image4)):Container(),
                                        SizedBox(width: 3,),
                                          mediaList![index].image5.toString().contains('http')?
                                          SizedBox(
                                              height: 100,
                                              width: 70,
                                              child: Image.network(mediaList![index].image5)):Container(),
                                      ],),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    })),
          ],
        );
      case Status.ERROR:
        return const Center(
          child: Text('No data Found'),
        );
      case Status.INITIAL:
      default:
        return const Center(
          child: Text('loading...'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _inputController = TextEditingController();
    ApiResponseJobs apiResponse =
        Provider.of<ApiViewModel>(context).responseAppliedJob;
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
          'Applied Jobs',
          style: TextStyle(color: Colors.indigo),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
                height: MediaQuery.of(context).size.height * .9,
                child: getAppliedJobsWidget(context, apiResponse)),
          ],
        ),
      ),
    );
  }
}
