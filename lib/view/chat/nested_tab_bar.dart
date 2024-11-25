
import 'package:flutter/material.dart';
import 'package:ows_bigcareer/view_model/chat_view_model.dart';
import 'package:provider/provider.dart';
import 'custom_tab_bar.dart';
import 'chat_user_stream_builder.dart';

class NestedTabBar extends StatefulWidget {
  const NestedTabBar(
      {Key? key,
      required this.isLoading,
      required this.tabBarViewName,
      required this.currentUserId,
      required this.listScrollController,
      required this.userMobile,
      required this.nestedTabController})
      : super(key: key);
  final isLoading, userMobile, currentUserId, tabBarViewName;
  final listScrollController;
  final nestedTabController;

  @override
  State<NestedTabBar> createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar> {
  late ChatViewModel homeProvider;
  final CustomTabBar _customTabBar = CustomTabBar();

  @override
  void initState() {
    // TODO: implement initState
    homeProvider = context.read<ChatViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TabBar(
            controller: widget.nestedTabController,
            indicatorColor: Colors.orange,
            labelColor: Colors.orange,
            unselectedLabelColor: Colors.black54,
            isScrollable: true,
            onTap: (v) {
              setState(() {});
            },
            tabs: _customTabBar.getTabs(widget.tabBarViewName)),
        Container(
          height: MediaQuery.of(context).size.height * 0.60,
          margin: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: TabBarView(
            controller: widget.nestedTabController,
            children: <Widget>[
              ChatUsersStreamBuilder(
                  firebaseCollectionName:  widget.tabBarViewName == 'freelancer'
                      ? 'HireByMe'
                      : 'MyProjects',
                  userMobile: widget.userMobile,
                  listScrollController: widget.listScrollController,
                  isLoading: widget.isLoading,
                  currentUserId: widget.currentUserId),
              ChatUsersStreamBuilder(
                  firebaseCollectionName:  widget.tabBarViewName == 'freelancer'
                      ? 'HireByOthers'
                      : 'OthersProjects',
                  userMobile: widget.userMobile,
                  listScrollController: widget.listScrollController,
                  isLoading: widget.isLoading,
                  currentUserId: widget.currentUserId),
            ],
          ),
        ),
      ],
    );
  }
}
