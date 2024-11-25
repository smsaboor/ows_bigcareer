import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:ows_bigcareer/view/freelancer/freelancer/freelancer.dart';
import 'package:ows_bigcareer/view/freelancer/projects/home_screen_projects.dart';
import 'projects/project.dart';
import 'freelancer/freelancer_static.dart';

class FreelancerTab extends StatefulWidget {
  const FreelancerTab(
      {Key? key, required this.appBar, required this.userMobile})
      : super(key: key);
  final appBar, userMobile;

  @override
  State<FreelancerTab> createState() => _FreelancerTabState();
}

class _FreelancerTabState extends State<FreelancerTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar
          ? AppBar(
              title: const Text('Freelancer'),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          : null,
      body: getFreelancerHome(),
    );
  }

  Widget getFreelancerHome() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Browse for freelancers or projects',
            style: TextStyle(color: Colors.black, fontSize: 12),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 5, bottom: 0, top: 35),
            child: SizedBox(
                height: MediaQuery.of(context).size.width * .17,
                width: MediaQuery.of(context).size.width * .7,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Colors.indigo),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor: Colors.white),
                    onPressed: () {
                      navigateTo(context, Freelancers(userMobile:widget.userMobile));
                      // navigateTo(context, Freelancer(userMobile:widget.userMobile,));
                    },
                    child: const Text(
                      'Freelancers',
                      style: TextStyle(color: Colors.indigo, fontSize: 18),
                    ))),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 5, bottom: 5, top: 15),
            child: SizedBox(
                height: MediaQuery.of(context).size.width * .17,
                width: MediaQuery.of(context).size.width * .7,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Colors.indigo),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor: Colors.white),
                    onPressed: () {
                      navigateTo(context, HomeScreenProjects(userMobile:widget.userMobile));
                      // navigateTo(context, Projects(userMobile: widget.userMobile,));
                    },
                    child: const Text(
                      'Projects',
                      style: TextStyle(color: Colors.indigo, fontSize: 18),
                    ))),
          ),
        ],
      ),
    );
  }
}
