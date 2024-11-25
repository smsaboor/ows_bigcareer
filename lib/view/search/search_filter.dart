import 'package:flutter/material.dart';
import 'package:ows_bigcareer/model/models/model_jobs_final.dart';
import 'package:ows_bigcareer/view/search/json_statewithcities.dart';
import 'package:ows_bigcareer/view/search/model_state_with_cities.dart';
import 'package:ows_bigcareer/view/search/popup_filter.dart';
import 'package:ows_bigcareer/view/search/popup_location.dart';
import 'package:ows_bigcareer/view_model/api_view_model.dart';
import 'package:provider/provider.dart';

class JobFilterBar extends StatefulWidget {
  const JobFilterBar(
      {Key? key, required this.searchText, required this.searchLocation, required this.searchLocationId})
      : super(key: key);
  final searchText;
  final searchLocation,searchLocationId;

  @override
  State<JobFilterBar> createState() => _JobFilterBarState();
}

class _JobFilterBarState extends State<JobFilterBar> {
  bool search = false;
  final TextEditingController _controllerSearch = TextEditingController();
  final TextEditingController _controllerSearchLocation =
      TextEditingController();
  final TextEditingController _controllerSearchLocationId =
  TextEditingController();

  List<StatesWithCities>? listStatesWithCities;

  int selecteState = 0;
  int selecteCity = 0;

  getStatesWithCities() {
    listStatesWithCities =
        jsonStatesWithCity.map((i) => StatesWithCities.fromJson(i)).toList();
  }

  @override
  void initState() {
    print('-----------------saboorkhan2${widget.searchLocation}');
    getStatesWithCities();
    // TODO: implement initState
    _controllerSearch.text = widget.searchText;
    _controllerSearchLocation.text = widget.searchLocation;
    _controllerSearchLocationId.text = widget.searchLocationId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Widget searchBox = Container(
    //   padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
    //   margin: const EdgeInsets.only(bottom: 5),
    //   child: TextField(
    //       controller: _controllerSearch,
    //       style: TextStyle(fontSize: 12, color: Colors.grey[600]),
    //       decoration: InputDecoration(
    //         enabledBorder: OutlineInputBorder(
    //             borderSide: const BorderSide(
    //               color: Colors.black54,
    //             ),
    //             borderRadius: BorderRadius.circular(30)),
    //         focusedBorder: OutlineInputBorder(
    //             borderSide: const BorderSide(
    //               color: Colors.black54,
    //             ),
    //             borderRadius: BorderRadius.circular(30)),
    //         prefixIcon: const Icon(
    //           Icons.search,
    //           size: 20,
    //           color: Colors.black,
    //         ),
    //         border: InputBorder.none,
    //         prefixIconColor: Colors.blue,
    //         prefixStyle: const TextStyle(fontWeight: FontWeight.w600),
    //         hintText: 'Job Title, Keyword or Company',
    //         contentPadding: const EdgeInsets.only(
    //           left: 10,
    //           right: 20,
    //           top: 5,
    //           bottom: 5,
    //         ),
    //       )),
    // );
    return SizedBox(
        height: MediaQuery.of(context).size.height * .07, child: SearchPage());
  }

  Widget SearchPage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return FractionallySizedBox(
                        heightFactor: 1,
                        child: PopUpLocation(
                          onLocationChanged: (String stateIndex) {
                            for(int i=0;i<listStatesWithCities!.length;i++){
                              if(listStatesWithCities![i].id==stateIndex){
                                setState(() {
                                  _controllerSearchLocation.text=listStatesWithCities![i].state!;
                                  _controllerSearchLocationId.text=listStatesWithCities![i].id!;
                                });
                              }
                            }
                            setState(() {
                            });
                            Provider.of<ApiViewModel>(context,
                                listen: false)
                                .fetchDataFilterJob(ModelJobsFinal(),
                                'all_filters_api.php', {
                                  "state_id": stateIndex,
                                  "salary": '12000',
                                  "keyword": widget.searchText,
                                  "education": 'GRADUATION',
                                });
                          },
                        ));
                  });
            },
            child: Container(
                color: Colors.grey.shade200,
                width: MediaQuery.of(context).size.width * .38,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        _controllerSearchLocation.text,
                        style: const TextStyle(fontSize: 10),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      )
                    ],
                  ),
                )),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return FractionallySizedBox(
                        heightFactor: 1, child: PopUpFilter(
                      searchText:widget.searchText,
                      searchLocation:_controllerSearchLocationId.text,
                      onLocationChanged: (String eduWithSalary) {
                        var values=eduWithSalary.split(',');
                        Provider.of<ApiViewModel>(context,
                            listen: false)
                            .fetchDataFilterJob(ModelJobsFinal(),
                            'all_filters_api.php', {
                              "state_id": _controllerSearchLocationId.text,
                              "salary": values[1].replaceAll('k', '000'),
                              "keyword": widget.searchText,
                              "education": values[0].toUpperCase(),
                            });
                      },
                    ));
                  });
            },
            child: Container(
                color: Colors.grey.shade200,
                width: MediaQuery.of(context).size.width * .25,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Text('Filter'),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
