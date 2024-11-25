import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_package1/components.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ows_bigcareer/model/cubits/auth_cubit/auth_cubit.dart';
import 'package:ows_bigcareer/model/firebase/firebase_service.dart';
import 'package:ows_bigcareer/model/models/model_app_user.dart';
import 'package:ows_bigcareer/view/auth/forget_password.dart';
import 'package:ows_bigcareer/view/auth/login.dart';
import 'package:ows_bigcareer/view/app_widgets/avtar_image_network.dart';
import 'package:ows_bigcareer/view/bottom_tabs/notification_button.dart';
import 'package:ows_bigcareer/view/drawer/write_to_us.dart';
import 'package:ows_bigcareer/view/freelancer/projects/project_service.dart';
import 'package:ows_bigcareer/view/gov_job/upload_documents.dart';
import 'package:ows_bigcareer/view_model/sharedpreferences_view_model.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:dio/dio.dart' as Dio;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_package1/loading/loading1.dart';
import 'help_and_support.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key, required this.userMobile}) : super(key: key);
  final userMobile;
  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool flagUserData = true;
  File? _image;
  XFile? pickedFile;
  late AppUser appUser;
  bool flagUplaodImage = false;
  String? imageUrl;

  getUserDetails() async {
    var sharedPreferencesVM =
        Provider.of<SharedPreferencesVM>(context, listen: false);
    appUser = await sharedPreferencesVM.getUserDetails();
    imageUrl = appUser.image;
    setState(() {
      flagUserData = false;
    });
  }

  updateUserDetails() async {
    setState(() {
      flagUserData = true;
    });
    var sharedPreferencesVM =
        Provider.of<SharedPreferencesVM>(context, listen: false);
    appUser = await sharedPreferencesVM.getUserDetails();
    await sharedPreferencesVM.setUserDetails(AppUser(
        name: appUser.name,
        email: appUser.email,
        mobile: appUser.mobile,
        uid: appUser.uid,
        pwd: appUser.pwd,
        image: imageUrl!));
    appUser = await sharedPreferencesVM.getUserDetails();
    setState(() {
      flagUserData = false;
    });
  }

  FirebaseService firebaseServices = FirebaseService();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    getUserDetails();
    super.initState();
  }

  Future<QuerySnapshot> getNotifications() async {
    var notifications = FirebaseFirestore.instance
        .collection('notifications')
        .get();
    print('notifivctions: ${notifications}');
    return notifications;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/img_3.png"))),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                    ),
                  ),
                ),
                flagUserData
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Positioned(
                        top: 10,
                        left: 20,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: SizedBox(
                              height: 70,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 0.0),
                                        child: AvatarImageNetwork(
                                          imageUrl!,
                                          radius: 80,
                                          height: 70,
                                          width: 70,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 18.0, top: 5),
                                              child: Text(
                                                appUser.name,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: Image.asset(
                                                'assets/verified.jpg'),
                                          )
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 18.0, top: 5),
                                          child: Text(
                                            appUser.email,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 18.0, top: 5),
                                          child: Text(
                                            appUser.mobile,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                        )),
                Positioned(
                  top: 70,
                  left: 45,
                  child: GestureDetector(
                    onTap: () {
                      showAlertDialog(context);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            flagUserData
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 20),
                    child: Column(
                      children: [
                        ProfileTitle(
                            icon: Icons.notification_add_outlined,
                            flagIcon: true,
                            onTap: () {
                              // showCupertinoModalBottomSheet(
                              //   context: context,
                              //   builder: (context) {
                              //     return CupertinoPageScaffold(
                              //       navigationBar: CupertinoNavigationBar(
                              //         transitionBetweenRoutes: false,
                              //         leading: GestureDetector(
                              //             onTap: () {
                              //               Navigator.pop(context);
                              //             },
                              //             child: Icon(Icons.close)),
                              //         middle: Text('Notifications'),
                              //       ),
                              //       child:  FutureBuilder<QuerySnapshot>(
                              //           future: getNotifications(),
                              //           builder: (context, snapshot) {
                              //             if (snapshot.connectionState !=
                              //                 ConnectionState.done) {
                              //               return Padding(
                              //                 padding: const EdgeInsets.all(8.0),
                              //                 child: ListView(
                              //                   children: [
                              //                     LoadingWidget.rectangular(
                              //                         height: 60,
                              //                         width: MediaQuery.of(context).size.width),
                              //                     SizedBox(
                              //                       height: 10,
                              //                     ),
                              //                     LoadingWidget.rectangular(
                              //                         height: 60,
                              //                         width: MediaQuery.of(context).size.width),
                              //                     SizedBox(
                              //                       height: 10,
                              //                     ),
                              //                     LoadingWidget.rectangular(
                              //                         height: 60,
                              //                         width: MediaQuery.of(context).size.width),
                              //                     SizedBox(
                              //                       height: 10,
                              //                     ),
                              //                     LoadingWidget.rectangular(
                              //                         height: 60,
                              //                         width: MediaQuery.of(context).size.width),
                              //                     SizedBox(
                              //                       height: 10,
                              //                     ),
                              //                     LoadingWidget.rectangular(
                              //                         height: 60,
                              //                         width: MediaQuery.of(context).size.width),
                              //                     SizedBox(
                              //                       height: 10,
                              //                     ),
                              //                     LoadingWidget.rectangular(
                              //                         height: 60,
                              //                         width: MediaQuery.of(context).size.width),
                              //                     SizedBox(
                              //                       height: 10,
                              //                     ),
                              //                     LoadingWidget.rectangular(
                              //                         height: 60,
                              //                         width: MediaQuery.of(context).size.width),
                              //                   ],
                              //                 ),
                              //               );
                              //             }
                              //             if (snapshot.hasData) {
                              //               final List<DocumentSnapshot> documents =
                              //                   snapshot.data!.docs;
                              //               return ListView(
                              //                   children: documents.map((doc) {
                              //                     print('notifivctions2: ${doc}');
                              //                     print('notifivctions2: ${doc['title']}');
                              //                     PushNotification jobsFinal = PushNotification(
                              //                         title: doc['title'], body: doc['body']);
                              //                     return SizedBox(
                              //                       height: 90,
                              //                       width: MediaQuery.of(context).size.width * .9,
                              //                       child: Card(
                              //                         shape: const RoundedRectangleBorder(
                              //                           borderRadius: BorderRadius.only(
                              //                             topRight: Radius.circular(5),
                              //                             topLeft: Radius.circular(5),
                              //                             bottomLeft: Radius.circular(5),
                              //                             bottomRight: Radius.circular(5),
                              //                           ),
                              //                         ),
                              //                         color: Colors.white,
                              //                         elevation: 2,
                              //                         child: Padding(
                              //                           padding: const EdgeInsets.only(left: 18.0,top: 8),
                              //                           child: Row(
                              //                             mainAxisAlignment:
                              //                             MainAxisAlignment.start,
                              //                             crossAxisAlignment:
                              //                             CrossAxisAlignment.start,
                              //                             children: [
                              //                               Container(
                              //                                 height: 70,
                              //                                 width: 90,
                              //                                 decoration: BoxDecoration(
                              //                                     borderRadius: BorderRadius.only(
                              //                                         topRight: Radius.circular(5),
                              //                                         topLeft: Radius.circular(5),
                              //                                         bottomRight: Radius.circular(10),
                              //                                         bottomLeft: Radius.circular(10)),
                              //                                     image: DecorationImage(
                              //                                         image: NetworkImage(
                              //                                           doc['image'],
                              //                                         ),fit: BoxFit.fitHeight)),
                              //                               ),
                              //                               SizedBox(
                              //                                 width: 20,
                              //                               ),
                              //                               Column(
                              //                                 children: [
                              //                                   Text(
                              //                                     jobsFinal.title!.toUpperCase() ??
                              //                                         '',
                              //                                     style: TextStyle(
                              //                                         fontSize: 15,
                              //                                         color: Colors.black),
                              //                                   ),
                              //                                   Text(
                              //                                     jobsFinal.body!,
                              //                                     style: const TextStyle(
                              //                                         fontSize: 15,
                              //                                         fontWeight: FontWeight.w300,
                              //                                         color: Colors.black),
                              //                                   ),
                              //                                 ],
                              //                               ),
                              //                             ],
                              //                           ),
                              //                         ),
                              //                       ),
                              //                     );
                              //                   }).toList());
                              //             }
                              //             if (snapshot.hasError) {
                              //               return Text('${snapshot.error}');
                              //             }
                              //             return const Center(
                              //                 child: CircularProgressIndicator());
                              //           }),
                              //     );
                              //   },
                              // );
                            },
                            iconColor: Colors.indigo,
                            title: "Notification",
                            isSelected: true,
                            titleSize: 16,
                            iconSize: 22,
                            child: Container()),
                        ProfileTitle(
                            icon: Icons.password,
                            flagIcon: true,
                            onTap: () {
                              navigateTo(context, ForgetPassword(fromProfile: true,));
                            },
                            iconColor: Colors.indigo,
                            title: "Change Password",
                            isSelected: true,
                            titleSize: 16,
                            iconSize: 22,
                            child: Container()),
                        ProfileTitle(
                            icon: Icons.feed,
                            flagIcon: true,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => WriteToUs(
                                      currentUserMobile: widget.userMobile)));
                            },
                            iconColor: Colors.indigo,
                            title: "Feedback",
                            isSelected: true,
                            titleSize: 16,
                            iconSize: 22,
                            child: Container()),
                        ProfileTitle(
                            icon: Icons.help,
                            flagIcon: true,
                            onTap: () {
                              navigateTo(context, HelpAndSupport());
                            },
                            iconColor: Colors.indigo,
                            title: "Help & Support",
                            isSelected: true,
                            titleSize: 16,
                            iconSize: 22,
                            child: Container()),
                        SizedBox(
                          height: 50,
                        ),
                        ProfileTitle(
                            icon: Icons.logout,
                            flagIcon: true,
                            onTap: () {
                              BlocProvider.of<AuthCubit>(context).logOut();
                              var sharedPreferencesVM =
                                  Provider.of<SharedPreferencesVM>(context,
                                      listen: false);
                              sharedPreferencesVM.setLoginStatus(false);
                              navigateAndFinsh(context, LoginScreen());
                            },
                            iconColor: Colors.indigo,
                            title: "Logout",
                            isSelected: true,
                            titleSize: 16,
                            iconSize: 22,
                            child: Container()),
                      ],
                    ),
                  ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
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
          setState(() {});
          showToast(msg: result);
        } else {
          setState(() {
            flagUplaodImage = false;
            imageUrl = result;
            firebaseServices.setImagePath(widget.userMobile, result);
            updateUserDetails();
          });
        }
      } else {
        setState(() {});
        showToast(msg: 'sorry image not selected try again');
      }
    }
  }
}

class ProfileTitle extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final bool flagIcon;
  final Widget? child;
  final Function() onTap;
  final bool? isSelected;
  final Color? iconColor;
  final double iconSize;
  final double titleSize;

  ProfileTitle(
      {required this.title,
      required this.icon,
      required this.flagIcon,
      required this.child,
      required this.onTap,
      this.iconSize = 20,
      this.titleSize = 15,
      this.isSelected = false,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(16),
              // decoration: BoxDecoration(
              //     color: isSelected! ? Color(0xFFFFFFFF) : Color(0xFFFFFFFF),
              //     borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Row(
                children: [
                  flagIcon
                      ? Icon(icon,
                          size: iconSize,
                          color: const Color.fromRGBO(0, 0, 0, 0.7))
                      : child!,
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(title!,
                        style: TextStyle(
                            letterSpacing: .3,
                            fontSize: titleSize,
                            color: isSelected!
                                ? const Color.fromRGBO(0, 0, 0, 0.7)
                                : const Color.fromRGBO(0, 0, 0, 0.7))),
                  )
                ],
              )),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
          )
        ],
      ),
    );
  }
}
