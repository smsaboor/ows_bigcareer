import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_package1/loading/loading1.dart';
import 'package:ows_bigcareer/model/models/model_app_user.dart';
import 'package:ows_bigcareer/model/shared_preference/shared_preferens.dart';
import 'package:ows_bigcareer/view_model/sharedpreferences_view_model.dart';
import 'package:ows_bigcareer/view_model/setting_view_model.dart';
import 'package:provider/provider.dart';
// https://stackoverflow.com/questions/66901731/save-recieved-push-notifications-in-sqflite-flutter

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
  print('Got a message whilst in the BACKGROUND or TERMINATED!');
  if (message.notification != null) {
    print(
        'Message also contained a notification, with the following:\nTitle: ${message.notification?.title}\nBody: ${message.notification?.body}');
    // addNotification('notifications',
    //     {"message":message.notification!.title.toString(),"body":message.notification!.body.toString()});
  }
}

Future<void> addNotification(user, Map<String, String> data) async {
  final sp = SharedPreferencesVM(appPreferences: AppPreferences());
  AppUser appUser = await sp.getUserDetails();
  return FirebaseFirestore.instance
      .collection('notifications')
      .doc(appUser.mobile)
      .collection(appUser.mobile)
      .doc()
      .set(data);
}

class NotificationButton extends StatefulWidget {
  NotificationButton({required this.userMobile, required this.onTap});
  final onTap;
  final userMobile;

  @override
  _NotificationButtonState createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  late int _totalNotifications;
  late final FirebaseMessaging _messaging;
  PushNotification? _notificationInfo;

  // For handling notification when the app is in terminated state
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
      );
      setState(() {
        _notificationInfo = notification;
        // _totalNotifications++;
        int count = Provider.of<SettingViewModel>(context, listen: false)
            .getNotificationCount;
        Provider.of<SettingViewModel>(context, listen: false)
            .setNotificationCount(count + 1);
      });
    }
    checkForInitialMessage();
  }

  @override
  void initState() {
    // _totalNotifications = 0;
    Provider.of<SettingViewModel>(context, listen: false)
        .setNotificationCount(0);
    registerNotification();
    checkForInitialMessage();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
      );
      setState(() {
        _notificationInfo = notification;
        // _totalNotifications++;

        //change on 14-jan for extra add notification icon
        // int count = Provider.of<SettingViewModel>(context, listen: false)
        //     .getNotificationCount;
        // Provider.of<SettingViewModel>(context, listen: false)
        //     .setNotificationCount(count + 1);
      });
    });
    super.initState();
  }

  void registerNotification() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();
    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;
    // 3. On iOS, this helps to take the user permissions
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );
        setState(() {
          _notificationInfo = notification;
          // _totalNotifications++;
          int count = Provider.of<SettingViewModel>(context, listen: false)
              .getNotificationCount;
          Provider.of<SettingViewModel>(context, listen: false)
              .setNotificationCount(count + 1);
        });
        if (_notificationInfo != null) {
          // For displaying the notification as an overlay
          showSimpleNotification(
            Text(_notificationInfo!.title!),
            leading: NotificationBadge(
                totalNotifications:
                    Provider.of<SettingViewModel>(context, listen: false)
                        .getNotificationCount),
            subtitle: Text(_notificationInfo!.body!),
            background: Colors.cyan.shade700,
            duration: const Duration(seconds: 2),
          );
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<QuerySnapshot> getNotifications() async {
    var notifications =
        FirebaseFirestore.instance.collection('notifications').get();
    return notifications;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
            onPressed: () {
              // Provider.of<SettingViewModel>(context, listen: false).setNotificationCount(0);
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
              //       child: FutureBuilder<QuerySnapshot>(
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
              //                 print('notifivctions2: ${doc}');
              //                 print('notifivctions2: ${doc['title']}');
              //                 PushNotification jobsFinal = PushNotification(
              //                     title: doc['title'], body: doc['body']);
              //                 return SizedBox(
              //                   height: 90,
              //                   width: MediaQuery.of(context).size.width * .9,
              //                   child: Card(
              //                     shape: const RoundedRectangleBorder(
              //                       borderRadius: BorderRadius.only(
              //                         topRight: Radius.circular(5),
              //                         topLeft: Radius.circular(5),
              //                         bottomLeft: Radius.circular(5),
              //                         bottomRight: Radius.circular(5),
              //                       ),
              //                     ),
              //                     color: Colors.white,
              //                     elevation: 2,
              //                     child: Padding(
              //                       padding: const EdgeInsets.only(left: 18.0,top: 8),
              //                       child: Row(
              //                         mainAxisAlignment:
              //                             MainAxisAlignment.start,
              //                         crossAxisAlignment:
              //                             CrossAxisAlignment.start,
              //                         children: [
              //                           Container(
              //                             height: 70,
              //                             width: 90,
              //                             decoration: BoxDecoration(
              //                                 borderRadius: BorderRadius.only(
              //                                     topRight: Radius.circular(5),
              //                                     topLeft: Radius.circular(5),
              //                                     bottomRight: Radius.circular(10),
              //                                     bottomLeft: Radius.circular(10)),
              //                                 image: DecorationImage(
              //                                     image: NetworkImage(
              //                                       doc['image'],
              //                                     ),fit: BoxFit.fitHeight)),
              //                           ),
              //                           SizedBox(
              //                             width: 20,
              //                           ),
              //                           Column(
              //                             children: [
              //                               Text(
              //                                 jobsFinal.title!.toUpperCase() ??
              //                                     '',
              //                                 style: TextStyle(
              //                                     fontSize: 15,
              //                                     color: Colors.black),
              //                               ),
              //                               Text(
              //                                 jobsFinal.body!,
              //                                 style: const TextStyle(
              //                                     fontSize: 15,
              //                                     fontWeight: FontWeight.w300,
              //                                     color: Colors.black),
              //                               ),
              //                             ],
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                 );
              //               }).toList());
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
              // navigateTo(context, const SearchJob());
            },
            icon: const Icon(Icons.notifications_none_sharp,
                size: 24, color: Colors.black54)),
        Provider.of<SettingViewModel>(context, listen: false)
                    .getNotificationCount ==
                0
            ? Container()
            : Positioned(
                left: 25,
                top: 8,
                child: NotificationBadge(
                    totalNotifications:
                        Provider.of<SettingViewModel>(context, listen: true)
                            .getNotificationCount),
              )
      ],
    );
  }

  Widget section(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title,
      ),
    );
  }
}

class NotificationBadge extends StatelessWidget {
  final int totalNotifications;

  const NotificationBadge({required this.totalNotifications});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingViewModel>(builder: (context, model, child) {
      return Container(
        width: 15.0,
        height: 15.0,
        decoration: new BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(
              '${model.getNotificationCount}',
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        ),
      );
    });
  }
}

class PushNotification {
  PushNotification({
    this.title,
    this.body,
  });

  String? title;
  String? body;
}
