// import 'dart:async';
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:provider/provider.dart';
//
//
// class ChatHome extends StatefulWidget {
//   ChatHome({Key? key}) : super(key: key);
//   @override
//   State createState() => ChatHomeState();
// }
//
// class ChatHomeState extends State<ChatHome> {
//   ChatHomeState({Key? key});
//
//   final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
//   final ScrollController listScrollController = ScrollController();
//
//   int _limit = 20;
//   int _limitIncrement = 20;
//   String _textSearch = "";
//   bool isLoading = false;
//
//   late String currentUserId;
//   late HomeProvider homeProvider;
//   Debouncer searchDebouncer = Debouncer(milliseconds: 300);
//   StreamController<bool> btnClearController = StreamController<bool>();
//   TextEditingController searchBarTec = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     homeProvider = context.read<HomeProvider>();
//     registerNotification();
//     configLocalNotification();
//     listScrollController.addListener(scrollListener);
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     btnClearController.close();
//   }
//
//   void registerNotification() {
//     firebaseMessaging.requestPermission();
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('onMessage: $message');
//       if (message.notification != null) {
//         showNotification(message.notification!);
//       }
//       return;
//     });
//
//     firebaseMessaging.getToken().then((token) {
//       print('push token: $token');
//       if (token != null) {
//         homeProvider.updateDataFirestore(FirestoreConstants.pathUserCollection, currentUserId, {'pushToken': token});
//       }
//     }).catchError((err) {
//       Fluttertoast.showToast(msg: err.message.toString());
//     });
//   }
//
//   void configLocalNotification() {
//     AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
//     IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();
//     InitializationSettings initializationSettings =
//     InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   void scrollListener() {
//     if (listScrollController.offset >= listScrollController.position.maxScrollExtent &&
//         !listScrollController.position.outOfRange) {
//       setState(() {
//         _limit += _limitIncrement;
//       });
//     }
//   }
//
//   void onItemMenuPress(PopupChoices choice) {
//     if (choice.title == 'Log out') {
//       handleSignOut();
//     } else {
//       Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
//     }
//   }
//
//   void showNotification(RemoteNotification remoteNotification) async {
//     AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       Platform.isAndroid ? 'com.dfa.flutterchatdemo' : 'com.duytq.flutterchatdemo',
//       'Flutter chat demo',
//       playSound: true,
//       enableVibration: true,
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     IOSNotificationDetails iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     NotificationDetails platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
//
//     print(remoteNotification);
//
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       remoteNotification.title,
//       remoteNotification.body,
//       platformChannelSpecifics,
//       payload: null,
//     );
//   }
//
//   Future<bool> onBackPress() {
//     openDialog();
//     return Future.value(false);
//   }
//
//   Future<void> openDialog() async {
//     switch (await showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return SimpleDialog(
//             clipBehavior: Clip.hardEdge,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//             contentPadding: EdgeInsets.zero,
//             children: <Widget>[
//               Container(
//                 color: AppColors.themeColor,
//                 padding: EdgeInsets.only(bottom: 10, top: 10),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     Container(
//                       child: Icon(
//                         Icons.exit_to_app,
//                         size: 30,
//                         color: Colors.white,
//                       ),
//                       margin: EdgeInsets.only(bottom: 10),
//                     ),
//                     Text(
//                       'Exit app',
//                       style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       'Are you sure to exit app?',
//                       style: TextStyle(color: Colors.white70, fontSize: 14),
//                     ),
//                   ],
//                 ),
//               ),
//               SimpleDialogOption(
//                 onPressed: () {
//                   Navigator.pop(context, 0);
//                 },
//                 child: Row(
//                   children: <Widget>[
//                     Container(
//                       child: Icon(
//                         Icons.cancel,
//                         color: AppColors.primaryColor,
//                       ),
//                       margin: EdgeInsets.only(right: 10),
//                     ),
//                     Text(
//                       'Cancel',
//                       style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
//                     )
//                   ],
//                 ),
//               ),
//               SimpleDialogOption(
//                 onPressed: () {
//                   Navigator.pop(context, 1);
//                 },
//                 child: Row(
//                   children: <Widget>[
//                     Container(
//                       child: Icon(
//                         Icons.check_circle,
//                         color: AppColors.primaryColor,
//                       ),
//                       margin: EdgeInsets.only(right: 10),
//                     ),
//                     Text(
//                       'Yes',
//                       style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           );
//         })) {
//       case 0:
//         break;
//       case 1:
//         exit(0);
//     }
//   }
//
//   Future<void> handleSignOut() async {
//     authProvider.handleSignOut();
//     Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(builder: (context) => LoginPage()),
//           (Route<dynamic> route) => false,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: WillPopScope(
//           child: Stack(
//             children: <Widget>[
//               // List
//               Column(
//                 children: [
//                   // buildSearchBar(),
//                   Expanded(
//                     child: StreamBuilder<QuerySnapshot>(
//                       stream: homeProvider.getStreamFireStore(currentUserId,FirestoreConstants.pathUserCollection, _limit, _textSearch),
//                       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                         if (snapshot.hasData) {
//                           if ((snapshot.data?.docs.length ?? 0) > 0) {
//                             return ListView.builder(
//                               padding: EdgeInsets.all(10),
//                               itemBuilder: (context, index) => CardChatUser(
//                             document: snapshot.data?.docs[index].id??'null'),
//                               itemCount: snapshot.data?.docs.length,
//                               controller: listScrollController,
//                             );
//                           } else {
//                             return Center(
//                               child: Text("No users"),
//                             );
//                           }
//                         } else {
//                           return Center(
//                             child: CircularProgressIndicator(
//                               color: AppColors.themeColor,
//                             ),
//                           );
//                         }
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//
//               // Loading
//               Positioned(
//                 child: isLoading ? LoadingView() : SizedBox.shrink(),
//               )
//             ],
//           ),
//           onWillPop: onBackPress,
//         ),
//       ),
//     );
//   }
//
//   // Widget buildSearchBar() {
//   //   return Container(
//   //     height: 40,
//   //     child: Row(
//   //       crossAxisAlignment: CrossAxisAlignment.center,
//   //       children: [
//   //         Icon(Icons.search, color: AppColors.greyColor, size: 20),
//   //         SizedBox(width: 5),
//   //         Expanded(
//   //           child: TextFormField(
//   //             textInputAction: TextInputAction.search,
//   //             controller: searchBarTec,
//   //             onChanged: (value) {
//   //               searchDebouncer.run(() {
//   //                 if (value.isNotEmpty) {
//   //                   btnClearController.add(true);
//   //                   setState(() {
//   //                     _textSearch = value;
//   //                   });
//   //                 } else {
//   //                   btnClearController.add(false);
//   //                   setState(() {
//   //                     _textSearch = "";
//   //                   });
//   //                 }
//   //               });
//   //             },
//   //             decoration: InputDecoration.collapsed(
//   //               hintText: 'Search nickname (you have to type exactly string)',
//   //               hintStyle: TextStyle(fontSize: 13, color: AppColors.greyColor),
//   //             ),
//   //             style: TextStyle(fontSize: 13),
//   //           ),
//   //         ),
//   //         StreamBuilder<bool>(
//   //             stream: btnClearController.stream,
//   //             builder: (context, snapshot) {
//   //               return snapshot.data == true
//   //                   ? GestureDetector(
//   //                   onTap: () {
//   //                     searchBarTec.clear();
//   //                     btnClearController.add(false);
//   //                     setState(() {
//   //                       _textSearch = "";
//   //                     });
//   //                   },
//   //                   child: Icon(Icons.clear_rounded, color: AppColors.greyColor, size: 20))
//   //                   : SizedBox.shrink();
//   //             }),
//   //       ],
//   //     ),
//   //     decoration: BoxDecoration(
//   //       borderRadius: BorderRadius.circular(16),
//   //       color: AppColors.greyColor2,
//   //     ),
//   //     padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
//   //     margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
//   //   );
//   // }
//
//   Widget buildPopupMenu() {
//     return PopupMenuButton<PopupChoices>(
//       onSelected: onItemMenuPress,
//       itemBuilder: (BuildContext context) {
//         return choices.map((PopupChoices choice) {
//           return PopupMenuItem<PopupChoices>(
//               value: choice,
//               child: Row(
//                 children: <Widget>[
//                   Icon(
//                     choice.icon,
//                     color: AppColors.primaryColor,
//                   ),
//                   Container(
//                     width: 10,
//                   ),
//                   Text(
//                     choice.title,
//                     style: TextStyle(color: AppColors.primaryColor),
//                   ),
//                 ],
//               ));
//         }).toList();
//       },
//     );
//   }
//
//   Widget buildItem(BuildContext context, DocumentSnapshot? document) {
//     print('-buildItem----${document}-------------------');
//     if (document != null) {
//       UserChat userChat = UserChat.fromDocument(document);
//       print('-buildItem----${userChat.id}-------------${currentUserId}------');
//       print('-buildItem----${userChat.photoUrl}-------------------');
//       print('-buildItem----${userChat.nickname}-------------------');
//       if (userChat.id == currentUserId) {
//         return SizedBox.shrink();
//       } else {
//         return Container(
//           child: TextButton(
//             child: Row(
//               children: <Widget>[
//                 Material(
//                   child: userChat.photoUrl.isNotEmpty
//                       ? Image.network(
//                     userChat.photoUrl,
//                     fit: BoxFit.cover,
//                     width: 50,
//                     height: 50,
//                     loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
//                       if (loadingProgress == null) return child;
//                       return Container(
//                         width: 50,
//                         height: 50,
//                         child: Center(
//                           child: CircularProgressIndicator(
//                             color: AppColors.themeColor,
//                             value: loadingProgress.expectedTotalBytes != null
//                                 ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
//                                 : null,
//                           ),
//                         ),
//                       );
//                     },
//                     errorBuilder: (context, object, stackTrace) {
//                       return Icon(
//                         Icons.account_circle,
//                         size: 50,
//                         color: AppColors.greyColor,
//                       );
//                     },
//                   )
//                       : Icon(
//                     Icons.account_circle,
//                     size: 50,
//                     color: AppColors.greyColor,
//                   ),
//                   borderRadius: BorderRadius.all(Radius.circular(25)),
//                   clipBehavior: Clip.hardEdge,
//                 ),
//                 Flexible(
//                   child: Container(
//                     child: Column(
//                       children: <Widget>[
//                         Container(
//                           child: Text(
//                             'Nickname: ${userChat.nickname}',
//                             maxLines: 1,
//                             style: TextStyle(color: AppColors.primaryColor),
//                           ),
//                           alignment: Alignment.centerLeft,
//                           margin: EdgeInsets.fromLTRB(10, 0, 0, 5),
//                         ),
//                         Container(
//                           child: Text(
//                             'About me: ${userChat.aboutMe}',
//                             maxLines: 1,
//                             style: TextStyle(color: AppColors.primaryColor),
//                           ),
//                           alignment: Alignment.centerLeft,
//                           margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                         )
//                       ],
//                     ),
//                     margin: EdgeInsets.only(left: 20),
//                   ),
//                 ),
//               ],
//             ),
//             onPressed: () {
//               if (Utilities.isKeyboardShowing()) {
//                 Utilities.closeKeyboard(context);
//               }
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ChatPage(
//                     isImageSend: false,
//                     imageUrl: '',
//                     arguments: ChatPageArguments(
//                       peerId: userChat.id,
//                       peerAvatar: userChat.photoUrl,
//                       peerNickname: userChat.nickname,
//                     ),
//                   ),
//                 ),
//               );
//             },
//             style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all<Color>(AppColors.greyColor2),
//               shape: MaterialStateProperty.all<OutlinedBorder>(
//                 RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                 ),
//               ),
//             ),
//           ),
//           margin: EdgeInsets.only(bottom: 10, left: 5, right: 5),
//         );
//       }
//     } else {
//       return SizedBox.shrink();
//     }
//   }
// }
