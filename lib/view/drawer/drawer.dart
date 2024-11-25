import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_package1/common_scafold.dart';
import 'package:flutter_package1/components.dart';
import 'package:ows_bigcareer/model/cubits/auth_cubit/auth_cubit.dart';
import 'package:ows_bigcareer/model/models/model_app_user.dart';
import 'package:ows_bigcareer/view/drawer/saved_jobs.dart';
import 'package:ows_bigcareer/view/freelancer/freelancer/freelancer.dart';
import 'package:ows_bigcareer/view/freelancer/projects/home_screen_projects.dart';
import 'package:ows_bigcareer/view/freelancer/projects/my_projects.dart';
import 'package:ows_bigcareer/view/gov_job/applied_jobs.dart';
import 'package:ows_bigcareer/view/gov_job/gov_job.dart';
import 'package:ows_bigcareer/view/auth/login.dart';
import 'package:ows_bigcareer/view/freelancer/freelancer_tab.dart';
import 'package:ows_bigcareer/view/search/search_job.dart';
import '../bottom_tabs/drawer-tile.dart';
import 'package:provider/provider.dart';
import 'package:ows_bigcareer/view_model/sharedpreferences_view_model.dart';
import 'liked.dart';
import 'write_to_us.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ArgonDrawer extends StatefulWidget {
  final String? currentPage;
  final String? currentUserName;
  final String? currentUserEmail;
  final String? currentUserMobile;
  final String? currentUserImage;


  const ArgonDrawer(
      {super.key, required this.currentPage,
        required this.currentUserName,
      required this.currentUserEmail,
      required this.currentUserMobile,
        required this.currentUserImage
      });

  @override
  State<ArgonDrawer> createState() => _ArgonDrawerState();
}

class _ArgonDrawerState extends State<ArgonDrawer> {
  late AppUser appUser;
  String? imageUrl;
  bool flagUserData=true;

