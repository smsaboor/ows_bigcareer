import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ows_bigcareer/model/firebase/firebase_service.dart';
import 'package:ows_bigcareer/model/models/model_app_user.dart';
import 'package:ows_bigcareer/model/models/model_jobs_final.dart';
import 'package:ows_bigcareer/view_model/sharedpreferences_view_model.dart';
import 'comment_card.dart';
import 'package:provider/provider.dart';
import 'package:ows_bigcareer/view/app_widgets/fixedString.dart';

class CommentsHome extends StatefulWidget {
  const CommentsHome({super.key, required this.userMobile, required this.job});

  final userMobile;
  final ModelJobsFinal job;

  @override
  State<CommentsHome> createState() => _CommentsHomeState();
}

class _CommentsHomeState extends State<CommentsHome> {
  bool data = true;
  bool loading = false;
  late Future<QuerySnapshot> commentList;
  FirebaseService firebaseService = FirebaseService();
  final TextEditingController controller = TextEditingController();

  AppUser? appUser;
  int totalCommentsOnJob = 0;

  Future<void> getUserDetails() async {
    var sharedPreferencesVM =
        Provider.of<SharedPreferencesVM>(context, listen: false);
    appUser = await sharedPreferencesVM.getUserDetails();
    print('-----getUserDetails-------------------${appUser}');
  }

  Future<QuerySnapshot> getComments() async {
    print('----getComments-----------${widget.userMobile}');
    commentList = FirebaseFirestore.instance
        .collection('allComments')
        .doc(widget.job.jobId)
        .collection(widget.job.jobId!)
        .orderBy('timestamp')
        .get();
    return commentList;
  }

  getTotalCommentsOnJob() async {
    totalCommentsOnJob =
        await firebaseService.totalCommentsOnJob(widget.job.jobId!);
    setState(() {});
  }

  Future addComment() async {
    print('----addComment-----------${widget.userMobile}');
    setState(() {
      loading = true;
    });
    if (appUser!.mobile.isNotEmpty) {
      print('----addComment-----------111');
      String time = DateTime.now().toString();
      Map<String, dynamic> body = {
        "message": controller.text.toString(),
        "timestamp": time,
        "mobile": widget.userMobile
      };
      FirebaseFirestore.instance
          .collection('allComments')
          .doc(widget.job.jobId!)
          .collection(widget.job.jobId!)
          .doc()
          .set(body);
      int total = totalCommentsOnJob + 1;
      FirebaseFirestore.instance
          .collection('totalCommentsOnJob')
          .doc(widget.job.jobId!)
          .update({"total": total.toString()});
      getTotalCommentsOnJob();
      setState(() {
        loading = false;
        controller.clear();
      });
    } else {
      print('----addComment-----------222');
      setState(() {
        loading = false;
        controller.clear();
      });
    }
  }

  @override
  void initState() {
    controller.text = ' ';
    getTotalCommentsOnJob();
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Comments'),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Row(
          children: [
            Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black87,width: .3)),
                child: Row(
                  children: [
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width*.8,
                      child: TextFormField(
                        controller: controller,
                        onFieldSubmitted: (v){
                          addComment();
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.message),
                            hintText: ' Enter your comment'),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * .18,
                        child: GestureDetector(
                            onTap: () {
                              addComment();
                            },
                            child: SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width * .18,
                              child: const Icon(Icons.send),
                            )))
                  ],
                )),
          ],
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: getComments(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(backgroundColor: Colors.blue),
              );
            }
            if (snapshot.hasData) {
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              return snapshot.data!.docs.isEmpty
                  ? const Center(child: Text('No Data Found'))
                  : SingleChildScrollView(
                    child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              NetworkImage(widget.job.companyLogo!
                                              ))
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Text('${AppStrings.getFixedString(widget.job.jobTitle.toString(), widget.job.jobTitle.toString().length, 35)}  ...',
                                )
                              ],
                            ),
                          ),
                          ListView(
                              reverse: true,
                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: documents
                                  .map((doc) => GestureDetector(
                                      onTap: () {},
                                      child: CommentCard(
                                        doc: doc,
                                      )))
                                  .toList()),
                        ],
                      ),
                  );
            }
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
  Widget buildInput() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
          color: Colors.white),
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1),
              child: Icon(Icons.face)
            ),
          ),

          // Edit text
          Flexible(
            child: TextField(
              onSubmitted: (value) {
                addComment();
              },
              style: const TextStyle(color: Colors.indigo, fontSize: 15),
              controller: controller,
              decoration: const InputDecoration.collapsed(
                hintText: 'Type your message...',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
              autofocus: false,
            ),
          ),
          // Button send message
          Material(
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: (){
                  addComment();
                },
                color: Colors.indigo,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
