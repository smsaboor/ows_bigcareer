import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:ows_bigcareer/view/search/json_statewithcities.dart';
import 'package:ows_bigcareer/view/search/model_state_with_cities.dart';
import 'jobs_list_state_wise.dart';

class GovernmentJobs extends StatefulWidget {
  const GovernmentJobs({Key? key, required this.userMobile}) : super(key: key);
  final userMobile;

  @override
  State<GovernmentJobs> createState() => _GovernmentJobsState();
}

class _GovernmentJobsState extends State<GovernmentJobs> {
  List<ModelStates>? listStatesWithCities;
  int selecteState = 0;
  int selecteCity = 0;

  getStatesWithCities() {
    listStatesWithCities =
        jsonStatesWithCity2.map((i) => ModelStates.fromJson(i)).toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    getStatesWithCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select Your State'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: listStatesWithCities!.length,
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Column(
                        children: [
                          Container(
                              height: 50,
                              color: Colors.grey.shade50,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 18.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        '${listStatesWithCities![index].statename}, ${listStatesWithCities![index].id}',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          const Divider(
                            color: Colors.black,
                          ),
                        ],
                      ),
                      onTap: () {
                        if (mounted) {
                          setState(() {
                            selecteCity = 0;
                            selecteState = index;
                            navigateTo(
                                context,
                                ListGovernmentJobsStateWise(
                                    userMobile:widget.userMobile,
                                    title:
                                        listStatesWithCities![index].statename,
                                    stateId: listStatesWithCities![index].id));
                          });
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
