import 'package:flutter/material.dart';

class CustomTabBar {
  CustomTabBar({Key? key});

  List<Widget> freelancersTabs = [
    const Tab(
      text: "I hire others",
    ),
    const Tab(
      text: "Others hire me",
    ),
  ];
  List<Widget> projectsTabs = [
    const Tab(
      text: "My Bids on Other Projects",
    ),
    const Tab(text: "Bid on My Projects"),
  ];

  List<Widget> mainTab = [
    const Tab(
      child: Text(
        'Freelancers',
        style: TextStyle(color: Colors.white),
      ),
    ),
    const Tab(
      child: Text(
        'Projects',
        style: TextStyle(color: Colors.white),
      ),
    ),
  ];

  getTabs(String tabName) {
    if (tabName == 'freelancer') {
      return freelancersTabs;
    } else if (tabName == 'mainTab') {
      return mainTab;
    } else {
      return projectsTabs;
    }
  }
}
