import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:ows_bigcareer/view/auth/login.dart';
import 'package:provider/provider.dart';
import 'package:ows_bigcareer/view_model/chat_view_model.dart';
import 'nested_tab_bar.dart';
import 'custom_tab_bar.dart';

class ChatHome extends StatefulWidget {
  ChatHome({Key? key, required this.userMobile}) : super(key: key);
  final userMobile;

  @override
  State createState() => ChatHomeState();
}

class ChatHomeState extends State<ChatHome> with TickerProviderStateMixin {
  ChatHomeState({Key? key});

  late final TabController _tabController;
  late TabController _nestedTabControllerFreelancers;
  late TabController _nestedTabControllerProjects;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final ScrollController listScrollController = ScrollController();
  CustomTabBar _customTabBar = CustomTabBar();
  int _limit = 20;
  int _limitIncrement = 20;
  String _textSearch = "";
  bool isLoading = false;

  late String currentUserId;
  late ChatViewModel homeProvider;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _nestedTabControllerFreelancers = TabController(length: 2, vsync: this);
    _nestedTabControllerProjects = TabController(length: 2, vsync: this);
    homeProvider = context.read<ChatViewModel>();
    if (widget.userMobile.isEmpty) {
      showToast(msg: 'Oops something wrong Please Login again!');
      navigateAndFinsh(context, const LoginScreen());
    } else {
      currentUserId = widget.userMobile;
    }
    // registerNotification();
    // configLocalNotification();
    listScrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 50,
              color: Colors.indigo,
              child: AppBar(
                bottom: TabBar(
                    controller: _tabController,
                    labelColor: const Color.fromRGBO(4, 2, 46, 1),
                    indicatorColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    unselectedLabelStyle:
                        TextStyle(color: Colors.grey.shade400, fontSize: 13),
                    indicatorSize: TabBarIndicatorSize.tab,
                    onTap: (index) {
                      setState(() {});
                    },
                    tabs: _customTabBar.getTabs('mainTab')),
              ),
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                NestedTabBar(
                    tabBarViewName: 'freelancer',
                    isLoading: isLoading,
                    currentUserId: currentUserId,
                    listScrollController: listScrollController,
                    userMobile: widget.userMobile,
                    nestedTabController: _nestedTabControllerFreelancers),
                NestedTabBar(
                    tabBarViewName: 'project',
                    isLoading: isLoading,
                    currentUserId: currentUserId,
                    listScrollController: listScrollController,
                    userMobile: widget.userMobile,
                    nestedTabController: _nestedTabControllerProjects)
              ]),
            )
          ],
        ),
      ),
    );
  }
}
