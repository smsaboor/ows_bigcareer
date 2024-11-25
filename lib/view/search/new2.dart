// import 'package:flutter/material.dart';
//
// class FindS extends StatelessWidget {
//    FindS({Key? key}) : super(key: key);
//
//
//   String? search;
//
//   TextStyle positiveColorStyle = TextStyle(color: Colors.blue),
//       TextStyle negativeColorStyle = TextStyle(color: Colors.black);
//
//
//   TextSpan searchMatch(String match) {
//     if (search == null || search == "")
//       return TextSpan(text: match, style: negativeColorStyle);
//     var refinedMatch = match.toLowerCase();
//     var refinedSearch = search!.toLowerCase();
//     if (refinedMatch.contains(refinedSearch)) {
//       if (refinedMatch.substring(0, refinedSearch.length) == refinedSearch) {
//         return TextSpan(
//           style: posRes,
//           text: match.substring(0, refinedSearch.length),
//           children: [
//             searchMatch(
//               match.substring(
//                 refinedSearch.length,
//               ),
//             ),
//           ],
//         );
//       } else if (refinedMatch.length == refinedSearch.length) {
//         return TextSpan(text: match, style: positiveColorStyle);
//       } else {
//         return TextSpan(
//           style: negativeColorStyle,
//           text: match.substring(
//             0,
//             refinedMatch.indexOf(refinedSearch),
//           ),
//           children: [
//             searchMatch(
//               match.substring(
//                 refinedMatch.indexOf(refinedSearch),
//               ),
//             ),
//           ],
//         );
//       }
//     } else if (!refinedMatch.contains(refinedSearch)) {
//       return TextSpan(text: match, style: negativeColorStyle);
//     }
//     return TextSpan(
//       text: match.substring(0, refinedMatch.indexOf(refinedSearch)),
//       style: negativeColorStyle,
//       children: [
//         searchMatch(match.substring(refinedMatch.indexOf(refinedSearch)))
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
