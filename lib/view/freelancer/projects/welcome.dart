import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:ows_bigcareer/view/bottom_tabs/bottom_nav_bar.dart';
import 'package:ows_bigcareer/view_model/sharedpreferences_view_model.dart';
import 'package:provider/provider.dart';


class WelcomeCreator extends StatefulWidget {
  const WelcomeCreator({Key? key, required this.appBar}) : super(key: key);
  final appBar;
  @override
  State<WelcomeCreator> createState() => _WelcomeCreatorState();
}

class _WelcomeCreatorState extends State<WelcomeCreator> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: widget.appBar?AppBar(title: const Text('Freelancer'),centerTitle: true,
      leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
        Navigator.pop(context);
      },),
      ):null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 5, bottom: 5, top:35),
              child: SizedBox(
                  height: MediaQuery.of(context).size.width * .17,
                  width: size.width * .58,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: Colors.indigo),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(5)),
                          backgroundColor: Colors.white),
                      onPressed: () {
                      },
                      child: const Text(
                        'Freelancers',
                        style: TextStyle(color: Colors.indigo,fontSize: 18),
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 5, bottom: 5, top:35),
              child: SizedBox(
                  height: MediaQuery.of(context).size.width * .17,
                  width: size.width * .58,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          side: const BorderSide(color: Colors.indigo),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(5)),
                          backgroundColor: Colors.white),
                      onPressed: () {
                      },
                      child: const Text(
                        'Projects',
                        style: TextStyle(color: Colors.indigo,fontSize: 18),
                      ))),
            ),
            const SizedBox(height: 50,),
            Center(
              child: GestureDetector(
                onTap: (){
                  var sharedPreferencesVM =
                      Provider.of<SharedPreferencesVM>(context, listen: false);
                  sharedPreferencesVM.setFreelancerLoginStatus(false);
                  navigateAndFinsh(context, BigCareerBottomNavBar());
                },
                child: const Text('freelancer Logout'),),
            )
          ],
        ),
      ),
    );
  }
}
