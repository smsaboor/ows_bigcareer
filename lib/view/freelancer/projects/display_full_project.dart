import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';

class DisplayProject extends StatefulWidget {
  const DisplayProject(
      {Key? key, required this.projects, required this.userMobile})
      : super(key: key);
  final projects;
  final userMobile;

  @override
  State<DisplayProject> createState() => _DisplayProjectState();
}

class _DisplayProjectState extends State<DisplayProject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .95,
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  color: Colors.white,
                  elevation: 2,
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0, top: 30),
                            child: Column(
                              children: const [
                                Text(
                                  'Project Budget',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 18.0, top: 10),
                              child: Column(
                                children: [
                                  Text(
                                    '${widget.projects.amount} ${widget.projects.currency} / ${widget.projects.paymentMode}',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0, top: 10),
                            child: Column(
                              children: const [
                                Text(
                                  'Project Title',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 18.0, top: 10),
                              child: Column(
                                children: [
                                  Text(
                                    '${widget.projects.title}',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0, top: 10),
                            child: Column(
                              children: const [
                                Text(
                                  'Project Details',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 60,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, right: 10, left: 18),
                              child: Text(
                                '${widget.projects.details}',
                                maxLines: 3,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0, top: 10),
                            child: Column(
                              children: const [
                                Text(
                                  'Last Bid',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 18.0, top: 4.0, right: 79),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.projects.amount} ${widget.projects.currency} / ${widget.projects.paymentMode}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0, top: 10),
                            child: Column(
                              children: const [
                                Text(
                                  'Skills for project completion',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 18.0, top: 3.0, right: 0),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * .50,
                                  child: Text(
                                    '${widget.projects.skills}',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 18.0, top: 10, bottom: 10),
                          child: Column(
                            children: const [
                              Text(
                                'Project Images',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 18),
                        child: Row(
                          children: [
                            buildImage(widget.projects.image1, 'Image 1'),
                            Spacer(),
                            buildImage(widget.projects.image2, 'Image 2'),
                            Spacer(),
                            buildImage(widget.projects.image3, 'Image 3'),
                          ],
                        ),
                      ),
                      SizedBox(height: 40,),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 18),
                        child: SizedBox(
                            height: 35,
                            width: MediaQuery.of(context).size.width * .9,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: Colors.white),
                                        borderRadius: BorderRadius.circular(5)),
                                    backgroundColor: Colors.indigo),
                                onPressed: () {
                                  print(
                                      '---widget.userMobile${widget.userMobile}---------------projects.userId${widget.projects.userId}');
                                  if (widget.userMobile == widget.projects.userId) {
                                    showToast(
                                        msg:
                                            "You can't bet on your own project");
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            title: const Text('Enter Your Bid'),
                                            content: SizedBox(
                                              height: 100,
                                              child: Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 60,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5.0,
                                                            right: 5),
                                                    child: SizedBox(
                                                        height: 30,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .9,
                                                        child: ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                    side: const BorderSide(
                                                                        color: Colors
                                                                            .white),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                backgroundColor:
                                                                    Colors
                                                                        .indigo),
                                                            onPressed: () {},
                                                            child: const Center(
                                                              child: Text(
                                                                'Start chat',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              IconButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(Icons.clear))
                                            ],
                                          );
                                        });
                                  }
                                },
                                child: const Center(
                                  child: Text(
                                    'Bid',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ))),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String image, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(title),
                content: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .6,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/loading.gif',
                      image: image ?? '',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.clear))
                ],
              );
            });
      },
      child: Container(
        width: MediaQuery.of(context).size.width*.25,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/loading.gif',
            image: image ?? '',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
