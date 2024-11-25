import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ows_bigcareer/view/gov_job/upload_documents.dart';
import 'skills_need.dart';

class AddNewProject extends StatefulWidget {
  const AddNewProject({Key? key, required this.userMobile}) : super(key: key);
  final userMobile;

  @override
  State<AddNewProject> createState() => _AddNewProjectState();
}

class _AddNewProjectState extends State<AddNewProject> {
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerDetails = TextEditingController();
  List<File>? listImageFromMobile;
  bool flagListImageFromMobile = false;
  bool imageLoad = false;
  String imageLoadMsg = 'Please load minimum 1 image';
  List<String>? uploadImagesPath = [];
  List<XFile>? pickedFile;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();


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
          'Add New Project',
          style: TextStyle(color: Colors.indigo),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  color: Colors.black,
                  child: Stack(
                    children: [
                      Container(
                        height: 150,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: AssetImage("assets/img_3.png"))),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                        ),
                      ),
                      Positioned(
                        top: 25,
                        left: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Tell us what you need done',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 50,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * .9,
                              child: const Text(
                                'Pay the freelancer only when you are 100% satisfied with their work',
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 18.0, left: 8),
                        child: Text(
                          'Choose a name about your project',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: Colors.black),
                        ),
                      ),
                      buildTextFormField(
                          controllerTitle,
                          65,
                          1,
                          'e.g. Build me a website',
                          100,
                          'Enter Project Name',
                          'project name must be 4 character long ',
                          4),
                      const Padding(
                        padding: EdgeInsets.only(top: 38.0, left: 8),
                        child: Text(
                          'Tell us more about your project',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: Colors.black),
                        ),
                      ),
                      buildTextFormField(
                          controllerDetails,
                          150,
                          3,
                          'Describe your project here..',
                          2000,
                          'Enter Project description',
                          'project description must be 20 character long ',
                          20),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 0.0, left: 8, bottom: 20),
                        child: SizedBox(
                            height: 40,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * .35,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.indigo),
                                        borderRadius: BorderRadius.circular(5)),
                                    backgroundColor: Colors.white),
                                onPressed: () {
                                  // showAlertDialog(context);
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
                                      'Upload files',
                                      style: TextStyle(
                                          color: Colors.indigo, fontSize: 13),
                                    ),
                                  ],
                                ))),
                      ),
                      imageLoad
                          ? Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(
                          imageLoadMsg,
                          style:
                          TextStyle(color: Colors.red, fontSize: 12),
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
                                padding:
                                const EdgeInsets.only(right: 12.0),
                                child: SizedBox(
                                    height: 100,
                                    width: 70,
                                    child: Image.file(
                                        listImageFromMobile![index])),
                              );
                            }),
                      )
                          : Container(),

                      SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * .04,
                      ),
                      Center(
                        child: SizedBox(
                            height: 45,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * .8,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(5)),
                                    backgroundColor: Colors.pink),
                                onPressed: () {
                                  verifyFrom();
                                },
                                child: const Center(
                                  child: Text(
                                    'Next',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 21),
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

  verifyFrom() {
    if (formKey.currentState!.validate()) {
      if (flagListImageFromMobile == false) {
        setState(() {
          imageLoad = true;
        });
      } else {
        setState(() {
          imageLoad = false;
        });
        navigateTo(
            context,
            SkillsNeed(
                userMobile: widget.userMobile,
                title: controllerTitle.text,
                details: controllerDetails.text,
                imageList: listImageFromMobile,
                fileList: pickedFile
            ));
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

  Widget buildTextFormField(TextEditingController controllerL, double heightL,
      int maxLineL, hint, maxLine, String error1, String error2, int con1) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 0, left: 8.0, right: 20),
      child: SizedBox(
        height: heightL,
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
            validator: (value) {
              if (value!.isEmpty) {
                return error1;
              } else {}
              if (value!.length < con1) {
                return error2;
              } else {}
              return null;
            },
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
      if (pickedFile!.length > 3) {
        showToast(msg: 'image limit is 3');
      } else {
        setState(() {
          listImageFromMobile = pickedFile!.map((e) => File(e.path)).toList();
          flagListImageFromMobile = true;
          imageLoad = false;
        });
      }
    }
  }
}
