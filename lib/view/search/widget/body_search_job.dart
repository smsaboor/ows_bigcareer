import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:ows_bigcareer/model/models/model_jobs_final.dart';
import 'package:ows_bigcareer/view/search/json_statewithcities.dart';
import 'package:ows_bigcareer/view/search/model_state_with_cities.dart';
import 'package:ows_bigcareer/view/search/popup_location.dart';
import 'package:ows_bigcareer/view/search/widget/search_bar_job.dart';
import 'package:ows_bigcareer/view/search/widget/search_bar_location.dart';
import 'package:ows_bigcareer/view_model/api_view_model.dart';
import 'package:provider/provider.dart';

class BodySearchJob extends StatefulWidget {
  BodySearchJob(
      {Key? key,
      required this.controllerSearchKeyword,
      required this.controllerSearchLocationId,
      required this.controllerSearchLocation,
        required this.viewFilter,
        required this.body,
        required this.onTapSearchKeywords,
        required this.onSearchTextChanged
      })
      : super(key: key);
  var controllerSearchKeyword,
      controllerSearchLocationId,
      controllerSearchLocation;
  var viewFilter;
  final Widget body;
  var onTapSearchKeywords, onSearchTextChanged;
  @override
  State<BodySearchJob> createState() => _BodySearchJobState();
}

class _BodySearchJobState extends State<BodySearchJob> {

  List<StatesWithCities>? listStatesWithCities;

  int selecteState = 0;
  int selecteCity = 0;

  getStatesWithCities() {
    listStatesWithCities =
        jsonStatesWithCity.map((i) => StatesWithCities.fromJson(i)).toList();
  }
@override
  void initState() {
    // TODO: implement initState
  getStatesWithCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: widget.viewFilter
                ? MediaQuery.of(context).size.height * .07
                : MediaQuery.of(context).size.height * .18,
            child: Column(
              children: [
                SizedBox(
                    height: 55,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: SearchBarJob(
                          controller: widget.controllerSearchKeyword,
                          onSubmited: (val) {
                            widget.controllerSearchKeyword.text = val.toString();
                            if (widget.controllerSearchKeyword.text.isEmpty) {
                              showToast(msg: 'please enter a Keyword');
                            } else {
                              if ( widget.viewFilter) {
                                Provider.of<ApiViewModel>(context,
                                        listen: false)
                                    .fetchDataFilterJob(ModelJobsFinal(),
                                        'all_filters_api.php', {
                                  "state_id": widget.controllerSearchLocationId.text,
                                  "salary": '12000',
                                  "keyword": widget.controllerSearchKeyword.text,
                                  "education": 'GRADUATION',
                                });
                              } else {
                                Provider.of<ApiViewModel>(context,
                                        listen: false)
                                    .fetchDataFilterJob(ModelJobsFinal(),
                                        'all_filters_api.php', {
                                  "state_id": widget.controllerSearchLocationId.text,
                                  "salary": '12000',
                                  "keyword": widget.controllerSearchKeyword.text,
                                  "education": 'GRADUATION',
                                });
                              }
                              setState(() {
                                widget.viewFilter = true;
                              });
                            }
                          },
                          onTap: widget.onTapSearchKeywords,
                          onChanged: widget.onSearchTextChanged),
                    )),
                widget.viewFilter
                    ? Container()
                    : SizedBox(
                        height: 48,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 22.0, right: 20),
                          child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return FractionallySizedBox(
                                          heightFactor: 1,
                                          child: PopUpLocation(
                                            onLocationChanged:
                                                (String stateIndex) {
                                              for (int i = 0;
                                                  i <
                                                      listStatesWithCities!
                                                          .length;
                                                  i++) {
                                                if (listStatesWithCities![i]
                                                        .id ==
                                                    stateIndex) {
                                                  setState(() {
                                                    widget.controllerSearchLocation
                                                            .text =
                                                        listStatesWithCities![i]
                                                            .state!;
                                                    widget.controllerSearchLocationId
                                                            .text =
                                                        listStatesWithCities![i]
                                                            .id!;
                                                  });
                                                }
                                              }
                                              setState(() {});
                                            },
                                          ));
                                    });
                              },
                              child: SearchBarLocation(
                                controller: widget.controllerSearchLocation,
                              )),
                        )),
              ],
            ),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width,
              child: widget.body)
        ],
      ),
    );
  }
}
