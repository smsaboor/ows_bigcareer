import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ows_bigcareer/view/freelancer/projects/project_service.dart';
import 'package:ows_bigcareer/view/gov_job/upload_documents.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:provider/provider.dart';
import 'package:ows_bigcareer/view_model/sharedpreferences_view_model.dart';
import 'package:ows_bigcareer/view/freelancer/freelancer/widgets/add_freelancer/banner.dart';
import 'package:ows_bigcareer/view/freelancer/freelancer/widgets/add_freelancer/show_text.dart';
import 'package:ows_bigcareer/view/freelancer/freelancer/widgets/add_freelancer/text_form_field.dart';
import 'package:ows_bigcareer/view/app_widgets/drop_down_widget.dart';
import 'package:flutter/cupertino.dart';

class AddFreelancer extends StatefulWidget {
  const AddFreelancer({Key? key, required this.userMobile}) : super(key: key);
  final userMobile;

  @override
  State<AddFreelancer> createState() => _AddFreelancerState();
}

class _AddFreelancerState extends State<AddFreelancer> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerDesignation = TextEditingController();
  TextEditingController controllerExperience = TextEditingController();
  TextEditingController controllerSkills = TextEditingController();
  TextEditingController controllerCharges = TextEditingController();
  TextEditingController controllerImage = TextEditingController();
  TextEditingController controllerCurrency = TextEditingController();
  TextEditingController controllerCountry = TextEditingController();
  TextEditingController controllerPaymentMode = TextEditingController();
  File? _image;
  String pageTitle = 'Add Your Freelancer Details';
  String imageButtonTitle = 'Upload Profile Photo';
  bool flagUplaodImage = false;
  List<File>? listImageFromMobile;
  bool flagListImageFromMobile = false;
  bool imageLoad = false;
  bool savingData = false;
  String imageLoadMsg = 'Please load minimum 1 image';
  List<String>? uploadImagesPath = [];
  XFile? pickedFile;
  bool skillsErrorFlag = false;
  String skillsError = 'please add minimum 1 skill';
  var sharedPreferencesVM;
  var snapshotSkills;
  List<String> searchList = [];
  List<String> skillsList = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? paymentMode = 'Hourly';
  var paymentModeList = ['Hourly', 'Monthly'];

  String? currency = 'INR';
  var currencyList = ['INR', 'Dollar', 'Dinar', 'Riyal'];
  bool flagUserFound = false;
  bool flagUserFoundLoading = false;
  bool flagOnOffFreelancer = false;

  Future<List<String>> getSearchList() async {
    searchList = await sharedPreferencesVM.getSkillsSearches();
    await Future.delayed(const Duration(seconds: 1));
    return searchList.toList();
  }

  Future<List<String>> getSkillsList() async {
    return skillsList.toList();
  }

  Future checkUserExist() async {
    setState(() {
      flagUserFoundLoading = true;
    });
    Dio.FormData formData = Dio.FormData.fromMap({
      "user_id": widget.userMobile,
    });
    var result = await DioServices.postDataFreelancer(
        'search_user_freelancer_api.php', formData);
    print('----result-----------${result}-');
    setState(() {});
    if (result["response"] == "0") {
      showToast(msg: 'no freelancer found');
      setState(() {
        flagUserFoundLoading = false;
      });
    } else {
      setState(() {
        flagUserFound = true;
        flagUserFoundLoading = false;
      });
      setState(() {
        flagUserFound = true;
        pageTitle = 'Edit Your Freelancer Details';
        imageButtonTitle = 'Change Profile Photo';
        controllerName.text = result["name"];
        controllerDesignation.text = result["title"];
        controllerExperience.text = result["about"];
        controllerCharges.text = result["amount"];
        controllerCurrency.text = result["currency"];
        currency = result["currency"];
        controllerPaymentMode.text = result["paymentMode"];
        paymentMode = result["paymentMode"];
        // controllerSkills.text=result["skills"];
        flagOnOffFreelancer = result["status"] == "0" ? false : true;
        skillsList = result["skills"].split(',');
        controllerCountry.text = result["country"];
        controllerImage.text = result["image"];
      });
      setState(() {});
      showToast(msg: 'freelancer found');
    }
  }

  @override
  void initState() {
    sharedPreferencesVM =
        Provider.of<SharedPreferencesVM>(context, listen: false);
    checkUserExist();
    getSearchList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          'I am a Freelancer',
          style: TextStyle(color: Colors.indigo),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: flagUserFoundLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BannerAddFreelancer(title: pageTitle),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8, top: 0, bottom: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5,),
                            const ShowText(title: 'Name '),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: FreelancerTextFromField(
                                  controllerL: controllerName,
                                  heightL: 50.0,
                                  maxLineL: 1,
                                  hint: 'e.g. Satin kumar',
                                  maxLine: 50,
                                  error1: 'Enter Name',
                                  error2: 'name must be 4 character long ',
                                  con1: 4),
                            ),
                            const ShowText(title: 'Designation '),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: FreelancerTextFromField(
                                  controllerL: controllerDesignation,
                                  heightL: 50.0,
                                  maxLineL: 1,
                                  hint: 'e.g. Java deveoper',
                                  maxLine: 50,
                                  error1: 'Enter designation',
                                  error2:
                                      'designation must be 8 character long ',
                                  con1: 8),
                            ),
                            const ShowText(title: 'Experience '),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: FreelancerTextFromField(
                                  controllerL: controllerExperience,
                                  heightL: 110.0,
                                  maxLineL: 4,
                                  hint:
                                      'eg: strong experience in software architect & graphic design.',
                                  maxLine: 200,
                                  error1: 'Enter experience',
                                  error2:
                                      'experience must be 50 character long ',
                                  con1: 50),
                            ),
                            const ShowText(title: 'Skills '),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 18),
                              child: buildTextFormField2(controllerSkills, 40,
                                  1, 'e.g. php, html, css, java', 100),
                            ),
                            skillsErrorFlag
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, top: 0),
                                    child: Text(
                                      skillsError,
                                      style: const TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    ),
                                  )
                                : Container(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8, top: 8),
                              child: SizedBox(
                                height: 70,
                                child: FutureBuilder<dynamic>(
                                    future: getSkillsList(),
                                    builder: (context, snapshot) {
                                      snapshotSkills = snapshot;
                                      if (snapshot.hasData &&
                                          snapshot.connectionState ==
                                              ConnectionState.done) {
                                        return GridView.builder(
                                          itemCount: snapshot.data.length,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  mainAxisSpacing: 10.0,
                                                  crossAxisSpacing: 1.0,
                                                  childAspectRatio: 4.0,
                                                  crossAxisCount: 3),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Row(
                                              children: [
                                                Container(
                                                  height: 30,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.indigo,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .28,
                                                  child: Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 3.0,
                                                              bottom: 3,
                                                              left: 8),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            '${(snapshot.data?[index].toString().length ?? 0) > 13 ? '${snapshot.data?[index].toString().substring(0, 10).replaceAll('[', '').replaceAll(']', '')}...' : snapshot.data?[index].toString().replaceAll('[', '').replaceAll(']', '') ?? ''}',
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                          const Spacer(),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 6.0),
                                                            child:
                                                                GestureDetector(
                                                                    onTap:
                                                                        () async {
                                                                      await sharedPreferencesVM
                                                                          .removeSkillsSearchesValue(
                                                                              snapshot.data?[index]);
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    child: const FaIcon(
                                                                        FontAwesomeIcons
                                                                            .xmark,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            16)),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                    }),
                              ),
                            ),
                            const ShowText(title: 'Charges '),
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 2, right: 8.0, left: 8, bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .3,
                                      child: FreelancerTextFromField(
                                          controllerL: controllerCharges,
                                          heightL: 40.0,
                                          maxLineL: 1,
                                          hint: 'eg:500',
                                          maxLine: null,
                                          error1: 'Enter amount',
                                          error2:
                                              'amount must be 2 character long ',
                                          con1: 2),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .3,
                                      child: BigCareerDropDown(
                                          value: currency,
                                          valueList: currencyList,
                                          onChange: (v) {
                                            setState(() {
                                              currency = v;
                                            });
                                          }),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .3,
                                      child: BigCareerDropDown(
                                          value: paymentMode,
                                          valueList: paymentModeList,
                                          onChange: (v) {
                                            setState(() {
                                              paymentMode = v;
                                            });
                                          }),
                                    ),
                                  ],
                                )),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top:5.0, left: 8, bottom: 15),
                              child: Row(
                                children: [
                                  SizedBox(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width *
                                          .5,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: Colors.indigo),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              backgroundColor: Colors.white),
                                          onPressed: () {
                                            showAlertDialog(context);
                                          },
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.add,
                                                color: Colors.indigo,
                                                size: 18,
                                              ),
                                              Text(
                                                imageButtonTitle,
                                                style: const TextStyle(
                                                    color: Colors.indigo,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          ))),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  flagUplaodImage
                                      ? SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .3,
                                          height: 50,
                                          child: const Center(
                                              child: SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child:
                                                      CircularProgressIndicator())))
                                      : SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .3,
                                          height: 50,
                                          child: Image.network(
                                              controllerImage.text)),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                children: [
                                  Text(
                                    flagOnOffFreelancer?'Hide Profile  ':'Show Profile  ',
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                    child: CupertinoSwitch(
                                      value: flagOnOffFreelancer,
                                      trackColor: Colors.red,
                                      activeColor: Colors.green,
                                      onChanged: (value) {
                                        setState(() {
                                          flagOnOffFreelancer =
                                              !flagOnOffFreelancer;
                                        });
                                      },
                                    ),
                                  ),
                                  // savingData
                                  //     ? const SizedBox(
                                  //         width: 40,
                                  //         child: Center(
                                  //           child: LinearProgressIndicator(),
                                  //         ))
                                  //     : const Text('')
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: SizedBox(
                                  height: 45,
                                  width: MediaQuery.of(context).size.width * .8,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          backgroundColor: Colors.indigo),
                                      onPressed: () {
                                        flagUserFound
                                            ? updateForm()
                                            : saveForm();
                                      },
                                      child: savingData
                                          ? const SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          : flagUserFound
                                              ? const Center(
                                                  child: Text(
                                                    'Update',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 21),
                                                  ),
                                                )
                                              : const Center(
                                                  child: Text(
                                                    'Save',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 21),
                                                  ),
                                                ))),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  saveForm() async {
    if (formKey.currentState!.validate()) {
      try {
        if (_image != null) {
          setState(() {
            savingData = true;
          });
          Dio.FormData formData = Dio.FormData.fromMap({
            "name": controllerName.text,
            "title": controllerDesignation.text,
            "about": controllerExperience.text,
            "skills": skillsList.toString().replaceAll(' ', '').replaceAll('[', '').replaceAll(']', ''),
            "paymentMode": paymentMode,
            "currency": currency,
            "amount": controllerCharges.text,
            "country": controllerCountry.text,
            "user_id": widget.userMobile,
            "image": controllerImage.text
          });
          var result = await DioServices.postDataFreelancer2(
              'add_freelancer_api.php', formData);
          if (result["status"] == "1") {
            setState(() {
              savingData = false;
            });
            showToast(msg: result["message"]);
            Navigator.pop(context);
          } else {
            setState(() {
              savingData = false;
            });
            showToast(msg: result["message"]);
          }
        } else {
          showToast(msg: 'select your image');
        }
      } catch (e) {
        showToast(msg: 'sorry data not saved');
        setState(() {
          savingData = false;
        });
      }
    }
  }

  updateForm() async {
    if (formKey.currentState!.validate()) {
      try {
        setState(() {
          savingData = true;
        });
        Dio.FormData formData = Dio.FormData.fromMap({
          "name": controllerName.text,
          "title": controllerDesignation.text,
          "about": controllerExperience.text,
          "skills": skillsList.toString().replaceAll(' ', '').replaceAll('[', '').replaceAll(']', ''),
          "paymentMode": paymentMode,
          "currency": currency,
          "amount": controllerCharges.text,
          "country": controllerCountry.text,
          "id": widget.userMobile,
          "status": flagOnOffFreelancer?"1":"0",
          "image": controllerImage.text
        });
        var result = await DioServices.postDataFreelancer2(
            'edit_freelancer_api.php', formData);
        if (result["status"] == "1") {
          setState(() {
            savingData = false;
          });
          showToast(msg: 'data updated successfully!');
          Navigator.pop(context);
        } else {
          setState(() {
            savingData = false;
          });
          showToast(msg: 'sorry data not updated!');
        }
      } catch (e) {
        showToast(msg: 'sorry data not saved');
        setState(() {
          savingData = false;
        });
      }
    }
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = ElevatedButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _handleURLButtonPress(BuildContext context, var type) async {
    var imagePicker = ImagePicker();
    var source = type == ImageSourceType.camera
        ? ImageSource.camera
        : ImageSource.gallery;
    pickedFile = await imagePicker.pickImage(
        source: source,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    if (mounted) {
      setState(() {
        _image = File(pickedFile!.path);
        flagUplaodImage = true;
      });
      if (_image != null) {
        Dio.FormData formData = Dio.FormData.fromMap({
          "user_id": widget.userMobile,
          "image": await Dio.MultipartFile.fromFile(_image!.path,
              filename: _image!.path.split('/').last)
        });
        String result = await DioServices.uploadImage(formData);
        print('-result--------------$result');
        if (result.contains('error')) {
          setState(() {
            flagUplaodImage = false;
          });
          showToast(msg: result);
        } else {
          setState(() {
            controllerImage.text = result;
            flagUplaodImage = false;
          });
        }
      } else {
        setState(() {
          flagUplaodImage = false;
        });
        showToast(msg: 'sorry image not selected try again');
      }
    }
  }

  Widget buildTextFormField2(TextEditingController controllerL, double heightL,
      int maxLineL, hint, maxLine) {
    return SizedBox(
      height: heightL,
      child: TextFormField(
        textInputAction: TextInputAction.next,
        controller: controllerL,
        validator: (value) {},
        onFieldSubmitted: (v) async {
          if (v.isEmpty) {
          } else {
            // await sharedPreferencesVM.setSkillsSearches(v);
            skillsErrorFlag = false;
            setState(() {
              if (skillsList.contains(controllerSkills.text)) {
              } else {
                if (skillsList.length > 5) {
                  showToast(msg: 'sorry skills limit is 6');
                } else {
                  skillsList.add(controllerSkills.text);
                }
              }
            });
            controllerSkills.clear();
          }
        },
        onChanged: (v) {},
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          suffixIcon: IconButton(
              onPressed: () async {
                if (controllerSkills.text.isEmpty) {
                } else {
                  // await sharedPreferencesVM
                  //     .setSkillsSearches(controllerSkills.text);
                  skillsErrorFlag = false;
                  setState(() {
                    if (skillsList.contains(controllerSkills.text)) {
                    } else {
                      if (skillsList.length > 5) {
                        showToast(msg: 'sorry skills limit is 6');
                      } else {
                        skillsList.add(controllerSkills.text);
                      }
                    }
                  });
                  controllerSkills.clear();
                }
              },
              icon: const Icon(Icons.add)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.indigo)),
        ),
      ),
    );
  }
}
