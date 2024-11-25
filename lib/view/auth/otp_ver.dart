import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_package1/navigation.dart';
import 'package:ows_bigcareer/model/cubits/auth_cubit/auth_cubit.dart';
import 'package:ows_bigcareer/model/cubits/auth_cubit/auth_state.dart';
import 'package:ows_bigcareer/view/auth/register.dart';
import 'package:ows_bigcareer/view/bottom_tabs/bottom_nav_bar.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification(
      {Key? key,
      required this.name,
      required this.mobile,
      required this.pwd,
      required this.email})
      : super(key: key);
  final name, mobile, email, pwd;

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
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
  final TextEditingController _controllerOtp = TextEditingController();

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
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * .2,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * .25,
                  height: MediaQuery.of(context).size.width * .20,
                  child: Center(child: Image.asset('assets/logo.png'))),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
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
                            color: Colors.indigo,
                          ),
                          width: size.width * .9,
                          height: 50,
                          child: const Center(
                            child: Text(
                              'Verify Otp',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
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
                                textInputAction: TextInputAction.next,
                                controller: _controllerOtp,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    setHeight(1, 65);
                                    return 'Enter Your Mobile';
                                  } else {
                                    setHeight(1, 45);
                                  }
                                  if (value!.length > 6) {
                                    setHeight(1, 65);
                                    return 'Otp Max length 10';
                                  } else {
                                    setHeight(1, 45);
                                  }
                                  if (value!.length < 6) {
                                    setHeight(1, 65);
                                    return 'Otp Min length 10';
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
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.indigo)),
                                  labelText: 'Enter Otp Number',
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  labelStyle: TextStyle(fontSize: 13),
                                  prefixText: ' ',
                                  prefixIcon: Icon(
                                    Icons.phone_android,
                                    color: Colors.indigo,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            if (state is AuthLoggedInState) {
                              navigateAndFinsh(
                                  context, BigCareerBottomNavBar());
                            }
                          },
                          builder: (context, state) {
                            if (state is AuthLoadingState) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Padding(
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
                                        BlocProvider.of<AuthCubit>(context)
                                            .registerAfterVerifyingOtp(
                                                context,
                                                '+91${widget.mobile}',
                                                widget.name,
                                                widget.email,
                                                widget.pwd,
                                                _controllerOtp.text);
                                      },
                                      child: const Text(
                                        'verify',
                                        style: TextStyle(color: Colors.white),
                                      ))),
                            );
                            // return SizedBox(
                            //   width: MediaQuery.of(context).size.width,
                            //   child: CupertinoButton(
                            //     onPressed: () {
                            //       String phoneNumber = "+91" + _controllerMobile.text;
                            //       BlocProvider.of<AuthCubit>(context).sendOTP(phoneNumber);
                            //     },
                            //     color: Colors.blue,
                            //     child: Text("Sign In"),
                            //   ),
                            // );
                          },
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 38.0),
                        //   child: SizedBox(
                        //       height: 40,
                        //       width: size.width * .6,
                        //       child: ElevatedButton(
                        //           style: ElevatedButton.styleFrom(
                        //               shape: RoundedRectangleBorder(
                        //                   borderRadius:
                        //                   BorderRadius.circular(5)),
                        //               backgroundColor: Colors.indigo),
                        //           onPressed: () {
                        //             BlocProvider.of<AuthCubit>(context).verifyOTP(_controllerMobile.text);
                        //           },
                        //           child: const Text(
                        //             'VERIFY',
                        //             style: TextStyle(color: Colors.white),
                        //           ))),
                        // )
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
                    navigateAndFinsh(context, const RegistrationScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Do not have an account?",
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
      navigateAndFinsh(context, BigCareerBottomNavBar());
      // var sharedPreferencesVM = Provider.of<SharedPreferencesVM>(context, listen: false);
      // sharedPreferencesVM.setLoginStatus(true);

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
