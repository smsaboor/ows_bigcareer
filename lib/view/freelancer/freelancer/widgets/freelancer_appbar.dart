import 'package:flutter/material.dart';


class FreelancerAppBar extends StatelessWidget {
  const FreelancerAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        'Freelancers',
        style: TextStyle(color: Colors.indigo),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }
}
