import 'package:flutter/material.dart';

class SearchBarLocation extends StatelessWidget {
  SearchBarLocation({Key? key,required this.controller}) : super(key: key);
 final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black45),
            borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            children: [
              const Icon(
                Icons.location_on,
                size: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                    controller.text,
                  style: const TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
        ));
  }
}
