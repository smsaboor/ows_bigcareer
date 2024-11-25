import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:ows_bigcareer/model/apis/urls.dart';
import 'package:ows_bigcareer/view/chat/chat_home.dart';
import 'package:ows_bigcareer/view/profile/profile.dart';
import 'package:ows_bigcareer/view/drawer/drawer.dart';
import 'package:ows_bigcareer/view/job_tab/job_tab.dart';
import 'package:ows_bigcareer/view/freelancer/freelancer_tab.dart';
import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';
import 'package:ows_bigcareer/view/search/search_job.dart';
import 'package:ows_bigcareer/view_model/sharedpreferences_view_model.dart';
import 'package:provider/provider.dart';
import 'package:ows_bigcareer/model/models/model_app_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'notification_button.dart';

class BigCareerBottomNavBar extends StatefulWidget {
  @override
  _BigCareerBottomNavBarState createState() => _BigCareerBottomNavBarState();
}

class _BigCareerBottomNavBarState extends State<BigCareerBottomNavBar>
    with TickerProviderStateMixin {
  int currentPage = 0;
  int tabIndex = 0;
  var data;
  int value = 0;
  bool flagUserData = false;

  AppUser? appUser;
  static const myUser = AppUser(
      name: 'Mr Guest',
      email: 'guest@gmail.com',
      mobile: '0000000000',
      uid: '123',
      pwd: '00000',
      image: 'https://i.pinimg.com/736x/86/63/78/866378ef5afbe8121b2bcd57aa4fb061.jpg');
  int exitValue = 0;

  registerNewUser(var body) async {
    print('datatata-body-----------------${body}');
    http.Response response = await http
        .post(Uri.parse('${API_BASE_URL}create_user_api.php'), body: body);
    var data = jsonDecode(response.body);
    print('datatata------------------${data}');
  }

  Future<void> getUserDetails() async {
    flagUserData = true;
    var sharedPreferencesVM = Provider.of<SharedPreferencesVM>(context, listen: false);
    appUser = await sharedPreferencesVM.getUserDetails();
    print('-----getUserDetails-------------------${appUser}');
    Map<String, String> body = {
      "name": appUser!.name,
      "mobile": appUser!.mobile,
      "firebase_id": appUser!.uid,
      "image": "https://i.pinimg.com/736x/86/63/78/866378ef5afbe8121b2bcd57aa4fb061.jpg"
    };
    registerNewUser(body);
    if (appUser != null) {
      setState(() {
        flagUserData = false;
      });
    } else {
      setState(() {
        flagUserData = true;
      });
    }
  }

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  Future<bool> onBackPress() {
    setState(() {
      exitValue = exitValue + 1;
    });
    showToast(msg: 'Press Back again to exit');
    if (exitValue == 2) {
      exit(0);
    }
    Future.delayed(const Duration(seconds: 2)).then((value) =>
        setState(() {
          exitValue = 0;
        }));
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final viewPadding = MediaQuery
        .of(context)
        .viewPadding;
    double barHeight;
    double barHeightWithNotch = 67;
    double arcHeightWithNotch = 67;

    if (size.height > 700) {
      barHeight = 70;
    } else {
      barHeight = size.height * 0.1;
    }

    if (viewPadding.bottom > 0) {
      barHeightWithNotch = (size.height * 0.07) + viewPadding.bottom;
      arcHeightWithNotch = (size.height * 0.075) + viewPadding.bottom;
    }

    return flagUserData
        ? const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    )
        : Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.indigo,
                    size: 24, // Changing Drawer Icon Size
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip: MaterialLocalizations
                      .of(context)
                      .openAppDrawerTooltip,
                ),
              ],
            );
          },
        ),
        actions: <Widget>[
          // IconButton(
          //     onPressed: () {
          //       navigateTo(context, PaytmDemo());
          //     },
          //     icon: const Icon(Icons.payment, color: Colors.grey)),
          IconButton(
              onPressed: () {
                navigateTo(context, const SearchJob());
              },
              icon: const Icon(Icons.search, color: Colors.grey)),
          NotificationButton( userMobile: appUser!.mobile,onTap:(v){setState((){});}),


        ],
        actionsIconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/logo.png',
          width: 80,
          height: 40,
        ),
        centerTitle: true,
      ),
      drawer: ArgonDrawer(
          currentPage: 'Home',
          currentUserImage: appUser!.image,
          currentUserMobile: appUser!.mobile,
          currentUserName: appUser!.name,
          currentUserEmail: appUser!.email),
      body: WillPopScope(
        onWillPop: onBackPress,
        child: getBody('patientData', currentPage, data),
      ),
      bottomNavigationBar: CircleBottomNavigationBar(
        initialSelection: currentPage,
        barHeight:
        viewPadding.bottom > 0 ? barHeightWithNotch : barHeight,
        arcHeight:
        viewPadding.bottom > 0 ? arcHeightWithNotch : barHeight,
        itemTextOff: viewPadding.bottom > 0 ? 0 : 1,
        itemTextOn: viewPadding.bottom > 0 ? 0 : 1,
        circleOutline: 15.0,
        shadowAllowance: 0.0,
        circleSize: 50.0,
        blurShadowRadius: 50.0,
        circleColor: const Color(0xff0a37ec),
        activeIconColor: Colors.white,
        inactiveIconColor: Colors.grey,
        tabs: getTabsData(),
        onTabChangedListener: (index) {
          if (index == 0) {
            setState(() {
              currentPage = 0;
            });
          } else if (index == 1) {
            setState(() {
              currentPage = 1;
            });
          } else if (index == 2) {
            setState(() {
              currentPage = 2;
            });
          } else if (index == 3) {
            setState(() {
              currentPage = 3;
            });
          }
        },
      ),
    );
  }

  getBody(var patientData, int currentPage, var data) {
    switch (currentPage) {
      case 0:
        return JobsTab(
          userMobile: appUser!.mobile,
        );
      case 1:
        return FreelancerTab(
          appBar: false,
          userMobile: appUser!.mobile,
        );
      case 2:
        return ChatHome(userMobile: appUser!.mobile);
      case 3:
        return ProfileTab(userMobile: appUser!.mobile);
    }
  }
}

List<TabData> getTabsData() {
  return [
    TabData(
      icon: Icons.library_books,
      iconSize: 25.0,
      title: 'Jobs',
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    TabData(
      icon: Icons.cases_rounded,
      iconSize: 25,
      title: 'Freelancer',
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    TabData(
      icon: FontAwesomeIcons.comments,
      iconSize: 25,
      title: 'Chats',
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    TabData(
      icon: Icons.perm_identity,
      iconSize: 25,
      title: 'Profile',
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
  ];
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Home',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Appointment',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Earning',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class Alarm extends StatelessWidget {
  const Alarm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Profile ',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
//
// class NotificationBadge extends StatelessWidget {
//   final int totalNotifications;
//
//   const NotificationBadge({required this.totalNotifications});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 40.0,
//       height: 40.0,
//       decoration: new BoxDecoration(
//         color: Colors.red,
//         shape: BoxShape.circle,
//       ),
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             '$totalNotifications',
//             style: const TextStyle(color: Colors.white, fontSize: 20),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class PushNotification {
//   PushNotification({
//     this.title,
//     this.body,
//     this.dataTitle,
//     this.dataBody,
//   });
//
//   String? title;
//   String? body;
//   String? dataTitle;
//   String? dataBody;
// }
