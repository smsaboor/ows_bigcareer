import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ows_bigcareer/view/chat/card_user.dart';
import 'package:ows_bigcareer/view/chat/custom_tab_bar.dart';
import 'package:ows_bigcareer/view/chat/loading_view.dart';
import 'package:ows_bigcareer/view_model/chat_view_model.dart';
import 'package:provider/provider.dart';

class ChatUsersStreamBuilder extends StatefulWidget {
  const ChatUsersStreamBuilder(
      {Key? key,
      required this.firebaseCollectionName,
      required this.userMobile,
      required this.listScrollController,
      required this.isLoading,
      required this.currentUserId})
      : super(key: key);
  final firebaseCollectionName, currentUserId, userMobile, listScrollController;
  final isLoading;

  @override
  State<ChatUsersStreamBuilder> createState() => _ChatUsersStreamBuilderState();
}

class _ChatUsersStreamBuilderState extends State<ChatUsersStreamBuilder> {
  late ChatViewModel homeProvider;
  final CustomTabBar _customTabBar = CustomTabBar();

  @override
  void initState() {
    // TODO: implement initState
    homeProvider = context.read<ChatViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('widget.firebaseCollectionName ${widget.firebaseCollectionName}');
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: homeProvider.getChats(
                widget.firebaseCollectionName, widget.currentUserId, 20, ''),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                if ((snapshot.data?.docs.length ?? 0) > 0) {
                  getExpenseItems(snapshot);
                  return ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      return CardUser(
                          userMobile: widget.userMobile,
                          isProject:
                              widget.firebaseCollectionName == 'MyProjects' ||
                                      widget.firebaseCollectionName ==
                                          'OthersProjects'
                                  ? true
                                  : false,
                          document: snapshot.data?.docs[index].id ?? 'null');
                    },
                    itemCount: snapshot.data?.docs.length,
                    controller: widget.listScrollController,
                  );
                } else {
                  return const Center(
                    child: Text("No users"),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.indigo,
                  ),
                );
              }
            },
          ),
        ),
        widget.isLoading ? LoadingView() : const SizedBox.shrink(),
      ],
    );
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    print('getExpenseItems called le ${snapshot.data!.docs.length}');
    for (int i = 0; i < snapshot.data!.docs.length; i++) {
      print('${snapshot.data?.docs[i].id}');
      snapshot.data!.docs.map((doc) {
        print('----${doc}');
      });
    }
  }
}
