// import 'package:flutter/material.dart';
//
// class AddOtherDetails extends StatefulWidget {
//   const AddOtherDetails({Key? key}) : super(key: key);
//   @override
//   State<AddOtherDetails> createState() => _AddOtherDetailsState();
// }
//
// class _AddOtherDetailsState extends State<AddOtherDetails> {
//   String? digree = 'HighSchool';
//   var digreeList = [
//     'HighSchool',
//     'Intermediate',
//     'Graduation',
//     'PostGraduation'
//   ];
//   final TextEditingController _controllerInstitute = TextEditingController();
//   final GlobalKey<FormState> formkey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Other Details'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Form(
//           key: formkey,
//           child: Column(
//             children: [
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * .1,
//               ),
//               const Align(
//                 alignment: Alignment.topLeft,
//                 child: Padding(
//                   padding: EdgeInsets.only(top: 8.0, left: 8),
//                   child: Text(
//                     'Add Other details',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 17,
//                         color: Colors.black),
//                   ),
//                 ),
//               ),
//               buildTextFormField(
//                   _controllerInstitute,
//                   150,
//                   5,
//                   'e.g- height:156(c.m) , weight: 87(k.g)',
//                   1000,
//                   'Enter other details',
//                   'details must be less then 1000 character long ',
//                   20),
//
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 68.0),
//                   child: SizedBox(
//                       height: 45,
//                       width: MediaQuery.of(context).size.width * .9,
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(5)),
//                               backgroundColor: Colors.indigo),
//                           onPressed: () {
//                             _verifyUser(context);
//                           },
//                           child: const Text(
//                             'Submit',
//                             style: TextStyle(fontSize:17,color: Colors.white),
//                           ))),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _verifyUser(BuildContext context) async {
//     setState(() {});
//     if (formkey.currentState!.validate()) {
//       setState(() {
//       });
//       if (mounted) {
//         setState(() {
//         });
//       }
//     }
//   }
//
//   Widget buildTextFormField(TextEditingController controllerL, double heightL,
//       int maxLineL, hint, maxLine, String error1, String error2, int con1) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 8, bottom: 0, left: 8.0, right: 20),
//       child: SizedBox(
//         height: heightL,
//         child: Theme(
//           data: ThemeData(
//               primaryColor: Colors.redAccent,
//               primaryColorDark: Colors.red,
//               primarySwatch: Colors.indigo),
//           child: TextFormField(
//             textInputAction: TextInputAction.next,
//             maxLines: maxLineL,
//             controller: controllerL,
//             maxLength: maxLine,
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return error1;
//               } else {}
//               if (value!.length < con1) {
//                 return error2;
//               } else {}
//               return null;
//             },
//             onChanged: (v) {
//               setState(() {});
//             },
//             decoration: InputDecoration(
//               hintText: hint,
//               border: const OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.indigo)),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   BoxDecoration myBoxDecoration() {
//     return BoxDecoration(
//       border: Border.all(width: 1.0, color: Colors.black26),
//       borderRadius: const BorderRadius.all(
//           Radius.circular(5.0) //                 <--- border radius here
//       ),
//     );
//   }
// }
