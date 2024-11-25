import 'package:flutter/material.dart';

class MostSearchedKeyword extends StatelessWidget {
  const MostSearchedKeyword(
      {Key? key,
      required this.controllerSearchKeyword,
      required this.searchResult2})
      : super(key: key);
  final searchResult2;
  final controllerSearchKeyword;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 400,
      child: ListView.builder(
        itemCount: searchResult2.length,
        itemBuilder: (context, i) {
          return Card(
            margin: const EdgeInsets.all(0.0),
            child: ListTile(
              onTap: () {
                controllerSearchKeyword.text = searchResult2[i];
              },
              title: Text(searchResult2[i]),
            ),
          );
        },
      ),
    );
  }
}
