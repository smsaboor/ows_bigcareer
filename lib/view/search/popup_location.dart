import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ows_bigcareer/view/search/model_state_with_cities.dart';
import 'package:ows_bigcareer/view/search/json_statewithcities.dart';

class PopUpLocation extends StatefulWidget {
  final onLocationChanged;

  PopUpLocation({Key? key, this.onLocationChanged}) : super(key: key);

  @override
  State<PopUpLocation> createState() => _PopUpLocationState();
}

class _PopUpLocationState extends State<PopUpLocation> {
  List<StatesWithCities>? listStatesWithCities;

  int selecteState = 0;
  int selecteCity = 0;
  String currentStateId="23";

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
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 22.0, top: 10, bottom: 10),
          child: Row(
            children: [
              GestureDetector(
                child: const FaIcon(FontAwesomeIcons.xmark,
                    color: Colors.black, size: 28),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * .3),
                child: const Text(
                  'Select Location',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
        Row(
          children: [
            Column(
              children: [
                Container(
                    color: Colors.grey.shade200,
                    height: 40,
                    width: MediaQuery.of(context).size.width * .4,
                    child: const Center(
                      child: Text(
                        'Select States',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    )),
                Container(
                  width: MediaQuery.of(context).size.width * .4,
                  height: MediaQuery.of(context).size.height * .8,
                  color: Colors.grey.shade200,
                  child: ListView.builder(
                    itemCount: listStatesWithCities!.length,
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Container(
                            height: 45,
                            color: selecteState == index
                                ? Colors.white
                                : Colors.grey.shade200,
                            child: Center(
                                child: Text(
                              '${listStatesWithCities![index].state}',
                              style: TextStyle(
                                  color: selecteState == index
                                      ? Colors.green
                                      : Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ))),
                        onTap: () {
                          if (mounted) {
                            setState(() {
                              selecteCity = 0;
                              selecteState = index;
                              currentStateId=listStatesWithCities![index].id!;
                            });
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(
                    height: 45,
                    child: Center(
                      child: Text('Popular Cities'),
                    )),
                Container(
                  width: MediaQuery.of(context).size.width * .6,
                  height: MediaQuery.of(context).size.height * .8,
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount:
                        listStatesWithCities![selecteState].cities!.length,
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Container(
                            height: 40,
                            color: Colors.white,
                            child: Center(
                                child: Text(
                              '${listStatesWithCities![selecteState].cities![index].city}',
                              style: TextStyle(
                                  color: selecteCity == index
                                      ? Colors.green
                                      : Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ))),
                        onTap: () {
                          widget.onLocationChanged!('${currentStateId}');
                          Navigator.pop(context);
                          // setState(() {
                          //   selecteCity = index;
                          //   if (listStatesWithCities![selecteState]
                          //       .cities![index]
                          //       .city ==
                          //       'All') {
                          //     print('------------${listStatesWithCities![selecteState].state},${listStatesWithCities![selecteState].id}');
                          //     widget.onLocationChanged!(
                          //         '${listStatesWithCities![selecteState].state}','${listStatesWithCities![selecteState].id}');
                          //   } else {
                          //     widget.onLocationChanged!(
                          //         '${listStatesWithCities![selecteState].cities![index].city}','${listStatesWithCities![selecteState].id}');
                          //   }
                          //   Navigator.pop(context);
                          // });
                        },
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