  getUserDetails() async {
    var sharedPreferencesVM =
    Provider.of<SharedPreferencesVM>(context, listen: false);
    appUser = await sharedPreferencesVM.getUserDetails();
    imageUrl = appUser.image;
    setState(() {
      flagUserData = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserDetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: MediaQuery.of(context).size.width * .7,
        child: flagUserData?Column(children: [],):Column(children: [
          Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.105,
              width: MediaQuery.of(context).size.width * 0.85,
              child: SafeArea(
                bottom: false,
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/logo.png",
                    width: 80,
                    height: 35,
                  ),
                ),
              )),
          Container(
            height: 85,
            width: MediaQuery.of(context).size.width * 0.85,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width * .85,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: AssetImage("assets/img_3.png"))),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 15,
                        left: 15,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24.0,
                              backgroundImage: NetworkImage(
                                  appUser.image??'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80'),
                              backgroundColor: Colors.transparent,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      appUser.name ?? 'guest',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Colors.white),
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
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  appUser.email ?? 'guest',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              padding: const EdgeInsets.only(left: 8, right: 16),
              height: MediaQuery.of(context).size.height * .730,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DrawerTile(
                        icon: Icons.search,
                        flagIcon: true,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const SearchJob()));
                        },
                        iconColor: Colors.indigo,
                        title: "Search Jobs",
                        isSelected: widget.currentPage == "Account" ? true : false,
                        child: Container()),
                    DrawerTile(
                        icon: Icons.note_alt_outlined,
                        flagIcon: true,
                        child: Container(),
                        onTap: () {
                          navigateTo(context, GovernmentJobs(userMobile: widget.currentUserMobile,));
                          // if (currentPage != "change_password")
                          //   Navigator.pushReplacementNamed(context, '/profile');
                        },
                        iconColor: Colors.indigo,
                        title: "Government Jobs",
                        isSelected: widget.currentPage == "Profile" ? true : false),
                    DrawerTile(
                        icon: Icons.thumb_up,
                        flagIcon: true,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => SavedJobs(userMobile: widget.currentUserMobile,)));
                        },
                        iconColor: Colors.indigo,
                        title: "Liked Jobs",
                        isSelected: widget.currentPage == "Elements" ? true : false,
                        child: Container()),
                    DrawerTile(
                        icon:Icons.bookmark_add_outlined,
                        flagIcon: false,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => AppliedJobs(userMobile: widget.currentUserMobile)));
                        },
                        iconColor: Colors.indigo,
                        title: "Applied Jobs",
                        isSelected: widget.currentPage == "Elements" ? true : false,
                        child:  const FaIcon(
                          FontAwesomeIcons.paperPlane,
                          color: Colors.black54,
                          size: 18,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                        height: 4, thickness: 0, color: Color.fromRGBO(136, 152, 170, 1.0)),
                    const SizedBox(
                      height: 20,
                    ),
                    DrawerTile(
                        icon: Icons.people_alt_outlined,
                        flagIcon: true,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) =>
                                  Freelancers(userMobile: widget.currentUserMobile)));
                          // if (currentPage != "Elements")
                          //   Navigator.pushReplacementNamed(context, '/elements');
                        },
                        iconColor: Colors.indigo,
                        title: "Freelancers",
                        isSelected: widget.currentPage == "Elements" ? true : false,
                        child: Container()),
                    const SizedBox(
                      height: 10,
                    ),
                    DrawerTile(
                        icon: Icons.cases_outlined,
                        flagIcon: true,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) =>
                              HomeScreenProjects(userMobile: widget.currentUserMobile,)));
                          // if (currentPage != "Elements")
                          //   Navigator.pushReplacementNamed(context, '/elements');
                        },
                        iconColor: Colors.indigo,
                        title: "Projects",
                        isSelected: widget.currentPage == "Elements" ? true : false,
                        child: Container()),
                    DrawerTile(
                        icon: Icons.cases_rounded,
                        flagIcon: true,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) =>
                                  MyProjects(userMobile: widget.currentUserMobile,)));
                          // if (currentPage != "Elements")
                          //   Navigator.pushReplacementNamed(context, '/elements');
                        },
                        iconColor: Colors.indigo,
                        title: "My Projects",
                        isSelected: widget.currentPage == "Elements" ? true : false,
                        child: Container()),
                    const SizedBox(
                      height: 10,
                    ),
                    DrawerTile(
                        icon: Icons.favorite,
                        flagIcon: true,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => LikedFP(userMobile: widget.currentUserMobile,)));
                        },
                        iconColor: Colors.indigo,
                        title: "Liked",
                        isSelected: widget.currentPage == "Elements" ? true : false,
                        child: Container()),

                    const Divider(
                        height: 4, thickness: 0, color: Color.fromRGBO(136, 152, 170, 1.0)),
                    const SizedBox(
                      height: 20,
                    ),
                    DrawerTile(
                        icon: Icons.mark_email_unread_outlined,
                        flagIcon: true,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) =>
                                  WriteToUs(currentUserMobile:widget.currentUserMobile)));
                        },
                        iconColor: Colors.indigo,
                        title: "Write to Us",
                        isSelected: widget.currentPage == "Articles" ? true : false,
                        child: Container()),
                    DrawerTile(
                        icon: Icons.logout,
                        flagIcon: true,
                        onTap: () async {
                          BlocProvider.of<AuthCubit>(context).logOut();
                          var sharedPreferencesVM =
                              Provider.of<SharedPreferencesVM>(context,
                                  listen: false);
                          sharedPreferencesVM.setLoginStatus(false);
                          navigateAndFinsh(context, const LoginScreen());
                        },
                        iconColor: Colors.indigo,
                        title: "Logout",
                        isSelected: widget.currentPage == "Articles" ? true : false,
                        child: Container()),
                  ],
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.040,
                    width: MediaQuery.of(context).size.width * .7,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/img_3.png"))),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                    ),
                  ),
                ),
                const Positioned(
                  top: 6,
                  left: 60,
                  child: Text(
                    'Version 1.0.1',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //     color: const Color(0xff0a37ec),
          //     height: MediaQuery.of(context).size.height * 0.040,
          //     child: const Center(
          //       child: Text(
          //         'Version 1.0.1',
          //         style: TextStyle(color: Colors.white, fontSize: 12),
          //       ),
          //     )),
        ]));
  }
}
