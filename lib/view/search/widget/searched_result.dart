// import 'package:flutter/material.dart';
// import 'package:flutter_package1/components.dart';
// import 'package:ows_bigcareer/view/search/search_filter.dart';
// import 'package:ows_bigcareer/view/search/search_job.dart';
//
// class SearchedResult extends StatefulWidget {
//   const SearchedResult(
//       {Key? key, required this.searchResult, required this.onSearchKeywordChanged,required this.location})
//       : super(key: key);
//   final List<UserDetails> searchResult;
//   final onSearchKeywordChanged;
//   final location;
//
//   @override
//   State<SearchedResult> createState() => _SearchedResultState();
// }
//
// class _SearchedResultState extends State<SearchedResult> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 500,
//       width: 400,
//       child: ListView.builder(
//         itemCount: widget.searchResult.length,
//         itemBuilder: (context, i) {
//           return Card(
//             margin: const EdgeInsets.all(0.0),
//             child: ListTile(
//               onTap: () {
//                 setState(() {
//                   widget.onSearchKeywordChanged!(widget.searchResult[i].firstName!);
//                   navigateTo(
//                       context,
//                     JobFilterBar(
//                       searchText: widget.searchResult[i].firstName!,
//                       searchLocation: widget.location,
//                     ),
//                       );
//                 });
//               },
//               title: Text('${widget.searchResult[i].firstName!}'),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
