//https://blog.codemagic.io/flutter-local-notifications/

import 'package:flutter/material.dart';
import 'notifiction_service.dart';


class NotificationHome extends StatefulWidget {
  const NotificationHome({Key? key}) : super(key: key);
  @override
  State<NotificationHome> createState() => _NotificationHomeState();
}

class _NotificationHomeState extends State<NotificationHome> {
  late final NotificationService notificationService;

  @override
  void initState() {
    notificationService = NotificationService();
    listenToNotificationStream();
    notificationService.initializePlatformNotifications();
    super.initState();
  }
  void listenToNotificationStream() =>
      notificationService.behaviorSubject.listen((payload) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MySecondScreen(payload: payload)));
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("JustWater"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            margin: const EdgeInsets.only(bottom: 100),
            // Update with local image
            child: Image.asset("assets/img_8.png", scale: 0.6),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: () async{
                await notificationService.showLocalNotification(
                    id: 0,
                    title: "Drink Water",
                    body: "Time to drink some water!",
                    payload: "You just took water! Hurray!");
              }, child: const Text("Drink Now")),
              ElevatedButton(
                  onPressed: () async{
                    // await notificationService.showScheduledLocalNotification(
                    //     id: 1,
                    //     title: "Drink Water",
                    //     body: "Time to drink some water!",
                    //     payload: "You just took water! Hurray!",
                    //     seconds: 2);
                    await notificationService.showPeriodicLocalNotification(
                        id: 1,
                        title: "Drink Water",
                        body: "Time to drink some water!",
                        payload: "You just took water! Hurray!");
                  }, child: const Text("Schedule Drink "))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {}, child: const Text("Drink grouped")),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Cancel All Drinks",
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class MySecondScreen extends StatelessWidget {
  final String payload;
  const MySecondScreen({Key? key, required this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("JustWater"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 100),
              child: Image.asset(
                "assets/img_8.png",
              ),
            ),
            Text(payload)
          ],
        ),
      ),
    );
  }
}
