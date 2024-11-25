// import 'package:flutter/material.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
//
// class CallPage extends StatelessWidget {
//   const CallPage({Key? key, required this.callID}) : super(key: key);
//   final String callID;
//
//   @override
//   Widget build(BuildContext context) {
//     return ZegoUIKitPrebuiltCallWithInvitation(
//       appID: yourAppID,
//       serverSecret: yourServerSecret,
//       appSign: yourAppSign,
//       userID: userID,
//       userName: userName,
//       plugins: [ZegoUIKitSignalingPlugin()],
//       config: ZegoUIKitPrebuiltCallInvitationConfig(
//         /// For offline call notification
//         notifyWhenAppRunningInBackgroundOrQuit: true,
//         /// For publish your app to TestFlight or App Store if you support offline call
//         isIOSSandboxEnvironment: false,
//       ),
//       child: YourWidget(),
//     );
//   }
// }