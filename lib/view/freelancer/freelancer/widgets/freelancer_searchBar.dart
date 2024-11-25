import 'package:flutter/material.dart';

class FreelancerSearchBar extends StatefulWidget {
  const FreelancerSearchBar(
      {Key? key,
      required this.title,
      required this.controller,
      required this.onSubmitted})
      : super(key: key);
  final controller, onSubmitted, title;

  @override
  State<FreelancerSearchBar> createState() => _FreelancerSearchBarState();
}

class _FreelancerSearchBarState extends State<FreelancerSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                // color: Theme.of(context).accentColor.withAlpha(50),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: TextField(
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey,
                  ),
                  controller: widget.controller,
                  onChanged: (value) {},
                  onSubmitted: widget.onSubmitted,
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
                    hintText: widget.title,
                    contentPadding: const EdgeInsets.only(
                      left: 10,
                      right: 20,
                      top: 5,
                      bottom: 5,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
