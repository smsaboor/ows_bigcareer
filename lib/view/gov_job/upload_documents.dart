import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_package1/CustomFormField.dart';


enum ImageSourceType { gallery, camera }

class UploadDocument extends StatefulWidget {
  const UploadDocument({Key? key}) : super(key: key);

  @override
  State<UploadDocument> createState() => _UploadDocumentState();
}

class _UploadDocumentState extends State<UploadDocument> {
  TextEditingController _controllerProductName = TextEditingController();
  TextEditingController _controllerProductDescription = TextEditingController();
  double textBoxHeight = 55;
  bool isLoading = false;
  String id = '';
  String nickname = '';
  String aboutMe = '';
  String photoUrl = '';
  File? avatarImageFile;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var imagePicker;
  File? _image;
  late String currentUserId;
  late String currentUserName;
  late String currentUserPhtoUrl;

  @override
  void initState() {
    super.initState();
    imagePicker = new ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Document'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
              ),
              SizedBox(
                height: textBoxHeight,
                child: CustomFormField(
                    controlller: _controllerProductName,
                    errorMsg: 'Enter Document Name',
                    labelText: 'Document Name',
                    readOnly: false,
                    icon: Icons.home_work_outlined,
                    maxLimit: 30,
                    maxLimitError: '30',
                    textInputType: TextInputType.text),
              ),
              const SizedBox(
                height: 15,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0, bottom: 0),
                  child: Text('Upload Document Image'),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              avatarImageFile == null
                  ? Container()
                  : GestureDetector(
                onTap: () {
                  showAlertDialog(context);
                },
                child: Image.file(
                  avatarImageFile!,
                  height: 80,
                  width: 200,
                ),
              ),
              avatarImageFile == null
                  ? Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 28),
                child: GestureDetector(
                  onTap: () {
                    showAlertDialog(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 80,
                    child: Center(
                      child: Image.asset('assets/img_4.png'),
                    ),
                  ),
                ),
              )
                  : Container(),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 90,
              ),
              SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width * .8,
                child: ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide(color: Colors.red)))),
                    onPressed: () {
                      validate();
                    },
                    child: isLoading?const Center(child: CircularProgressIndicator(),):Text("Submit".toUpperCase(),
                        style: const TextStyle(fontSize: 18))),
              )
            ],
          ),
        ),
      ),
    );
  }

  validate() {
    bool isValidate = false;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    if (formKey.currentState!.validate()) {
      if (avatarImageFile == null) {
      } else {
        saveProduct();
      }
    } else {}
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

  void _handleURLButtonPress(BuildContext context, var type) async {
    var source = type == ImageSourceType.camera
        ? ImageSource.camera
        : ImageSource.gallery;
    PickedFile? pickedFile =
    await imagePicker.getImage(source: source).catchError((err) {
      Fluttertoast.showToast(msg: err.toString());
    });
    File? image;
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    if (image != null) {
      setState(() {
        avatarImageFile = image;
      });
    }
  }

  Future saveProduct() async {
  }
}
