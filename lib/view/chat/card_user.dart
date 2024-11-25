
import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:ows_bigcareer/view_model/chat_view_model.dart';
import 'models/models.dart';
import 'package:provider/provider.dart';
import 'utilities.dart';
import 'chat_page.dart';

class CardUser extends StatefulWidget {
  const CardUser(
      {Key? key, required this.document, required this.isProject,required this.userMobile})
      : super(key: key);
  final String document;
  final userMobile;
  final isProject;
  @override
  State<CardUser> createState() => _CardUserState();
}

class _CardUserState extends State<CardUser> {
  UserChat? userChat;
  late ChatViewModel homeProvider;

  getUserData() async {
    userChat = await homeProvider.getUserDetails(widget.document);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    homeProvider = context.read<ChatViewModel>();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return userChat == null
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.indigo,
            ),
          )
        : widget.document == userChat!.mobile
            ? Container(
                margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
                child: TextButton(
                  onPressed: () {
                    if (Utilities.isKeyboardShowing()) {
                      Utilities.closeKeyboard(context);
                    }
                    navigateTo(
                      context,
                      ChatPage(
                        message: '',
                        imageUrl: '',
                        isImageSend: false,
                        isFirstTime: false,
                        isProjectChat: widget.isProject,
                        userMobile: widget.userMobile,
                        arguments: ChatPageArguments(
                          peerId: userChat!.mobile,
                          peerAvatar: userChat!.image,
                          peerNickname: userChat!.name,
                        ),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Material(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        clipBehavior: Clip.hardEdge,
                        child: userChat!.image.isNotEmpty
                            ? Image.network(
                                userChat!.image,
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.indigo,
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (context, object, stackTrace) {
                                  return const Icon(
                                    Icons.account_circle,
                                    size: 50,
                                    color: Colors.indigo,
                                  );
                                },
                              )
                            : const Icon(
                                Icons.account_circle,
                                size: 50,
                                color: Colors.indigo,
                              ),
                      ),
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                                child: Text(
                                  userChat!.name,
                                  maxLines: 1,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text(
                                  'About me: ${userChat!.email}',
                                  maxLines: 1,
                                  style: const TextStyle(color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                height: 50,
                color: Colors.green,
              );
  }
}
