import 'package:flutter/material.dart';
import 'package:ows_bigcareer/model/apis/api_response.dart';

class CustomWidgetDataList extends StatelessWidget {
  const CustomWidgetDataList(
      {Key? key,
      required this.apiResponse,
      required this.dynamicWidget,
      required this.title})
      : super(key: key);
  final ApiResponseFreelancer apiResponse;
  final Widget dynamicWidget;
  final String title;

  @override
  Widget build(BuildContext context) {
    List<dynamic>? dynamicDataList = apiResponse.data as List<dynamic>?;
    switch (apiResponse.status) {
      case Status.LOADING:
        return const Center(child: CircularProgressIndicator());
      case Status.COMPLETED:
        return dynamicWidget;
      case Status.ERROR:
        return const Center(
          child: Text('Please try again latter!!!'),
        );
      case Status.INITIAL:
      default:
        return Center(
          child: Text('Search the $title'),
        );
    }
  }
}
