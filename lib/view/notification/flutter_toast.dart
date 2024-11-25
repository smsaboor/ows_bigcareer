import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/src/toast_widget/loading.dart';

import 'package:flutter/cupertino.dart';
class EnterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("BotToast"),
          centerTitle: true,
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              child: Column(children: <Widget>[
                const Text(
                  "Notification",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                const Divider(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SimpleNotification()));
                          },
                          child: const Text("SimpleNotification"),
                        ),
                      ),
                    ),
                  ],
                )
              ]),
            ),
          ),
        ));
  }
}


class All extends StatefulWidget {
  @override
  _AllState createState() => _AllState();
}

class _AllState extends State<All> {
  @override
  void initState() {
    BotToast.showLoading(duration: const Duration(seconds: 2));
    BotToast.showSimpleNotification(title: "init");
    BotToast.showText(text: "init");
    BotToast.showAttachedWidget(
        attachedBuilder: (_) => const Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.favorite,
              color: Colors.redAccent,
            ),
          ),
        ),
        enableSafeArea: false,
        duration: const Duration(seconds: 2),
        target: const Offset(52, 0));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All"),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Divider(),
              const Text("code"),
              const Divider(),
              Text(
                _code,
                textAlign: TextAlign.start,
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

String _code = '''
  @override
  void initState() {
    BotToast.showLoading(duration: Duration(seconds: 2));
    BotToast.showSimpleNotification(title: "init");
    BotToast.showText(text: "init");
    BotToast.showAttachedWidget(
        attachedWidget: (_) => Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.favorite,
                  color: Colors.redAccent,
                ),
              ),
            ),
        duration: Duration(seconds: 2),
        target: Offset(520, 520));
    super.initState();
  }
''';




class SimpleNotification extends StatefulWidget {
  @override
  _SimpleNotificationState createState() => _SimpleNotificationState();
}

class _SimpleNotificationState extends State<SimpleNotification> {
  bool enableSlideOff = true;
  bool hideCloseButton = false;
  bool onlyOne = true;
  bool crossPage = true;
  int seconds = 2;
  int animationMilliseconds = 200;
  int animationReverseMilliseconds = 200;
  BackButtonBehavior backButtonBehavior = BackButtonBehavior.none;

  @override
  void initState() {
    BotToast.showSimpleNotification(
        title: "Notification title",
        subTitle: "Notification subtitle",
        enableSlideOff: enableSlideOff,
        hideCloseButton: hideCloseButton,
        onTap: () {
          BotToast.showText(text: 'Tap toast');
        },
        onLongPress: () {
          BotToast.showText(text: 'Long press toast');
        },
        backgroundColor: Colors.red,
        titleStyle: const TextStyle(color: Colors.white),
        subTitleStyle: const TextStyle(color: Colors.white),
        onlyOne: onlyOne,
        crossPage: crossPage,
        animationDuration: Duration(milliseconds: animationMilliseconds),
        animationReverseDuration:
        Duration(milliseconds: animationReverseMilliseconds),
        duration: Duration(seconds: seconds));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SimpleNotification"),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 50),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  BotToast.showSimpleNotification(
                      title: "Notification title",
                      subTitle: "Notification subtitle",
                      enableSlideOff: enableSlideOff,
                      hideCloseButton: hideCloseButton,
                      onlyOne: onlyOne,
                      crossPage: crossPage,
                      backButtonBehavior: backButtonBehavior,
                      onTap: () {
                        BotToast.showText(text: 'Tap toast');
                      },
                      onLongPress: () {
                        BotToast.showText(text: 'Long press toast');
                      },
                      animationDuration:
                      Duration(milliseconds: animationMilliseconds),
                      animationReverseDuration:
                      Duration(milliseconds: animationReverseMilliseconds),
                      duration: Duration(seconds: seconds));
                },
                child: const Text("simpleNotification"),
              ),
              SwitchListTile(
                value: enableSlideOff,
                onChanged: (bool value) {
                  setState(() {
                    enableSlideOff = value;
                  });
                },
                title: const Text("enableSlideOff: "),
              ),
              SwitchListTile(
                value: hideCloseButton,
                onChanged: (bool value) {
                  setState(() {
                    hideCloseButton = value;
                  });
                },
                title: const Text("hideCloseButton: "),
              ),
              SwitchListTile(
                value: onlyOne,
                onChanged: (bool value) {
                  setState(() {
                    onlyOne = value;
                  });
                },
                title: const Text("onlyOne: "),
              ),
              SwitchListTile(
                value: crossPage,
                onChanged: (bool value) {
                  setState(() {
                    crossPage = value;
                  });
                },
                title: const Text("crossPage: "),
              ),
              const Center(
                child: Text('BackButtonBehavior'),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RadioListTile(
                      value: BackButtonBehavior.none,
                      groupValue: backButtonBehavior,
                      onChanged: (value) {
                        setState(() {
                          backButtonBehavior = value!;
                        });
                      },
                      title: const Text('none'),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      value: BackButtonBehavior.ignore,
                      groupValue: backButtonBehavior,
                      onChanged: (value) {
                        setState(() {
                          backButtonBehavior = value!;
                        });
                      },
                      title: const Text('ignore'),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      value: BackButtonBehavior.close,
                      groupValue: backButtonBehavior,
                      onChanged: (value) {
                        setState(() {
                          backButtonBehavior = value!;
                        });
                      },
                      title: const Text('close'),
                    ),
                  )
                ],
              ),
              ListTile(
                title: Text("duration:   ${seconds}s"),
                trailing: CupertinoSlider(
                  min: 1,
                  max: 20,
                  divisions: 20,
                  value: seconds.toDouble(),
                  onChanged: (double value) {
                    setState(() {
                      seconds = value.toInt();
                    });
                  },
                ),
              ),
              ListTile(
                title: Text("animationDuration:   ${animationMilliseconds}ms"),
                trailing: CupertinoSlider(
                  min: 100,
                  max: 1000,
                  divisions: 18,
                  value: animationMilliseconds.toDouble(),
                  onChanged: (double value) {
                    setState(() {
                      animationMilliseconds = value.toInt();
                    });
                  },
                ),
              ),
              ListTile(
                title: Text(
                    "animationReverseDuration:   ${animationReverseMilliseconds}ms"),
                trailing: CupertinoSlider(
                  min: 100,
                  max: 1000,
                  divisions: 18,
                  value: animationReverseMilliseconds.toDouble(),
                  onChanged: (double value) {
                    setState(() {
                      animationReverseMilliseconds = value.toInt();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}