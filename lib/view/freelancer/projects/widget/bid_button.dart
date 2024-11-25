import 'package:flutter/material.dart';
import 'package:flutter_package1/components.dart';
import 'package:ows_bigcareer/view/chat/chat_page.dart';
import 'package:ows_bigcareer/view/chat/models/models.dart';
import 'package:ows_bigcareer/view_model/chat_view_model.dart';
import 'package:provider/provider.dart';

class BidButton extends StatefulWidget {
  const BidButton({Key? key, required this.userMobile, required this.projects})
      : super(key: key);
  final userMobile;
  final projects;

  @override
  State<BidButton> createState() => _BidButtonState();
}

class _BidButtonState extends State<BidButton> {
  late ChatViewModel chatViewModel;
  final TextEditingController controllerBidAmount = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double heightTextFormField = 45;

  @override
  void initState() {
    chatViewModel = context.read<ChatViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18),
      child: SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.width * .9,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(5)),
                  backgroundColor: Colors.indigo),
              onPressed: () async {
                print(
                    '---widget.userMobile${widget.userMobile}---------------projects.userId${widget.projects.userId}');
                if (widget.userMobile == widget.projects.userId) {
                  showToast(msg: "You can't bed on your own project");
                } else {
                  UserChat? user = await chatViewModel
                      .getUserDetails(widget.projects.userId!);
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: Text(
                              'Enter Your Bid Amount in ${widget.projects.currency} / ${widget.projects.paymentMode}',
                          style: TextStyle(fontSize: 12),
                          ),
                          content: SizedBox(
                            height: 120,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: heightTextFormField,
                                    width: 200,
                                    child: TextFormField(
                                      controller: controllerBidAmount,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.indigo))),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'please enter amount';
                                        } else {}
                                        if (value!.length < 3) {
                                          return 'not less then 100';
                                        } else {}
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, right: 5),
                                    child: SizedBox(
                                        height: 30,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .9,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    side: const BorderSide(
                                                        color: Colors.white),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                backgroundColor: Colors.indigo),
                                            onPressed: () {
                                              setState(() {
                                                heightTextFormField = 80;
                                              });
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                setState(() {
                                                  heightTextFormField = 40;
                                                });
                                                Navigator.pop(context);
                                                navigateTo(
                                                    context,
                                                    ChatPage(
                                                      message:
                                                          "Hello Mr. ${user.name}, My Bid for your project ${widget.projects.title} is ${controllerBidAmount.text} ${widget.projects.currency} / ${widget.projects.paymentMode}",
                                                      userMobile:
                                                          widget.userMobile,
                                                      isImageSend: false,
                                                      isProjectChat: true,
                                                      imageUrl: '',
                                                      isFirstTime: true,
                                                      arguments:
                                                          ChatPageArguments(
                                                        peerId: user!.mobile,
                                                        peerAvatar: user!.image,
                                                        peerNickname:
                                                            user!.email,
                                                      ),
                                                    ));
                                              }
                                            },
                                            child: const Center(
                                              child: Text(
                                                'Start chat',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              ),
                                            ))),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // actions: <Widget>[
                          //   IconButton(
                          //       onPressed: () {
                          //         Navigator.pop(context);
                          //       },
                          //       icon: const Icon(Icons.clear))
                          // ],
                        );
                      });
                }
              },
              child: const Center(
                child: Text(
                  'Bid',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ))),
    );
  }
}
