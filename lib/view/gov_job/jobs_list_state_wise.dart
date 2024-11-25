import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ows_bigcareer/model/apis/api_response.dart';
import 'package:ows_bigcareer/model/firebase/firebase_service.dart';
import 'package:ows_bigcareer/model/models/model_jobs_final.dart';
import 'package:ows_bigcareer/model/models/model_jobs_homepage.dart';
import 'package:ows_bigcareer/view/gov_job/apply_for_job.dart';
import 'package:ows_bigcareer/view_model/api_view_model.dart';
import 'package:provider/provider.dart';
import 'widgets/cardJobsStateWise.dart';

class ListGovernmentJobsStateWise extends StatefulWidget {
  const ListGovernmentJobsStateWise(
      {Key? key,
      required this.title,
      required this.stateId,
      required this.userMobile})
      : super(key: key);
  final title, stateId, userMobile;

  @override
  _ListGovernmentJobsStateWiseState createState() =>
      _ListGovernmentJobsStateWiseState();
}

class _ListGovernmentJobsStateWiseState
    extends State<ListGovernmentJobsStateWise> {
  FirebaseService firebaseServices = FirebaseService();

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ApiViewModel>(context, listen: false).fetchDataJobSearch(
        ModelJobsFinal(),
        'select_job_state_wise_api.php',
        {"state_id": widget.stateId.toString()});
    super.initState();
  }

  Widget getJobsStateWiseWidget(
      BuildContext context, ApiResponseJobSearch apiResponse) {
    List<dynamic>? mediaList = apiResponse.data as List<dynamic>?;
    switch (apiResponse.status) {
      case Status.LOADING:
        return const Center(child: CircularProgressIndicator());
      case Status.COMPLETED:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                flex: 8,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: mediaList!.length,
                    itemBuilder: (context, index) {
                      return mediaList![0].successCode == '0'
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(child: const Text('No Data Found !')),
                              ],
                            )
                          : GestureDetector(
                              onTap: () {},
                              child: Center(
                                child: SizedBox(
                                  height: 350,
                                  width: MediaQuery.of(context).size.width * .9,
                                  child: CardJobStateWise(
                                      userMobile: widget.userMobile,
                                      index: index,
                                  job: mediaList),
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
    ApiResponseJobSearch apiResponse =
        Provider.of<ApiViewModel>(context).responseJobSearch;
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
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.indigo),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
                height: MediaQuery.of(context).size.height * .9,
                child: getJobsStateWiseWidget(context, apiResponse)),
          ],
        ),
      ),
    );
  }
}
