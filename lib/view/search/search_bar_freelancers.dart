import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';

class SearchBarFreelancer extends StatelessWidget {
  const SearchBarFreelancer(
      {Key? key, required this.onSubmited, required this.onTap, required this.controller, required this.onChanged})
      : super(key: key);
  final TextEditingController controller;
  final onSubmited;
  final onChanged,onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      margin: const EdgeInsets.only(bottom: 5),
      child: TextField(
          controller: controller,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          onChanged: onChanged,
          onSubmitted: onSubmited,
          onTap: onTap,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black54,
                ),
                borderRadius: BorderRadius.circular(30)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black54,
                ),
                borderRadius: BorderRadius.circular(30)),
            prefixIcon: const Icon(
              Icons.search,
              size: 20,
              color: Colors.black,
            ),
            border: InputBorder.none,
            // prefixIconColor: Colors.blue,
            // prefixStyle: const TextStyle(fontWeight: FontWeight.w600),
            hintText: 'Search Freelancers ',
            contentPadding: const EdgeInsets.only(
              left: 10,
              right: 20,
              top: 5,
              bottom: 5,
            ),
          )),
    );
  }
}
