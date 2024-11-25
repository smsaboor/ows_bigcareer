// import 'package:flutter/material.dart';
// import 'package:flutter_package1/components.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:ows_bigcareer/core/constants/freelancers.dart';
// import 'package:ows_bigcareer/model/firebase/firebase_service.dart';
// import 'package:ows_bigcareer/model/models/model_freelancers.dart';
// import 'package:ows_bigcareer/view/freelancer/freelancer/hire_freelancer.dart';
// import 'package:ows_bigcareer/view/search/search_bar_freelancers.dart';
// import 'package:ows_bigcareer/view_model/sharedpreferences_view_model.dart';
// import 'freelancer_profile.dart';
// import 'package:provider/provider.dart';
//
// class Freelancer extends StatefulWidget {
//   const Freelancer({Key? key, required this.userMobile}) : super(key: key);
//   final userMobile;
//
//   @override
//   State<Freelancer> createState() => _FreelancerState();
// }
//
// class _FreelancerState extends State<Freelancer> {
//   late final _ratingController;
//   late double _rating;
//   static String? mobile;
//   FirebaseService firebaseServices = FirebaseService();
//   double _initialRating = 2.0;
//   IconData? _selectedIcon;
//   bool viewFilter = false;
//   List<ModelFreelancers>? freelancersList;
//
//   final TextEditingController _controllerSearchKeyword =
//       TextEditingController();
//
//   getUserDetails() async {
//     var sharedPreferencesVM =
//         Provider.of<SharedPreferencesVM>(context, listen: false);
//     var appUser = await sharedPreferencesVM.getUserDetails();
//     setState(() {
//       mobile = appUser.mobile;
//     });
//     getFreelancersList();
//   }
//
//   getFreelancersList() {
//     freelancersList =
//         freelancersJson.map((i) => ModelFreelancers.fromJson(i)).toList();
//     print('freelancersList length${freelancersList!.length}');
//   }
//   Future<bool> checkLiked(){
//     bool value=true;
//     return Future.delayed(Duration(seconds: 1),()=>value);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getUserDetails();
//     _ratingController = TextEditingController(text: '3.0');
//     _rating = _initialRating;
//   }
//
//   onTapSearchKeywords() async {
//     if (_controllerSearchKeyword.text.isEmpty) {
//       setState(() {
//         viewFilter = false;
//       });
//       setState(() {});
//     }
//   }
//
//   onSearchTextChanged(String text) async {
//     if (text.isEmpty) {
//       setState(() {
//         viewFilter = false;
//       });
//       return;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: const Text(
//           'Freelancers',
//           style: TextStyle(color: Colors.indigo),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 10,
//             ),
//             SizedBox(
//                 height: 50,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 15.0, right: 15),
//                   child: SearchBarFreelancer(
//                       controller: _controllerSearchKeyword,
//                       onSubmited: (val) {
//                         _controllerSearchKeyword.text = val.toString();
//                         setState(() {
//                           viewFilter = true;
//                         });
//                       },
//                       onTap: onTapSearchKeywords,
//                       onChanged: onSearchTextChanged),
//                 )),
//             const SizedBox(
//               height: 20,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 18.0),
//               child: Container(
//                 height: 35,
//                 color: Colors.white,
//                 width: double.infinity,
//                 child: const Text(
//                   'Top results',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                 ),
//               ),
//             ),
//             Container(height: 1, color: Colors.grey, width: double.infinity),
//             ListView.builder(
//                 scrollDirection: Axis.vertical,
//                 shrinkWrap: true,
//                 physics: const ScrollPhysics(),
//                 itemCount: freelancersList!.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       navigateTo(
//                           context,
//                           FreelancerProfile(
//                             mobile: mobile,
//                             freelancer: freelancersList![index],
//                           ));
//                     },
//                     child: Center(
//                       child: SizedBox(
//                         height: 320,
//                         width: MediaQuery.of(context).size.width,
//                         child: Card(
//                           shape: const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.only(
//                               topRight: Radius.circular(0),
//                               topLeft: Radius.circular(0),
//                               bottomLeft: Radius.circular(0),
//                               bottomRight: Radius.circular(0),
//                             ),
//                           ),
//                           color: Colors.white,
//                           elevation: 1,
//                           child: Column(
//                             children: [
//                               SizedBox(
//                                 height: 260,
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Align(
//                                       alignment: Alignment.bottomLeft,
//                                       child: Container(
//                                         color: Colors.white38,
//                                         width: double.infinity,
//                                         height: 80,
//                                         child: Row(
//                                           children: [
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 8.0),
//                                               child: Container(
//                                                 height: 60,
//                                                 width: 60,
//                                                 child: Image.network(
//                                                   '${freelancersList![index].image}',
//                                                   fit: BoxFit.fitWidth,
//                                                 ),
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   top: 8.0, left: 8, right: 8),
//                                               child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.start,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             left: 18.0),
//                                                     child: Text(
//                                                       '${freelancersList![index].name}',
//                                                       style: const TextStyle(
//                                                           fontSize: 14,
//                                                           fontWeight:
//                                                               FontWeight.w600),
//                                                     ),
//                                                   ),
//                                                   const SizedBox(
//                                                     height: 3,
//                                                   ),
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             left: 18.0),
//                                                     child: Row(
//                                                       children: const [
//                                                         Icon(
//                                                           Icons.star,
//                                                           color: Colors.amber,
//                                                           size: 16,
//                                                         ),
//                                                         Text(
//                                                           '5.0',
//                                                           style: TextStyle(
//                                                               fontSize: 11,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w600),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   const SizedBox(
//                                                     height: 3,
//                                                   ),
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             left: 18.0),
//                                                     child: Text(
//                                                       '${freelancersList![index].country}',
//                                                       style: const TextStyle(
//                                                           fontSize: 14,
//                                                           fontWeight:
//                                                               FontWeight.w600),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             const Spacer(),
//                                             SizedBox(
//                                               child: IconButton(
//                                                   onPressed: () {
//                                                     firebaseServices
//                                                         .addFreelancers(
//                                                             mobile!,
//                                                             freelancersList![
//                                                                 index]);
//                                                     showToast(
//                                                         msg:
//                                                             'Like Button Clicked');
//                                                   },
//                                                   icon:const Icon(
//                                                     Icons.favorite_border,
//                                                   )),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 30,
//                                       child: Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 18.0, top: 10),
//                                         child: Row(
//                                           children: [
//                                             // Text(
//                                             //   '${freelancersList![index].currencySymbol}${freelancersList![index].cost} ${freelancersList![index].currencyName}',
//                                             //   style: const TextStyle(
//                                             //       fontSize: 15,
//                                             //       fontWeight: FontWeight.w600,
//                                             //       color: Colors.black),
//                                             // ),
//                                             Text(
//                                               '  ${freelancersList![index].paymentMode}',
//                                               style: const TextStyle(
//                                                   fontSize: 11,
//                                                   fontWeight: FontWeight.w400,
//                                                   color: Colors.black),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 40,
//                                       child: Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 18.0, top: 10),
//                                         child: Column(
//                                           children: [
//                                             Text(
//                                               '${freelancersList![index].title}',
//                                               style: const TextStyle(
//                                                   fontSize: 15,
//                                                   fontWeight: FontWeight.w600,
//                                                   color: Colors.black),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 50,
//                                       child: Padding(
//                                         padding: const EdgeInsets.only(
//                                             top: 0, right: 10, left: 18),
//                                         child: Text(
//                                           '${freelancersList![index].about}',
//                                           maxLines: 3,
//                                           style: const TextStyle(
//                                               fontSize: 12,
//                                               color: Colors.black),
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           left: 18.0, top: 3.0, right: 0),
//                                       child: Row(
//                                         children: [
//                                           SizedBox(
//                                             height: 50,
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 .29,
//                                             child: const Text(
//                                               'Skills',
//                                               style: TextStyle(
//                                                   fontSize: 15,
//                                                   fontWeight: FontWeight.w600,
//                                                   color: Colors.redAccent),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: 50,
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 .50,
//                                             child: Text(
//                                               '${freelancersList![index].skills}',
//                                               style: const TextStyle(
//                                                   fontSize: 14,
//                                                   color: Colors.black,
//                                                   fontWeight: FontWeight.w500),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                   height: 35,
//                                   width: MediaQuery.of(context).size.width * .9,
//                                   child: ElevatedButton(
//                                       style: ElevatedButton.styleFrom(
//                                           shape: RoundedRectangleBorder(
//                                               side: BorderSide(
//                                                   color: Colors.white),
//                                               borderRadius:
//                                                   BorderRadius.circular(5)),
//                                           backgroundColor: Colors.indigo),
//                                       onPressed: () {
//                                         navigateTo(
//                                             context,
//                                             HireFreelancer(
//                                               freelancer:
//                                                   freelancersList![index],
//                                             ));
//                                       },
//                                       child: const Center(
//                                         child: Text(
//                                           'Hire',
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 12),
//                                         ),
//                                       ))),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _ratingBar() {
//     return RatingBar.builder(
//       initialRating: _initialRating,
//       minRating: 1,
//       direction: Axis.horizontal,
//       allowHalfRating: true,
//       unratedColor: Colors.black.withAlpha(50),
//       itemCount: 5,
//       itemSize: 20.0,
//       itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
//       itemBuilder: (context, _) => Icon(
//         _selectedIcon ?? Icons.star,
//         color: Colors.amber,
//       ),
//       onRatingUpdate: (rating) {
//         setState(() {
//           _rating = rating;
//         });
//       },
//       updateOnDrag: true,
//     );
//   }
// }
