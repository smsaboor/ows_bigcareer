// import 'package:flutter/material.dart';
// import 'package:flutter_package1/components.dart';
// import 'package:flutter_package1/package2/CustomFormField.dart';
// import 'package:flutter_package1/package2/date.dart';
// import 'package:flutter_package1/package2/select_dialog.dart';
// import 'package:ows_bigcareer/view/profile/add_certificate.dart';
// import 'package:ows_bigcareer/view/profile/add_digree.dart';
// import 'package:ows_bigcareer/view/screens/bottom_tabs/avtar_image_assets.dart';
//
// class EditProfile extends StatefulWidget {
//   const EditProfile({Key? key}) : super(key: key);
//
//   @override
//   State<EditProfile> createState() => _EditProfileState();
// }
//
// class _EditProfileState extends State<EditProfile> {
//   final TextEditingController _controllerName = TextEditingController();
//   final TextEditingController _controllerMobile = TextEditingController();
//   final TextEditingController _controllerEmail = TextEditingController();
//   final TextEditingController _controllerDateOfBirth = TextEditingController();
//   String? gender = 'Male';
//   var genderList = ['Male', 'Female', 'Others'];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        appBar: AppBar(title: const Text('Profile Details'),centerTitle: true,),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: MediaQuery.of(context).size.height * .05,
//             ),
//             const AvatarImageAssets(
//               'assets/user.png',
//               radius: 80,
//               height: 90,
//               width: 90,
//             ),
//             const Align(
//               alignment: Alignment.topLeft,
//               child: Padding(
//                 padding: EdgeInsets.only(left: 18.0, top: 15),
//                 child: Text(
//                   'Personal Info',
//                   style: TextStyle(
//                       color: Colors.black87, fontWeight: FontWeight.w500),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                   left: 30.0, right: 30, bottom: 10, top: 20),
//               child: SizedBox(
//                 height: 35,
//                 child: CustomFormField(
//                     maxLines: 1,
//                     maxLimit: 30,
//                     maxLimitError: '30',
//                     readOnly: false,
//                     controlller: _controllerName,
//                     errorMsg: 'Enter Your Name',
//                     labelText: 'Name',
//                     validator: (value) {},
//                     onChanged: (v) {},
//                     icon: Icons.person,
//                     textInputType: TextInputType.name),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                 left: 30.0,
//                 right: 30,
//                 bottom: 10,
//               ),
//               child: SizedBox(
//                 height: 35,
//                 child: CustomFormField(
//                     maxLimit: 10,
//                     maxLines: 1,
//                     maxLimitError: '10',
//                     readOnly: false,
//                     controlller: _controllerMobile,
//                     errorMsg: 'Enter Your Mobile',
//                     labelText: 'Mobile',
//                     validator: (value) {},
//                     onChanged: (v) {},
//                     icon: Icons.phone_android,
//                     textInputType: TextInputType.phone),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 10),
//               child: SizedBox(
//                 height: 35,
//                 child: CustomFormField(
//                     maxLines: 1,
//                     maxLimit: 50,
//                     maxLimitError: '50',
//                     readOnly: false,
//                     controlller: _controllerEmail,
//                     errorMsg: 'Enter Your Email',
//                     labelText: 'Email',
//                     validator: (value) {},
//                     onChanged: (v) {},
//                     icon: Icons.email_outlined,
//                     textInputType: TextInputType.emailAddress),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 10),
//               child: SizedBox(
//                 height: 35,
//                 child: CustomDate(
//                     controller: _controllerDateOfBirth,
//                     initialDate: DateTime(2000),
//                     firstDate: DateTime(1960),
//                     lastDate: DateTime(2010),
//                     validator: (value) {},
//                     labelText: 'Date of Birth (YYYY-MM-DD)'),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 10),
//               child: GenderDialog(
//                   onChanged: (gen) {
//                     if (mounted) {
//                       setState(() {
//                         gender = gen;
//                       });
//                     }
//                   },
//                   initialValue: gender,
//                   height: 35.0),
//             ),
//             Align(
//               alignment: Alignment.topLeft,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 18.0, top: 15,right: 10),
//                 child: Row(
//                   children: [
//                     const Text(
//                       'Education',
//                       style: TextStyle(
//                           color: Colors.black87, fontWeight: FontWeight.w500),
//                     ),
//                     const Spacer(),
//                     IconButton(
//                         onPressed: () {
//                           navigateTo(context, const AddEducation());
//                         },
//                         icon: const Icon(
//                           Icons.add_circle_outline_sharp,
//                           size: 20,
//                           color: Colors.indigo,
//                         ))
//                   ],
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.topLeft,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 18.0, top: 15,right: 10),
//                 child: Row(
//                   children: [
//                     const Text(
//                       'Certificates',
//                       style: TextStyle(
//                           color: Colors.black87, fontWeight: FontWeight.w500),
//                     ),
//                     const Spacer(),
//                     IconButton(
//                         onPressed: () {
//                           navigateTo(context, const AddCertificate());
//                         },
//                         icon: const Icon(
//                           Icons.add_circle_outline_sharp,
//                           size: 20,
//                           color: Colors.indigo,
//                         ))
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 50,)
//           ],
//         ),
//       ),
//     );
//   }
// }
