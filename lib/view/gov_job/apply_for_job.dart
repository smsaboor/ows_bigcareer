import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_package1/package2/date.dart';
import 'package:flutter_package1/package2/select_dialog.dart';
import 'package:ows_bigcareer/model/models/model_jobs_final.dart';
import 'package:ows_bigcareer/model/models/model_job_applied.dart';
import 'package:ows_bigcareer/view/freelancer/projects/project_service.dart';
import 'package:ows_bigcareer/view_model/sharedpreferences_view_model.dart';
import 'package:provider/provider.dart';
import 'qualification.dart';
import 'widgets/introduction.dart';
import 'package:ows_bigcareer/model/apis/urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_package1/package2/CustomFormField.dart';
import 'package:ows_bigcareer/model/models/model_app_user.dart';
import 'package:intl/intl.dart';
import 'package:flutter_package1/components.dart';
import 'dart:io';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ows_bigcareer/view/gov_job/upload_documents.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:percent_indicator/linear_percent_indicator.dart';

class ApplyForJob extends StatefulWidget {
  const ApplyForJob({Key? key, required this.title, required this.data})
      : super(key: key);
  final title;
  final ModelJobsFinal data;

  @override
  State<ApplyForJob> createState() => _ApplyForJobState();
}

class _ApplyForJobState extends State<ApplyForJob> {
  bool youCanApply = false;
  String? gender = 'Male';
  String qualification = 'Graduation';
  bool flagUserData = true;
  bool checkBoxValue = false;
  bool flagAddJob = false;
  bool flagShowDeclaration = false;
  bool flag1 = true;
  bool flag2 = true;
  bool flag3 = true;
  bool flag4 = true;

  bool flagHighSchool = false;
  bool flagInter = false;
  bool flagGrad = false;
  bool flagPostGra = false;

  var stateInitial = "Andhra Pradesh";
  var stateList = [
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jammu and Kashmir",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttarakhand",
    "Uttar Pradesh",
    "West Bengal",
    "Andaman and Nicobar Islands",
    "Chandigarh",
    "Dadra and Nagar Haveli",
    "Daman and Diu",
    "Delhi",
    "Lakshadweep",
    "Puducherry"
  ];
  bool imageLoad = false;
  String imageLoadMsg = 'Please load minimum 1 image';
  bool flagListImageFromMobile = false;
  List<File>? listImageFromMobile;
  List<XFile>? pickedFile=[];
  List<String>? uploadImagesPath = ['','','','',''];
  List<bool> flagImageList = [false, false, false, false, false];
  int imageLength = 0;
  double percent = 0.0;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double heightTF = 30;
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerMobile = TextEditingController();
  final TextEditingController _controllerAltMobile = TextEditingController();
  final TextEditingController _controlleremail = TextEditingController();
  final TextEditingController _controllerDOB = TextEditingController();

  final TextEditingController _controllerQualification =
      TextEditingController();
  final TextEditingController _controllerFatherName = TextEditingController();
  final TextEditingController _controllerMotherName = TextEditingController();
  final TextEditingController _controllerState = TextEditingController();
  final TextEditingController _controllerDistrict = TextEditingController();
  final TextEditingController _controllerCity = TextEditingController();
  final TextEditingController _controllerPin = TextEditingController();

  final TextEditingController _controllerHighSchName = TextEditingController();
  final TextEditingController _controllerHighSchPer = TextEditingController();
  final TextEditingController _controllerHighSchTotal = TextEditingController();
  final TextEditingController _controllerHighSchYear = TextEditingController();

  final TextEditingController _controllerInterName = TextEditingController();
  final TextEditingController _controllerInterPer = TextEditingController();
  final TextEditingController _controllerInterTotal = TextEditingController();
  final TextEditingController _controllerInterYear = TextEditingController();

  final TextEditingController _controllerGraName = TextEditingController();
  final TextEditingController _controllerGraPer = TextEditingController();
  final TextEditingController _controllerGraTotal = TextEditingController();
  final TextEditingController _controllerGraYear = TextEditingController();

  final TextEditingController _controllerPostGraName = TextEditingController();
  final TextEditingController _controllerPostGraPer = TextEditingController();
  final TextEditingController _controllerPostGraTotal = TextEditingController();
  final TextEditingController _controllerPostYear = TextEditingController();
  final TextEditingController _controllerOther = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late AppUser appUser;

  getUserDetails() async {
    var sharedPreferencesVM =
        Provider.of<SharedPreferencesVM>(context, listen: false);
    appUser = await sharedPreferencesVM.getUserDetails();
    setState(() {
      flagUserData = false;
    });
  }

