import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_package1/components.dart';
import 'package:ows_bigcareer/model/cubits/auth_cubit/auth_cubit.dart';
import 'package:ows_bigcareer/model/cubits/auth_cubit/auth_state.dart';
import 'package:ows_bigcareer/view/auth/register.dart';
import 'change_password.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key, required this.fromProfile}) : super(key: key);
  final fromProfile;

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late FocusNode text1, text2;
  bool showOTP = false;
  bool showPawssord = false;
  bool waitForOtp = false;
  String waitForOtpText = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AuthCubit>(context).setResetState();
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
  final TextEditingController _controllerOtp = TextEditingController();
  final TextEditingController _controllerPwd = TextEditingController();
  final TextEditingController _controllerConfirmPwd = TextEditingController();
  bool tryRegistration = false;
  bool isRegistered = false;
  int? status = 0;
  double height = 45.0;
  double cardHeight = 260;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: widget.fromProfile
          ? AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              title: SizedBox(
                  width: MediaQuery.of(context).size.width * .25,
                  height: MediaQuery.of(context).size.width * .20,
                  child: Center(child: Image.asset('assets/logo.png'))),
            )
          : null,
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
              widget.fromProfile
                  ? Container()
                  : SizedBox(
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
                          child: Center(
                            child: Text(
                              widget.fromProfile
                                  ? 'Change Password'
                                  : 'Forget Password',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20),
                          child: SizedBox(
                            height: height,
                            child: Theme(
                              data: ThemeData(
                                  primaryColor: Colors.redAccent,
                                  primaryColorDark: Colors.red,
                                  primarySwatch: Colors.indigo),
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: _controllerMobile,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    setState(() {
                                      height = 65;
                                    });
                                    return 'Enter Your Mobile';
                                  } else {
                                    setState(() {
                                      height = 45;
                                    });
                                  }
                                  if (value!.length > 10 ||
                                      value!.length < 10) {
                                    setState(() {
                                      height = 65;
                                    });
                                    return 'Mobile length must be 10 digit';
                                  } else {
                                    setState(() {
                                      height = 45;
                                    });
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
                                  labelText: 'Enter Your Mobile',
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
                        SizedBox(height: size.height * 0.02),
                        showOTP
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20),
                                child: SizedBox(
                                  height: height,
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
                                          setState(() {
                                            height = 65;
                                          });
                                          return 'Enter Your OTP';
                                        } else {
                                          setState(() {
                                            height = 45;
                                          });
                                        }
                                        if (value!.length > 6 ||
                                            value!.length < 6) {
                                          setState(() {
                                            height = 65;
                                          });
                                          return 'Otp length must be 6 digit';
                                        } else {
                                          setState(() {
                                            height = 45;
                                          });
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
                                            borderSide: BorderSide(
                                                color: Colors.indigo)),
                                        labelText: 'Enter Otp',
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
                              )
                            : Container(),
                        const SizedBox(
                          height: 10,
                        ),
                        waitForOtp ? Text(waitForOtpText) : Container(),
                        BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            if (state is AuthLoggedInState) {}
                            if (state is AuthMobileNotExist) {
                              showToast(
                                  msg:
                                      '${_controllerMobile.text} is not registered number');
                            }
                            if (state is AuthMobileAlreadyExist) {
                              setState(() {
                                showOTP = true;
                                waitForOtpText = 'please wait for otp';
                                waitForOtp = true;
                              });
                            }
                            if (state is AuthCodeSentState) {
                              setState(() {
                                waitForOtpText = 'otp send successfully';
                              });
                              // showPawssord=true;
                            }
                            if (state is AuthCodeVerifiedState) {
                              navigateAndFinsh(
                                  context,
                                  ChangePassword(
                                    mobile: _controllerMobile.text,
                                  ));
                            }
                            if (state is AuthErrorState) {
                              waitForOtpText = 'you entered wrong otp';
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
                                        _verifyUser(context);
                                      },
                                      child: Text(
                                        widget.fromProfile
                                            ? 'Submit'
                                            : 'Verify',
                                        style: TextStyle(color: Colors.white),
                                      ))),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              widget.fromProfile
                  ? Container()
                  : Align(
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
      height = 65;
      cardHeight = 300;
    });
    if (formKey.currentState!.validate()) {
      if (showOTP) {
        // String phoneNumber = "+91${_controllerMobile.text}";
        BlocProvider.of<AuthCubit>(context).verifyOTP2(_controllerOtp.text);
      } else {
        String phoneNumber = "+91${_controllerMobile.text}";
        BlocProvider.of<AuthCubit>(context).verifyMobile(phoneNumber);
      }
    }
  }

  bool _isEmailValidate(String txt) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(txt);
  }
}
