import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ows_bigcareer/view/app_widgets/fixedString.dart';
import 'package:flutter_package1/loading/loading1.dart';
class CommentCard extends StatefulWidget {
  const CommentCard({Key? key, required this.doc}) : super(key: key);
  final doc;

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool loading = false;
  var user;

  Future getUserDetails() async {
    setState(() {
      loading = true;
    });
    print('----getComments-----------');
    user = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.doc['mobile'])
        .get();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingWidget.rectangular(height: 65,width: MediaQuery.of(context).size.width,)
        : Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4, bottom: 2),
            child: Container(
              color: Colors.grey.shade200,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*.2,
                    height: 65,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black87, width: 1),
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(
                                      1, 1), // changes position of shadow
                                ),
                              ],
                              image: DecorationImage(
                                  image: NetworkImage(user['image']),
                                  fit: BoxFit.fitWidth),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*.75,
                    height: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              Text(
                                '${AppStrings.getFixedString(user['name'], user['name'].length, 15)}',
                                style: const TextStyle(fontWeight: FontWeight.w500,
                                fontSize: 14
                                ),
                              ),
                              SizedBox(width: 20,),
                              Text(
                                widget.doc['timestamp'].toString().substring(0,19),
                                style: const TextStyle(fontWeight: FontWeight.w300,fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width*.8,
                          child: Text(
                            '${AppStrings.getFixedString(widget.doc['message'], widget.doc['message'].length, 65)}',
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
