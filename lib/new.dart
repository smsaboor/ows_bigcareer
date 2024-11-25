// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class LoginScreen extends StatelessWidget {
//   final _phoneController = TextEditingController();
//   final _codeController = TextEditingController();
//
//   Future<bool?> loginUser(String phone, BuildContext context) async{
//     FirebaseAuth _auth = FirebaseAuth.instance;
//
//     _auth.verifyPhoneNumber(
//         phoneNumber: phone,
//         timeout: Duration(seconds: 60),
//         verificationCompleted: (AuthCredential credential) async{
//           Navigator.of(context).pop();
//           UserCredential result = await _auth.signInWithCredential(credential);
//           User? user = result.user;
//           if(user != null){
//             Navigator.push(context, MaterialPageRoute(
//                 builder: (context) => Container()
//             ));
//           }else{
//             print("Error");
//           }
//
//           //This callback would gets called when verification is done auto maticlly
//         },
//         verificationFailed: (FirebaseAuthException exception){
//           print(exception);
//         },
//         codeSent: (String verificationId, [int? forceResendingToken]){
//           showDialog(
//               context: context,
//               barrierDismissible: false,
//               builder: (context) {
//                 return AlertDialog(
//                   title: Text("Give the code?"),
//                   content: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       TextField(
//                         controller: _codeController,
//                       ),
//                     ],
//                   ),
//                   actions: <Widget>[
//                     ElevatedButton(
//                       child: Text("Confirm"),
//                       onPressed: () async{
//                         final code = _codeController.text.trim();
//                         AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);
//                         UserCredential result = await _auth.signInWithCredential(credential);
//                         User? user = result.user;
//                         if(user != null){
//                           Navigator.push(context, MaterialPageRoute(
//                               builder: (context) => HomeScreen(user: user,)
//                           ));
//                         }else{
//                           print("Error");
//                         }
//                       },
//                     )
//                   ],
//                 );
//               }
//           );
//         },
//         codeAutoRetrievalTimeout: (String verificationId){}
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.all(32),
//             child: Form(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text("Login", style: TextStyle(color: Colors.lightBlue, fontSize: 36, fontWeight: FontWeight.w500),),
//
//                   SizedBox(height: 16,),
//
//                   TextFormField(
//                     decoration: InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(8)),
//                             borderSide: BorderSide(color: Colors.grey[200]!)
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(8)),
//                             borderSide: BorderSide(color: Colors.grey[300]!)
//                         ),
//                         filled: true,
//                         fillColor: Colors.grey[100],
//                         hintText: "Mobile Number"
//
//                     ),
//                     controller: _phoneController,
//                   ),
//
//                   SizedBox(height: 16,),
//
//
//                   Container(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       child: Text("LOGIN"),
//                       onPressed: () {
//                         final phone = _phoneController.text.trim();
//                         loginUser(phone, context);
//                       },
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         )
//     );
//   }
// }
//
//
// class HomeScreen extends StatelessWidget {
//
//   final User? user;
//
//   HomeScreen({this.user});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: EdgeInsets.all(32),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text("You are Logged in succesfully", style: TextStyle(color: Colors.lightBlue, fontSize: 32),),
//             SizedBox(height: 16,),
//             Text("${user!.phoneNumber}", style: TextStyle(color: Colors.grey, ),),
//           ],
//         ),
//       ),
//     );
//   }
// }