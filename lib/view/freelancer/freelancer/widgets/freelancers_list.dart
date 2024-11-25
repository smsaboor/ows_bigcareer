import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:ows_bigcareer/model/apis/api_response.dart';
import 'package:ows_bigcareer/model/firebase/firebase_service.dart';
import 'package:ows_bigcareer/model/models/model_freelancers.dart';
import 'package:ows_bigcareer/view/freelancer/freelancer/freelancer_profile.dart';
import 'package:ows_bigcareer/view/freelancer/freelancer/hire_freelancer.dart';
import 'package:ows_bigcareer/view/freelancer/freelancer/widgets/freelancer_card.dart';

class FreelancersListWidget extends StatefulWidget {
  final Function _function;
  final apiResponse;
  final userMobile;
  const FreelancersListWidget(this._function, this.apiResponse, {super.key, required this.userMobile});
  @override
  _FreelancersListWidgetState createState() => _FreelancersListWidgetState();
}

class _FreelancersListWidgetState extends State<FreelancersListWidget> {
  FirebaseService firebaseServices=FirebaseService();
  @override
  Widget build(BuildContext context) {
    List<dynamic>? dynamicDataList = widget.apiResponse.data as List<dynamic>?;
    switch (widget.apiResponse.status) {
      case Status.LOADING:
        return const Center(child: CircularProgressIndicator());
      case Status.COMPLETED:
        return Column(
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
                    ModelFreelancers data = dynamicDataList[index];
                    return InkWell(
                      onTap: () {
                        navigateTo(
                            context,
                            FreelancerProfile(
                              mobile: widget.userMobile,
                              freelancer: data,
                            ));
                      },
                      child: data.title == null
                          ? const Center(
                              child: Text('Data Not Found'),
                            )
                          : FreelancerCard(freelancer: data,userMobile: widget.userMobile),
                    );
                  },
                )),
          ],
        );
      case Status.ERROR:
        return const Center(
          child: Text('Please try again latter!!!'),
        );
      case Status.INITIAL:
      default:
        return const Center(
          child: Text('Search the Freelancers'),
        );
    }
  }
}
