import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'App for capturing Firebase Push Notifications',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 16.0),
          // NotificationBadge(totalNotifications: _totalNotifications),
          SizedBox(height: 16.0),
          // _notificationInfo != null
          //     ? Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             'TITLE: ${_notificationInfo!.dataTitle ?? _notificationInfo!.title}',
          //             style: const TextStyle(
          //               fontWeight: FontWeight.bold,
          //               fontSize: 16.0,
          //             ),
          //           ),
          //           const SizedBox(height: 8.0),
          //           Text(
          //             'BODY: ${_notificationInfo!.dataBody ?? _notificationInfo!.body}',
          //             style: const TextStyle(
          //               fontWeight: FontWeight.bold,
          //               fontSize: 16.0,
          //             ),
          //           ),
          //         ],
          //       )
          //     : Container(),
        ],
      ),
    );
  }
}
