import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ows_bigcareer/model/models/model_jobs_final.dart';
import 'package:ows_bigcareer/view_model/api_view_model.dart';
import 'package:provider/provider.dart';
import 'widget/filter_container.dart';
import 'widget/filter_heading.dart';

class PopUpFilter extends StatefulWidget {
  const PopUpFilter(
      {Key? key,
      required this.searchText,
      required this.searchLocation,
      required this.onLocationChanged})
      : super(key: key);
  final searchText, searchLocation;
  final onLocationChanged;

  @override
  State<PopUpFilter> createState() => _PopUpFilterState();
}

class _PopUpFilterState extends State<PopUpFilter> {
  static var jsonEducation1 = {
    {"id": "1", "Education": "Doctorate"},
    {"id": "2", "Education": "Masters"},
    {"id": "3", "Education": "Graduate"},
    {"id": "4", "Education": "Diploma"},
    {"id": "5", "Education": "Itermediate"},
    {"id": "6", "Education": "HighSchool"},
    {"id": "7", "Education": "others"}
  };
  static var jsonEducation = [
    "Doctorate",
    "Masters",
    "Graduate",
    "Diploma",
    "Intermediate",
    "High School",
    "others"
  ];
  static var jsonSalary2 = {
    {"id": "1", "salary": "10k"},
    {"id": "2", "Education": "20k"},
    {"id": "3", "Education": "30k"},
    {"id": "4", "Education": "40k"},
    {"id": "5", "Education": "50k"},
    {"id": "6", "Education": "60k"},
    {"id": "7", "Education": "100k"}
  };
  static var jsonSalary = ["10", "20", "30", "40", "50", "60", "100","500"];

  int currentEducation = 2;
  int currentSalary = 3;
  String currentEducationName = 'Graduate';
  String currentSalaryName = '40k';

  // var mainFromJson = Cities.fromJson(jsonStatesCity);

  @override
  void initState() {
    // TODO: implement initState
    print('-------------------saboorkhan${widget.searchLocation}');
    super.initState();
  }

  int selecteState = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 500,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 10, bottom: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      child: const FaIcon(FontAwesomeIcons.xmark,
                          color: Colors.black, size: 22),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * .3),
                      child: const Text(
                        'Filter',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const FilterHeading(
                title: 'Required Education',
              ),
              GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 5.0,
                shrinkWrap: true,
                childAspectRatio: (MediaQuery.of(context).size.width * .3 / 40),
                children: List.generate(
                  jsonEducation.length,
                  (index) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            currentEducation = index;
                            currentEducationName = jsonEducation[index];
                          });
                        },
                        child: FilterContainer(
                          isSelected: currentEducation == index,
                          title: jsonEducation[index],
                        ));
                  },
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const FilterHeading(
                title: 'Salary (up to)',
              ),
              GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 5.0,
                shrinkWrap: true,
                childAspectRatio: (MediaQuery.of(context).size.width * .3 / 40),
                children: List.generate(
                  jsonSalary.length,
                  (index) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            currentSalary = index;
                            currentSalaryName = '${int.parse(jsonSalary[index])*1000}';
                          });
                        },
                        child: FilterContainer(
                          isSelected: currentSalary == index,
                          title: '${jsonSalary[index]}K',
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      widget.onLocationChanged('$currentEducationName,$currentSalaryName');
                      // Provider.of<ApiViewModel>(context, listen: false)
                      //     .fetchDataFilterJob(
                      //         ModelJobsFinal(), 'all_filters_api.php', {
                      //   "state_id": widget.searchLocation,
                      //   "salary": currentSalaryName,
                      //   "keyword": widget.searchText,
                      //   "education": currentEducationName,
                      // });
                      Navigator.pop(context);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    child: Text('Apply'))))
      ],
    );
  }
}

class Main {
  String title;
  Sub sub;
  List<Sub> subList;

  Main(this.title, this.sub, this.subList);

  Main.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        sub = Sub.fromJson(json['sub']),
        subList = List<dynamic>.from(json['sub_list'])
            .map((i) => Sub.fromJson(i))
            .toList();

  Map<String, dynamic> toJson() => {
        'title': title,
        'sub': sub.toJson(),
        'sub_list': subList.map((item) => item.toJson()).toList(),
      };
}

class Sub {
  String name;
  int n;

  Sub(this.name, this.n);

  Sub.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        n = json['n'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'n': n,
      };
}

class Cities {
  String? city;
  List<CityList>? cityList;

  Cities({this.city, this.cityList});

  Cities.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    if (json['city_list'] != null) {
      cityList = <CityList>[];
      json['city_list'].forEach((v) {
        cityList!.add(new CityList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    if (this.cityList != null) {
      data['city_list'] = this.cityList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CityList {
  String? city;

  CityList({this.city});

  CityList.fromJson(Map<String, dynamic> json) {
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    return data;
  }
}