  @override
  void initState() {
    Timer? timer;
    timer = Timer.periodic(const Duration(milliseconds: 1000), (_) {
      setState(() {
        percent += 20;
        if (percent >= 100) {
          timer!.cancel();
          // percent=0;
        }
      });
    });
    // TODO: implement initState
    print('--initState----------------${widget.data.toJson()}');
    final DateTime now = DateTime.now();
    final DateFormat format = DateFormat('dd-MM-yyyy');
    final String formatted = format.format(now);
    DateTime todayInputDate = DateFormat("dd-MM-yyyy").parse(formatted);
    DateTime jobLastDate = DateFormat("dd-MM-yyyy").parse(widget.data.lastDate!);
    print('--todayInputDate----------------: ${todayInputDate.runtimeType}');
    print('--todayInputDate----------------: ${todayInputDate}');
    print('--jobLastDate----------------: ${jobLastDate.runtimeType}');
    print('--jobLastDate----------------: ${jobLastDate}');
    print('--jobLastDate.isAfter(todayInputDate)----------------: ${jobLastDate.isAfter(todayInputDate)}');
    print('--jobLastDate.isAfter(todayInputDate)----------------: ${jobLastDate.isBefore(todayInputDate)}');
    print('--jobLastDate.isAfter(todayInputDate)----------------: ${jobLastDate.isAtSameMomentAs(todayInputDate)}');
    if (jobLastDate.isAtSameMomentAs(todayInputDate)) {
      setState(() {
        youCanApply = true;
      });
      print("Both date time are at same moment.");
    }
    if (jobLastDate.isAfter(todayInputDate)) {
     setState(() {
       youCanApply = true;
     });
      print("you can apply because date is available");
    }

    if (jobLastDate.isBefore(todayInputDate)) {
      setState(() {
        youCanApply = true;
      });
      print("you can't apply because date is over");
    }
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              flagUserData
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : getFormData()
            ],
          ),
        ),
      ),
    );
  }

  getFormData() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18, top: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                youCanApply?Container():Text(
                  "Sorry, You can't apply because applied last date was ${widget.data.lastDate} which is over.",
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
                const SizedBox(
                  height: 5,
                ),
                ExpansionTileIntroduction(
                  flag: true,
                  data: widget.data,
                ),
                const SizedBox(
                  height: 10,
                ),
                ExpansionTile(
                  initiallyExpanded: true,
                  collapsedIconColor: Colors.black,
                  collapsedTextColor: Colors.black,
                  iconColor: Colors.black,
                  collapsedBackgroundColor: Colors.orange,
                  title: const Text(
                    'Basic Details',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: <Widget>[
                    buildHeading('1. Name of Participation', true),
                    buildTextFormField(_controllerName, TextInputType.name),
                    buildHeading('2. Mobile Number', true),
                    buildTextFormField(_controllerMobile, TextInputType.number),
                    buildHeading('3. Alternative Number', true),
                    buildTextFormField(
                        _controllerAltMobile, TextInputType.number),
                    buildHeading('4. email-id', true),
                    buildTextFormField(
                        _controlleremail, TextInputType.emailAddress),
                    buildHeading('5. D.O.B', true),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 12, bottom: 8, left: 18.0, right: 20),
                      child: SizedBox(
                        height: 35,
                        child: CustomDate(
                            controller: _controllerDOB,
                            initialDate: DateTime(2000),
                            firstDate: DateTime(1960),
                            lastDate: DateTime(2010),
                            validator: (value) {},
                            labelText: '(YYYY-MM-DD)'),
                      ),
                    ),
                    buildHeading('6. Gender', true),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 12, bottom: 8, left: 18.0, right: 20),
                      child: SizedBox(
                        height: 32,
                        child: GenderDialog(
                            onChanged: (gen) {
                              if (mounted) {
                                setState(() {
                                  gender = gen.toString();
                                });
                              }
                            },
                            initialValue: gender.toString(),
                            height: 35.0),
                      ),
                    ),
                    buildHeading('7. Qualification', true),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 12, bottom: 8, left: 18.0, right: 20),
                      child: SizedBox(
                        height: 32,
                        child: QualificationDialog(
                            onChanged: (qua) {
                              if (mounted) {
                                setState(() {
                                  qualification = qua.toString();
                                  _controllerQualification.text =
                                      qua.toString();
                                });
                              }
                            },
                            initialValue: qualification.toString(),
                            height: 35.0),
                      ),
                    ),
                    buildHeading('8. Father Name', true),
                    buildTextFormField(
                        _controllerFatherName, TextInputType.name),
                    buildHeading('9. Mother Name', true),
                    buildTextFormField(
                        _controllerMotherName, TextInputType.name),
                    buildHeading('10. State', true),
                    stateWidget(),
                    buildHeading('11. District', true),
                    buildTextFormField(_controllerDistrict, TextInputType.text),
                    buildHeading('12. City', true),
                    buildTextFormField(_controllerCity, TextInputType.text),
                    buildHeading('13. Pincode', true),
                    buildTextFormField(_controllerPin, TextInputType.number),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ExpansionTile(
                  initiallyExpanded: true,
                  collapsedIconColor: Colors.black,
                  collapsedTextColor: Colors.black,
                  collapsedBackgroundColor: Colors.orange,
                  iconColor: Colors.black,
                  title: Text(
                    'Educational Details $flag1',
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 28.0, top: 5, right: 10),
                        child: Row(
                          children: [
                            const Text(
                              'Add HighSchool Details',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    flagHighSchool = !flagHighSchool;
                                  });
                                },
                                icon: const Icon(
                                  Icons.add_circle_outline_sharp,
                                  size: 20,
                                  color: Colors.indigo,
                                ))
                          ],
                        ),
                      ),
                    ),
                    flagHighSchool
                        ? SizedBox(
                            width: 280,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0,
                                        right: 5,
                                        bottom: 10,
                                        top: 0),
                                    child: SizedBox(
                                      height: heightTF,
                                      width: 280,
                                      child: buildTextFormFieldTwo(
                                          1,
                                          2,
                                          false,
                                          _controllerHighSchName,
                                          'Enter Institute Name',
                                          'Institute Name',
                                          (value) {},
                                          (v) {},
                                          Icons.numbers,
                                          1,
                                          TextInputType.text),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0,
                                              right: 5,
                                              bottom: 0,
                                              top: 0),
                                          child: SizedBox(
                                            height: 35,
                                            child: buildTextFormFieldTwo(
                                                1,
                                                2,
                                                false,
                                                _controllerHighSchTotal,
                                                'Enter Total Marks',
                                                'Total',
                                                (value) {},
                                                (v) {},
                                                Icons.numbers,
                                                1,
                                                TextInputType.text),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0,
                                              right: 5,
                                              bottom: 0,
                                              top: 0),
                                          child: SizedBox(
                                            height: 35,
                                            child: buildTextFormFieldTwo(
                                                1,
                                                2,
                                                false,
                                                _controllerHighSchPer,
                                                'Enter Percentage',
                                                'Percentage',
                                                (value) {},
                                                (v) {},
                                                Icons.numbers,
                                                1,
                                                TextInputType.text),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 5, bottom: 0),
                                    child: SizedBox(
                                      height: 35,
                                      child: CustomDate(
                                        controller: _controllerHighSchYear,
                                        initialDate: DateTime(2010),
                                        firstDate: DateTime(1970),
                                        lastDate: DateTime(2022),
                                        validator: (value) {},
                                        labelText: 'Completed Year',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 28.0, top: 5, right: 10),
                        child: Row(
                          children: [
                            const Text(
                              'Add Intermediate Details',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    flagInter = !flagInter;
                                  });
                                },
                                icon: const Icon(
                                  Icons.add_circle_outline_sharp,
                                  size: 20,
                                  color: Colors.indigo,
                                ))
                          ],
                        ),
                      ),
                    ),
                    flagInter
                        ? getEducationalForm(
                            _controllerInterName,
                            _controllerInterTotal,
                            _controllerInterPer,
                            _controllerInterYear)
                        : Container(),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 28.0, top: 5, right: 10),
                        child: Row(
                          children: [
                            const Text(
                              'Add Graduation Details',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    flagGrad = !flagGrad;
                                  });
                                },
                                icon: const Icon(
                                  Icons.add_circle_outline_sharp,
                                  size: 20,
                                  color: Colors.indigo,
                                ))
                          ],
                        ),
                      ),
                    ),
                    flagGrad
                        ? getEducationalForm(
                            _controllerGraName,
                            _controllerGraTotal,
                            _controllerGraPer,
                            _controllerGraYear)
                        : Container(),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 28.0, top: 5, right: 10),
                        child: Row(
                          children: [
                            const Text(
                              'Add PostGraduation Details',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    flagPostGra = !flagPostGra;
                                  });
                                },
                                icon: const Icon(
                                  Icons.add_circle_outline_sharp,
                                  size: 20,
                                  color: Colors.indigo,
                                ))
                          ],
                        ),
                      ),
                    ),
                    flagPostGra
                        ? getEducationalForm(
                            _controllerPostGraName,
                            _controllerPostGraTotal,
                            _controllerPostGraPer,
                            _controllerPostYear)
                        : Container(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ExpansionTile(
                  initiallyExpanded: true,
                  collapsedIconColor: Colors.black,
                  collapsedTextColor: Colors.black,
                  collapsedBackgroundColor: Colors.orange,
                  iconColor: Colors.black,
                  title: const Text(
                    'Other Details',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: buildTextFormFieldMultiLine(
                          _controllerOther,
                          150,
                          5,
                          'e.g- height:156(c.m) , weight: 87(k.g)  Aadhaar No: 1100,1100,1100, Pan No: FLSPS0000L' ,
                          1000,
                          'Enter other details',
                          'details must be less then 1000 character long ',
                          20),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ExpansionTile(
                  initiallyExpanded: true,
                  collapsedIconColor: Colors.black,
                  collapsedTextColor: Colors.black,
                  collapsedBackgroundColor: Colors.orange,
                  iconColor: Colors.black,
                  title: const Text(
                    'Upload Documents',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 0.0, left: 8, bottom: 20),
                      child: SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width * .35,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Colors.indigo),
                                      borderRadius: BorderRadius.circular(5)),
                                  backgroundColor: Colors.white),
                              onPressed: () {
                                _handleURLButtonPress(
                                    context, ImageSourceType.gallery);
                              },
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.add,
                                    color: Colors.indigo,
                                    size: 18,
                                  ),
                                  Text(
                                    'Upload file',
                                    style: TextStyle(
                                        color: Colors.indigo, fontSize: 13),
                                  ),
                                ],
                              ))),
                    ),
                    // Padding(
                    //   padding:
                    //   const EdgeInsets.only(top: 0.0, left: 8, bottom: 20),
                    //   child: SizedBox(
                    //       height: 40,
                    //       width: MediaQuery.of(context).size.width * .35,
                    //       child: ElevatedButton(
                    //           style: ElevatedButton.styleFrom(
                    //               shape: RoundedRectangleBorder(
                    //                   side: const BorderSide(
                    //                       color: Colors.indigo),
                    //                   borderRadius: BorderRadius.circular(5)),
                    //               backgroundColor: Colors.white),
                    //           onPressed: () {
                    //             _handleURLButtonPress2(
                    //                 context, ImageSourceType.gallery);
                    //           },
                    //           child: Row(
                    //             children: const [
                    //               Icon(
                    //                 Icons.add,
                    //                 color: Colors.indigo,
                    //                 size: 18,
                    //               ),
                    //               Text(
                    //                 'Upload files2',
                    //                 style: TextStyle(
                    //                     color: Colors.indigo, fontSize: 13),
                    //               ),
                    //             ],
                    //           ))),
                    // ),
                    // Padding(
                    //   padding:
                    //   const EdgeInsets.only(top: 0.0, left: 8, bottom: 20),
                    //   child: SizedBox(
                    //       height: 40,
                    //       width: MediaQuery.of(context).size.width * .35,
                    //       child: ElevatedButton(
                    //           style: ElevatedButton.styleFrom(
                    //               shape: RoundedRectangleBorder(
                    //                   side: const BorderSide(
                    //                       color: Colors.indigo),
                    //                   borderRadius: BorderRadius.circular(5)),
                    //               backgroundColor: Colors.white),
                    //           onPressed: () {
                    //             _handleURLButtonPress3(
                    //                 context, ImageSourceType.gallery);
                    //           },
                    //           child: Row(
                    //             children: const [
                    //               Icon(
                    //                 Icons.add,
                    //                 color: Colors.indigo,
                    //                 size: 18,
                    //               ),
                    //               Text(
                    //                 'Upload files 3',
                    //                 style: TextStyle(
                    //                     color: Colors.indigo, fontSize: 13),
                    //               ),
                    //             ],
                    //           ))),
                    // ),
                    // Padding(
                    //   padding:
                    //   const EdgeInsets.only(top: 0.0, left: 8, bottom: 20),
                    //   child: SizedBox(
                    //       height: 40,
                    //       width: MediaQuery.of(context).size.width * .35,
                    //       child: ElevatedButton(
                    //           style: ElevatedButton.styleFrom(
                    //               shape: RoundedRectangleBorder(
                    //                   side: const BorderSide(
                    //                       color: Colors.indigo),
                    //                   borderRadius: BorderRadius.circular(5)),
                    //               backgroundColor: Colors.white),
                    //           onPressed: () {
                    //             _handleURLButtonPress4(
                    //                 context, ImageSourceType.gallery);
                    //           },
                    //           child: Row(
                    //             children: const [
                    //               Icon(
                    //                 Icons.add,
                    //                 color: Colors.indigo,
                    //                 size: 18,
                    //               ),
                    //               Text(
                    //                 'Upload files 4',
                    //                 style: TextStyle(
                    //                     color: Colors.indigo, fontSize: 13),
                    //               ),
                    //             ],
                    //           ))),
                    // ),
                    // Padding(
                    //   padding:
                    //   const EdgeInsets.only(top: 0.0, left: 8, bottom: 20),
                    //   child: SizedBox(
                    //       height: 40,
                    //       width: MediaQuery.of(context).size.width * .35,
                    //       child: ElevatedButton(
                    //           style: ElevatedButton.styleFrom(
                    //               shape: RoundedRectangleBorder(
                    //                   side: const BorderSide(
                    //                       color: Colors.indigo),
                    //                   borderRadius: BorderRadius.circular(5)),
                    //               backgroundColor: Colors.white),
                    //           onPressed: () {
                    //             _handleURLButtonPress5(
                    //                 context, ImageSourceType.gallery);
                    //           },
                    //           child: Row(
                    //             children: const [
                    //               Icon(
                    //                 Icons.add,
                    //                 color: Colors.indigo,
                    //                 size: 18,
                    //               ),
                    //               Text(
                    //                 'Upload files 5',
                    //                 style: TextStyle(
                    //                     color: Colors.indigo, fontSize: 13),
                    //               ),
                    //             ],
                    //           ))),
                    // ),
                    imageLoad
                        ? Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Text(
                              imageLoadMsg,
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          )
                        : Container(),
                    flagListImageFromMobile
                        ? SizedBox(
                            height: 100,
                            width: double.infinity,
                            child: ListView.builder(
                                itemCount: listImageFromMobile!.length,
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: SizedBox(
                                        height: 100,
                                        width: 70,
                                        child: Image.file(
                                            listImageFromMobile![index])),
                                  );
                                }),
                          )
                        : Container(),
                    flagImageList![0] == false
                        ? Container()
                        : Container(
                            margin: const EdgeInsets.only(left: 30, right: 30),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                const Text('Upload Image1: '),
                                Expanded(
                                  child: LinearPercentIndicator(
                                    //leaner progress bar
                                    animation: true,
                                    animationDuration: 1000,
                                    lineHeight: 15.0,
                                    percent: percent / 100,
                                    center: Text(
                                      percent.toString() + "%",
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    progressColor: Colors.blue[400],
                                    backgroundColor: Colors.grey[300],
                                  ),
                                ),
                              ],
                            ),
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    flagImageList![1] == false
                        ? Container()
                        : Container(
                            margin: const EdgeInsets.only(left: 30, right: 30),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                const Text('Upload Image 2: '),
                                Expanded(
                                  child: LinearPercentIndicator(
                                    //leaner progress bar
                                    animation: true,
                                    animationDuration: 1000,
                                    lineHeight: 15.0,
                                    percent: percent / 100,
                                    center: Text(
                                      percent.toString() + "%",
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    progressColor: Colors.blue[400],
                                    backgroundColor: Colors.grey[300],
                                  ),
                                ),
                              ],
                            ),
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    flagImageList![2] == false
                        ? Container()
                        : Container(
                            margin: const EdgeInsets.only(left: 30, right: 30),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                const Text('Upload Image 3: '),
                                Expanded(
                                  child: LinearPercentIndicator(
                                    //leaner progress bar
                                    animation: true,
                                    animationDuration: 1000,
                                    lineHeight: 15.0,
                                    percent: percent / 100,
                                    center: Text(
                                      percent.toString() + "%",
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    progressColor: Colors.blue[400],
                                    backgroundColor: Colors.grey[300],
                                  ),
                                ),
                              ],
                            ),
                          ),
                    flagImageList![3] == false
                        ? Container()
                        : Container(
                            margin: const EdgeInsets.only(left: 30, right: 30),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                const Text('Upload Image4: '),
                                Expanded(
                                  child: LinearPercentIndicator(
                                    //leaner progress bar
                                    animation: true,
                                    animationDuration: 1000,
                                    lineHeight: 15.0,
                                    percent: percent / 100,
                                    center: Text(
                                      percent.toString() + "%",
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    progressColor: Colors.blue[400],
                                    backgroundColor: Colors.grey[300],
                                  ),
                                ),
                              ],
                            ),
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    flagImageList![4] == false
                        ? Container()
                        : Container(
                            margin: const EdgeInsets.only(left: 30, right: 30),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                const Text('Upload Image 5: '),
                                Expanded(
                                  child: LinearPercentIndicator(
                                    //leaner progress bar
                                    animation: true,
                                    animationDuration: 1000,
                                    lineHeight: 15.0,
                                    percent: percent / 100,
                                    center: Text(
                                      percent.toString() + "%",
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    progressColor: Colors.blue[400],
                                    backgroundColor: Colors.grey[300],
                                  ),
                                ),
                              ],
                            ),
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ExpansionTile(
                  initiallyExpanded: true,
                  collapsedIconColor: Colors.black,
                  collapsedTextColor: Colors.black,
                  collapsedBackgroundColor: Colors.orange,
                  iconColor: Colors.black,
                  title: const Text(
                    'Declaration',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 18.0, top: 15, right: 10),
                      child: Column(
                        children: [
                          Text(
                            '${widget.data.declaration}',
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                checkBoxValue = !checkBoxValue;
                              });
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  value: checkBoxValue ? true : false,
                                  checkColor: Colors.black,
                                  activeColor: Colors.orange,
                                  side: const BorderSide(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                  onChanged: (bool? value) {},
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 1.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "I agree with above Declaration ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12),
                                      ),
                                      flagShowDeclaration
                                          ? const Icon(
                                              Icons.info_outline,
                                              color: Colors.redAccent,
                                              size: 18,
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                    width: 300,
                    child: ElevatedButton(
                        onPressed: () {
                          youCanApply
                              ? _applyForJob(context)
                              : showToast(msg: "sorry, applied date is over !");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              youCanApply ? Colors.indigo : Colors.grey,
                        ),
                        child: flagAddJob
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Apply'))),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFormFieldMultiLine(
      TextEditingController controllerL,
      double heightL,
      int maxLineL,
      hint,
      maxLine,
      String error1,
      String error2,
      int con1) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 0, left: 8.0, right: 20),
      child: SizedBox(
        height: 140,
        child: Theme(
          data: ThemeData(
              primaryColor: Colors.redAccent,
              primaryColorDark: Colors.red,
              primarySwatch: Colors.indigo),
          child: TextFormField(
            textInputAction: TextInputAction.next,
            maxLines: maxLineL,
            controller: controllerL,
            maxLength: maxLine,
            validator: (v) {},
            // validator: (value) {
            //   if (value!.isEmpty) {
            //     return error1;
            //   } else {}
            //   if (value!.length < con1) {
            //     return error2;
            //   } else {}
            //   return null;
            // },
            onChanged: (v) {
              setState(() {});
            },
            decoration: InputDecoration(
              hintText: hint,
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo)),
            ),
          ),
        ),
      ),
    );
  }

  buildHeading(String title, bool buildStarr) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 18.0, right: 8),
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextFormField(
      TextEditingController controller, TextInputType textInputType) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 18.0, right: 20),
      child: SizedBox(
        height: heightTF,
        child: Theme(
          data: ThemeData(
              primaryColor: Colors.redAccent,
              primaryColorDark: Colors.red,
              primarySwatch: Colors.indigo),
          child: TextFormField(
            textInputAction: TextInputAction.next,
            controller: controller,
            validator: (value) {
              if (value!.isEmpty) {
                return 'enter value';
              } else {}
              return null;
            },
            onChanged: (v) {},
            keyboardType: textInputType,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo)),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFormFieldTwo(
      maxLimit,
      maxLimitError,
      readOnly,
      controlller,
      errorMsg,
      labelText,
      validator,
      onChanged,
      icon,
      maxLines,
      textInputType) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.redAccent,
        primaryColorDark: Colors.red,
      ),
      child: SizedBox(
        height: 30,
        child: TextFormField(
          textInputAction: TextInputAction.next,
          maxLines: maxLines,
          readOnly: readOnly,
          controller: controlller,
          validator: validator,
          keyboardType: textInputType,
          onChanged: onChanged,
          decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal)),
              labelText: '    $labelText',
              labelStyle: const TextStyle(fontSize: 12),
              prefixText: ' ',
              suffixStyle: const TextStyle(color: Colors.green)),
        ),
      ),
    );
  }

  stateWidget() {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.redAccent,
        primaryColorDark: Colors.red,
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 8, bottom: 8, left: 18.0, right: 20),
        child: Container(
          margin: const EdgeInsets.all(1.0),
          padding: const EdgeInsets.only(left: 5.0),
          decoration: myBoxDecoration(),
          height: 35,
          //
          width: MediaQuery.of(context).size.width,
          //          <// --- BoxDecoration here
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: DropdownButton(
                // Initial Value
                menuMaxHeight: MediaQuery.of(context).size.height,
                value: stateInitial,
                dropdownColor: Colors.white,
                focusColor: Colors.blue,
                isExpanded: true,
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),
                // Array list of items
                items: stateList.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (state) {
                  setState(() {
                    stateInitial = state.toString();
                    _controllerState.text = state.toString();
                  });
                }),
          ),
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 1.0, color: Colors.black26),
      borderRadius: const BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
          ),
    );
  }

  static Future<dynamic> addJob(ModelJobsApplied? model) async {
    print('saboor1-------------');
    print('${model!.toJson()}');
    var APIURL = '${API_BASE_URL}job_apply_api.php';
    print('saboor2-------------');
    http.Response response = await http
        .post(Uri.parse(APIURL), body: model?.toJson())
        .then((value) => value)
        .catchError((error) => print("addJob Failed to addProfile: $error"));
    print('saboor3--------${response.body}-----');
    var data = jsonDecode(response.body);
    print('saboor4-------------');
    print("addProfile DATA: $data");
    return data;
  }

  getEducationalForm(
    TextEditingController controller1,
    TextEditingController controller2,
    TextEditingController controller3,
    TextEditingController controller4,
  ) {
    return SizedBox(
      width: 280,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 5, bottom: 10, top: 0),
              child: SizedBox(
                height: 35,
                width: 280,
                child: CustomFormField(
                    maxLines: 1,
                    maxLimit: 30,
                    maxLimitError: '30',
                    readOnly: false,
                    controlller: controller1,
                    errorMsg: 'Enter Institute Name',
                    labelText: 'Institute Name',
                    validator: (value) {
                      if (controller1 == "") {
                        return 'Enter Institute Name';
                      }
                    },
                    onChanged: (v) {},
                    icon: Icons.school_outlined,
                    textInputType: TextInputType.text),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 5, bottom: 0, top: 0),
                    child: SizedBox(
                      height: 35,
                      child: CustomFormField(
                          maxLines: 1,
                          maxLimit: 2,
                          maxLimitError: '2',
                          readOnly: false,
                          controlller: controller2,
                          errorMsg: 'Enter Total Marks',
                          labelText: 'Total',
                          validator: (value) {
                            if (controller2 == "") {
                              return 'Enter Total Marks';
                            }
                          },
                          onChanged: (v) {},
                          icon: Icons.numbers,
                          textInputType: TextInputType.number),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 5, bottom: 0, top: 0),
                    child: SizedBox(
                      height: 35,
                      child: CustomFormField(
                          maxLines: 1,
                          maxLimit: 2,
                          maxLimitError: '2',
                          readOnly: false,
                          controlller: controller3,
                          errorMsg: 'Enter Percentage',
                          labelText: 'Percent',
                          validator: (value) {
                            if (controller3 == "") {
                              return 'Enter Percentage';
                            }
                          },
                          onChanged: (v) {},
                          icon: Icons.percent,
                          textInputType: TextInputType.number),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 5, bottom: 0),
              child: SizedBox(
                height: 35,
                child: CustomDate(
                  controller: controller4,
                  initialDate: DateTime(2010),
                  firstDate: DateTime(1970),
                  lastDate: DateTime(2022),
                  validator: (value) {
                    if (controller4 == "") {
                      return 'Enter Year';
                    }
                  },
                  labelText: 'Completed Year',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _applyForJob(BuildContext context) async {
    setState(() {
      flagImageList = [false, false, false, false, false];
      uploadImagesPath=['','','','',''];
      flagAddJob = false;
      imageLength = 0;
    });
    if (checkBoxValue == false) {
      setState(() {
        flagShowDeclaration = true;
      });
      snackBar(
          context: context,
          data: 'Please check declaration !',
          color: Colors.redAccent);
    } else {
      setState(() {
        flagShowDeclaration = false;
      });
      if (mounted) {
        setState(() {
          heightTF = 45;
        });
      }
      int imageIndex=0;
      if (_formKey.currentState!.validate()) {
        setState(() {
          flagAddJob = true;
        });
        if (pickedFile != null) {
          for (var image in pickedFile!) {
            Dio.FormData formData = Dio.FormData.fromMap({
              "user_id": appUser.mobile,
              "image": await Dio.MultipartFile.fromFile(image.path,
                  filename: image.path.split('/').last)
            });
            String result = await DioServices.uploadImage(formData);
            print('-result--------------$result');
            if (result.contains('error')) {
              showToast(msg: result);
            } else {
              setState(() {
                uploadImagesPath![imageIndex]=result;
                flagImageList[imageLength] = true;
                imageLength = imageLength + 1;
                imageIndex++;
              });
            }
            setState(() {});
          }
        } else {
          showToast(msg: 'please try again no image selected');
        }
        var data = await addJob(ModelJobsApplied(
          jobId: widget.data.jobId,
          userId: appUser.mobile,
          name: _controllerName.text,
          mobile: _controllerMobile.text,
          alternateNumber: _controllerAltMobile.text,
          email: _controlleremail.text,
          dob: _controllerDOB.text,
          gender: gender,
          qualification: qualification,
          fathername: _controllerFatherName.text,
          mothername: _controllerMotherName.text,
          state: stateInitial,
          district: _controllerDistrict.text,
          city: _controllerCity.text,
          pincode: _controllerPin.text,
          degree1: 'highSchool',
          //////////////
          highSchoolName: _controllerHighSchName.text,
          highSchoolPercentage: _controllerHighSchPer.text,
          highSchoolTotalMarks: _controllerHighSchTotal.text,
          highSchoolCompleteYear: _controllerHighSchYear.text,
          degree2: 'intermediate',
          interSchoolName: _controllerInterName.text,
          interSchoolTotalMarks: _controllerInterTotal.text,
          interSchoolCompleteYear: _controllerInterYear.text,
          degree3: 'graduation',
          graduationName: _controllerGraName.text,
          graduationPercentage: _controllerGraPer.text,
          graduationTotalMarks: _controllerGraTotal.text,
          graduationCompleteYear: _controllerGraYear.text,
          degree4: 'postGraduation',
          postGraduationName: _controllerPostGraName.text,
          postGraduationPercentage: _controllerPostGraPer.text,
          postGraduationTotalMarks: _controllerPostGraTotal.text,
          postGraduationCompleteYear: _controllerPostYear.text,
          other: _controllerOther.text,
          image1: uploadImagesPath![0],
          image2: uploadImagesPath![1],
          image3: uploadImagesPath![2],
          image4: uploadImagesPath![3],
          image5: uploadImagesPath![4],
        ));
        if (data['status'] == true) {
          if (mounted) {
            setState(() {
              flagAddJob = false;
            });
          }
          snackBar(
              context: context, data: data['response'], color: Colors.green);
        } else {
          if (mounted) {
            setState(() {
              flagAddJob = false;
            });
          }
          snackBar(context: context, data: data['response'], color: Colors.red);
        }
      }
    }
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = ElevatedButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkWell(
            onTap: () async {
              Navigator.pop(context);
              _handleURLButtonPress(context, ImageSourceType.gallery);
            },
            child: const ListTile(
                title: Text("From Gallery"),
                leading: Icon(
                  Icons.image,
                  color: Colors.deepPurple,
                )),
          ),
          Container(
            width: 200,
            height: 1,
            color: Colors.black12,
          ),
          InkWell(
            onTap: () async {
              Navigator.pop(context);
              _handleURLButtonPress(context, ImageSourceType.camera);
            },
            child: const ListTile(
                title: Text(
                  "From Camera",
                  style: TextStyle(color: Colors.red),
                ),
                leading: Icon(
                  Icons.camera,
                  color: Colors.red,
                )),
          ),
        ],
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _handleURLButtonPress1(BuildContext context, var type) async {
    List<File>? _image;
    var imagePicker = ImagePicker();
    var source = type == ImageSourceType.camera
        ? ImageSource.camera
        : ImageSource.gallery;
    pickedFile![0] = (await imagePicker.pickImage(source: source).catchError((err) {
      Fluttertoast.showToast(msg: err.toString());
    }))!;
    if (pickedFile![0] != null) {
      if (pickedFile!.length > 5) {
        showToast(msg: 'image limit is 5');
      } else {
        setState(() {
          listImageFromMobile![0] = File(pickedFile![0].path);
          flagListImageFromMobile = true;
          imageLoad = false;
        });
      }
    }
  }
  void _handleURLButtonPress2(BuildContext context, var type) async {
    List<File>? _image;
    var imagePicker = ImagePicker();
    var source = type == ImageSourceType.camera
        ? ImageSource.camera
        : ImageSource.gallery;
    pickedFile![1] = (await imagePicker.pickImage(source: source).catchError((err) {
      Fluttertoast.showToast(msg: err.toString());
    }))!;
    if (pickedFile![1] != null) {
      if (pickedFile!.length > 5) {
        showToast(msg: 'image limit is 5');
      } else {
        setState(() {
          listImageFromMobile![1] = File(pickedFile![1].path);
          flagListImageFromMobile = true;
          imageLoad = false;
        });
      }
    }
  }
  void _handleURLButtonPress3(BuildContext context, var type) async {
    List<File>? _image;
    var imagePicker = ImagePicker();
    var source = type == ImageSourceType.camera
        ? ImageSource.camera
        : ImageSource.gallery;
    pickedFile![2] = (await imagePicker.pickImage(source: source).catchError((err) {
      Fluttertoast.showToast(msg: err.toString());
    }))!;
    if (pickedFile![2] != null) {
      if (pickedFile!.length > 5) {
        showToast(msg: 'image limit is 5');
      } else {
        setState(() {
          listImageFromMobile![2] = File(pickedFile![2].path);
          flagListImageFromMobile = true;
          imageLoad = false;
        });
      }
    }
  }
  void _handleURLButtonPress4(BuildContext context, var type) async {
    List<File>? _image;
    var imagePicker = ImagePicker();
    var source = type == ImageSourceType.camera
        ? ImageSource.camera
        : ImageSource.gallery;
    pickedFile![3] = (await imagePicker.pickImage(source: source).catchError((err) {
      Fluttertoast.showToast(msg: err.toString());
    }))!;
    if (pickedFile![3] != null) {
      if (pickedFile!.length > 5) {
        showToast(msg: 'image limit is 5');
      } else {
        setState(() {
          listImageFromMobile![3] = File(pickedFile![3].path);
          flagListImageFromMobile = true;
          imageLoad = false;
        });
      }
    }
  }
  void _handleURLButtonPress5(BuildContext context, var type) async {
    List<File>? _image;
    var imagePicker = ImagePicker();
    var source = type == ImageSourceType.camera
        ? ImageSource.camera
        : ImageSource.gallery;
    pickedFile![4] = (await imagePicker.pickImage(source: source).catchError((err) {
      Fluttertoast.showToast(msg: err.toString());
    }))!;
    if (pickedFile![4] != null) {
      if (pickedFile!.length > 5) {
        showToast(msg: 'image limit is 5');
      } else {
        setState(() {
          listImageFromMobile![4] = File(pickedFile![4].path);
          flagListImageFromMobile = true;
          imageLoad = false;
        });
      }
    }
  }


  void _handleURLButtonPress(BuildContext context, var type) async {
    List<File>? _image;
    var imagePicker = ImagePicker();
    var source = type == ImageSourceType.camera
        ? ImageSource.camera
        : ImageSource.gallery;
    pickedFile = await imagePicker.pickMultiImage().catchError((err) {
      Fluttertoast.showToast(msg: err.toString());
    });
    if (pickedFile != null) {
      if (pickedFile!.length > 5) {
        showToast(msg: 'image limit is 5');
      } else {
        setState(() {
          listImageFromMobile = pickedFile!.map((e) => File(e.path)).toList();
          flagListImageFromMobile = true;
          imageLoad = false;
        });
      }
    }
  }

  snackBar(
      {required BuildContext context,
      required String data,
      required Color color}) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Padding(
              padding: const EdgeInsets.only(left: 10.0), child: Text(data)),
          backgroundColor: color,
          behavior: SnackBarBehavior.fixed));
  }
}
