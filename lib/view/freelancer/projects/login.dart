import 'package:flutter/material.dart';
import 'package:flutter_package1/navigation.dart';
import 'package:ows_bigcareer/view/auth/forget_password.dart';
import 'package:ows_bigcareer/view/auth/register.dart';
import 'package:ows_bigcareer/view/bottom_tabs/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:ows_bigcareer/view_model/sharedpreferences_view_model.dart';
import 'welcome.dart';

class LoginFreelancer extends StatefulWidget {
  const LoginFreelancer({Key? key}) : super(key: key);
  @override
  _LoginFreelancerState createState() => _LoginFreelancerState();
}

class _LoginFreelancerState extends State<LoginFreelancer> {
  late FocusNode text1, text2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    text1 = FocusNode();
    text2 = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    text1.dispose();
    text2.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _controllerMobile = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool tryRegistration = false;
  bool isRegistered = false;
  int? status = 0;
  double textForm1height = 45.0;
  double textForm2height = 45.0;
  double cardHeight = 320;
  bool obscureTextF = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Freelancer Login'),centerTitle: true,),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.width * .22,),
              Center(
                child: SizedBox(
                  height: cardHeight,
                  width: MediaQuery.of(context).size.width * .85,
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    color: Colors.white,
                    elevation: 2,
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                            color: Colors.white,
                          ),
                          width: size.width * .9,
                          height: 50,
                          child: const Center(
                            child: Text(
                              '',
                              style:
                              TextStyle(fontSize: 18, color: Colors.indigo),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: SizedBox(
                            height: textForm1height,
                            child: Theme(
                              data: ThemeData(
                                  primaryColor: Colors.redAccent,
                                  primaryColorDark: Colors.red,
                                  primarySwatch: Colors.indigo),
                              child: TextFormField(
                                controller: _controllerMobile,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    setHeight(1, 65);
                                    return 'Enter Your Email';
                                  } else {
                                    setHeight(1, 45);
                                  }
                                  return null;
                                },
                                onChanged: (v) {
                                  setState(() {
                                    tryRegistration = false;
                                  });
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.indigo)),
                                  labelText: 'Enter Email',
                                  labelStyle: TextStyle(fontSize: 13),
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  prefixText: ' ',
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: Colors.indigo,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: SizedBox(
                            height: textForm2height,
                            child: Theme(
                              data: ThemeData(
                                  primaryColor: Colors.redAccent,
                                  primaryColorDark: Colors.red,
                                  primarySwatch: Colors.indigo),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: _controllerPassword,
                                obscureText: obscureTextF,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    setHeight(2, 65);
                                    return 'Enter Your Password';
                                  } else {
                                    setHeight(2, 45);
                                  }
                                  if (value!.length > 8) {
                                    setHeight(2, 65);
                                    return 'Password Max length 8';
                                  } else {
                                    setHeight(2, 45);
                                  }
                                  return null;
                                },
                                onChanged: (v) {
                                  setState(() {
                                    tryRegistration = false;
                                  });
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.teal)),
                                    labelText: 'Enter Your Password',
                                    labelStyle: const TextStyle(fontSize: 13),
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    prefixText: ' ',
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: Colors.indigo,
                                      size: 20,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          // !obscureTextF;
                                          obscureTextF = !obscureTextF;
                                        });
                                      },
                                      icon: obscureTextF
                                          ? const Icon(
                                        Icons.visibility_off,
                                        color: Colors.indigo,
                                        size: 20,
                                      )
                                          : const Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.indigo,
                                        size: 20,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 18.0, top: 10),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  // navigateAndFinsh(context, const ForgetPassword());
                                },
                                child: const Text(
                                  "Forget password?",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.indigo),
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 38.0),
                          child: SizedBox(
                              height: 40,
                              width: size.width * .6,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(5)),
                                      backgroundColor: Colors.indigo),
                                  onPressed: () {
                                    _verifyUser(context);
                                  },
                                  child: const Text(
                                    'LOGIN',
                                    style: TextStyle(color: Colors.white),
                                  ))),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    // navigateAndFinsh(context, const RegistrationScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Do not have an freelancer account?",
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      Text(
                        " Register",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600,
                            color: Colors.indigo),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _verifyUser(BuildContext context) async {
    setState(() {
      cardHeight = 360;
    });
    if (formKey.currentState!.validate()) {
      setState(() {
        cardHeight = 300;
      });
      if (mounted) {
        setState(() {
          tryRegistration = true;
        });
      }
      var sharedPreferencesVM = Provider.of<SharedPreferencesVM>(context, listen: false);
      sharedPreferencesVM.setFreelancerLoginStatus(true);
      navigateAndFinsh(context, BigCareerBottomNavBar());
    }
  }

  void setHeight(int field, double height) {
    if (field == 1) {
      setState(() {
        textForm1height = height;
      });
    } else {
      setState(() {
        textForm2height = height;
      });
    }
  }

  bool _isEmailValidate(String txt) {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(txt);
  }
}
