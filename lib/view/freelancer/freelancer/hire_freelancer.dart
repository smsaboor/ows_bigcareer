import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ows_bigcareer/view/chat/chat_page.dart';
import 'package:ows_bigcareer/view/chat/models/models.dart';
import 'package:ows_bigcareer/view/gov_job/upload_documents.dart';
import 'package:ows_bigcareer/view_model/chat_view_model.dart';
import 'package:provider/provider.dart';

class HireFreelancer extends StatefulWidget {
  const HireFreelancer({Key? key, required this.freelancer,required this.userMobile}) : super(key: key);
  final freelancer, userMobile;
  @override
  State<HireFreelancer> createState() => _HireFreelancerState();
}

class _HireFreelancerState extends State<HireFreelancer> {
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerDetails = TextEditingController();
  TextEditingController controllerAmount = TextEditingController();
  List<File>? avatarImageFile;
  bool avatarImageFileFlag = false;
  late ChatViewModel homeProvider;
  bool imageLoad = false;
  String imageLoadMsg = 'Please load minimum 1 image';
  String? currency = 'INR';
  var currencyList = ['INR', 'USD', 'NZD', 'AUD', 'EUR', 'GBP', 'CAD'];

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? paymentMode='fixed'; //

  @override
  void initState() {
    // TODO: implement initState
    homeProvider = context.read<ChatViewModel>();
    controllerDetails.text =
        'Hi, ${widget.freelancer.name}, I noticed your profile and would like to offer you my project. We can discuss any details over chat';
    controllerAmount.text = widget.freelancer.amount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          '',
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
                Stack(
                  children: [
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: AssetImage("assets/img_3.png"))),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                      ),
                    ),
                    Positioned(
                      top: 15,
                      left: 20,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Contact ${widget.freelancer.name}, about yor project',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                          'Project Name',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                      ),
                      buildTextFormField(
                          controllerTitle,
                          65,
                          1,
                          'Project for ${widget.freelancer.name}',
                          100,
                          'Enter Project Name',
                          'project name must be 4 character long ',
                          4),
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0, left: 8),
                        child: Text(
                          'Send a private message',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                      ),
                      buildTextFormField(
                          controllerDetails,
                          150,
                          7,
                          '',
                          2000,
                          'Enter Project description',
                          'project description must be 20 character long ',
                          20),
                      const Padding(
                        padding: EdgeInsets.only(top: 0.0, left: 8),
                        child: Text(
                          'Hire for',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                            child: RadioListTile(
                              title: const Text(
                                "Fixed Price",
                                style: TextStyle(fontSize: 12),
                              ),
                              value: "fixed",
                              groupValue: paymentMode,
                              onChanged: (value) {
                                setState(() {
                                  paymentMode = value.toString();
                                });
                              },
                            ),
                          ),
                          RadioListTile(
                            title: const Text(
                              "Hourly Rate",
                              style: TextStyle(fontSize: 12),
                            ),
                            value: "hourly",
                            groupValue: paymentMode,
                            onChanged: (value) {
                              setState(() {
                                paymentMode = value.toString();
                              });
                            },
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 0.0, left: 8, bottom: 5),
                        child: Text(
                          'Budget',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: SizedBox(
                              height: 35,
                              width: MediaQuery.of(context).size.width * .5,
                              child: Theme(
                                data: ThemeData(
                                    primaryColor: Colors.redAccent,
                                    primaryColorDark: Colors.red,
                                    primarySwatch: Colors.indigo),
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 12),
                                  textInputAction: TextInputAction.next,
                                  controller: controllerAmount,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Amount';
                                    } else {}
                                    return null;
                                  },
                                  onChanged: (v) {
                                    setState(() {});
                                  },
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    hintText: '',
                                    prefix: Text(
                                      '    \$   ',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.indigo)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: 40,
                            width: MediaQuery.of(context).size.width * .3,
                            child: currencyWidget(),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0, left: 8, bottom: 5),
                        child: Text(
                          'By clicking Hire ${widget.freelancer.name}., you have read and agreed to our Terms & Conditions and Privacy Policy',
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .04,
                      ),
                      Center(
                        child: SizedBox(
                            height: 35,
                            width: MediaQuery.of(context).size.width * .9,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(5)),
                                    backgroundColor: Colors.indigo),
                                onPressed: () async{
                                  print('---widget.userMobile${widget.userMobile}---------------freelancers.userId${widget.freelancer.f_id}');
                                  if(widget.userMobile==widget.freelancer.f_id){
                                    showToast(msg: "You can't bed on your own project" );
                                  }
                                  else{
                                   verifyFrom();
                                  }
                                },
                                child: Center(
                                  child: Text(
                                    'Hire ${widget.freelancer.name}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 12),
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

  verifyFrom() async{
    if (formKey.currentState!.validate()) {
      UserChat? user= await homeProvider.getUserDetails(widget.freelancer.f_id);
      // ignore: use_build_context_synchronously
      navigateTo(
          context,
          ChatPage(
            message:
            'Hi, ${widget.freelancer.name}, '
                'My project: ${controllerTitle.text} '
                'details:${controllerDetails.text} My Budget is ${controllerAmount.text}/$currency $paymentMode',
            userMobile: widget.userMobile,
            isImageSend: false,
            isProjectChat: false,
            imageUrl: '',
            isFirstTime:true,
            arguments: ChatPageArguments(
              peerId: user!.mobile,
              peerAvatar: user!.email,
              peerNickname: user!.email,
            ),
          ));
    }
  }

  currencyWidget() {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.redAccent,
        primaryColorDark: Colors.red,
      ),
      child: Container(
        margin: const EdgeInsets.all(1.0),
        padding: const EdgeInsets.only(left: 5.0),
        decoration: myBoxDecoration(),
        height: 40,
        //
        width: MediaQuery.of(context).size.width,
        //          <// --- BoxDecoration here
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: DropdownButton(
              // Initial Value
              menuMaxHeight: MediaQuery.of(context).size.height,
              value: currency,
              dropdownColor: Colors.white,
              focusColor: Colors.blue,
              isExpanded: true,
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),
              // Array list of items
              items: currencyList.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (curr) {
                setState(() {
                  currency = curr.toString();
                });
              }),
        ),
      ),
    );
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
            style: TextStyle(fontSize: 12),
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
    var imagePicker = ImagePicker();
    var source = type == ImageSourceType.camera
        ? ImageSource.camera
        : ImageSource.gallery;
    List<XFile>? pickedFile =
        await imagePicker.pickMultiImage().catchError((err) {
      Fluttertoast.showToast(msg: err.toString());
    });
    List<XFile>? image;
    if (pickedFile != null) {
      image = pickedFile;
    }
    if (image != null) {
      setState(() {
        avatarImageFile = pickedFile!.map((e) => File(e.path)).toList();
        print('--------${avatarImageFile!.length}');
        avatarImageFileFlag = true;
        imageLoad = false;
        // avatarImageFile = File(pickedFile![0].path);
      });
    }
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 1.0, color: Colors.black26),
      borderRadius: const BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
          ),
    );
  }
}
