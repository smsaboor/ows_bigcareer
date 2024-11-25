import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_package1/components.dart';
import 'package:ows_bigcareer/model/cubits/auth_cubit/auth_cubit.dart';
import 'package:ows_bigcareer/model/cubits/auth_cubit/auth_state.dart';
import 'package:ows_bigcareer/view/auth/login.dart';
import 'package:ows_bigcareer/view/auth/otp_ver.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late FocusNode text1, text2;
  double textForm1height = 45.0;
  double textForm2height = 45.0;
  double textForm3height = 45.0;
  double textForm4height = 45.0;
  double cardHeight = 430;

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
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  bool tryRegistration = false;
  bool isRegistered = false;
  int? status = 0;
  bool obscureTextF = true;
  bool checkBoxValue = false;
  bool showError = false;

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
                height: MediaQuery.of(context).size.height * .1,
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
                              'Sign up',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:20.0,right: 20),
                          child: Column(children: [
                            SizedBox(height: size.height * 0.02),
                            SizedBox(
                              height: textForm1height,
                              child: Theme(
                                data: ThemeData(
                                    primaryColor: Colors.redAccent,
                                    primaryColorDark: Colors.red,
                                    primarySwatch: Colors.indigo),
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: _controllerName,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      setHeight(1, 65);
                                      return 'Enter Your Full Name';
                                    } else {
                                      setHeight(1, 45);
                                    }
                                    if (value!.length > 40) {
                                      setHeight(1, 65);
                                      return '40';
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
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.indigo)),
                                    labelText: 'Full Name',
                                    labelStyle: TextStyle(fontSize: 13),
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Colors.indigo,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: textForm2height,
                              child: Theme(
                                data: ThemeData(
                                    primaryColor: Colors.redAccent,
                                    primaryColorDark: Colors.red,
                                    primarySwatch: Colors.indigo),
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: _controllerEmail,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      setHeight(2, 65);
                                      return 'Enter Your Email';
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
                                    isDense: true,
                                    border: const OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.teal)),
                                    labelText: 'Email',
                                    labelStyle: const TextStyle(fontSize: 13),
                                    prefixIcon: Container(
                                      transform: Matrix4.translationValues(
                                          0.0, 0.0, 0.0),
                                      child: const Icon(
                                        Icons.email,
                                        color: Colors.indigo,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: textForm3height,
                              child: Theme(
                                data: ThemeData(
                                    primaryColor: Colors.redAccent,
                                    primaryColorDark: Colors.red,
                                    primarySwatch: Colors.indigo),
                                child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: _controllerPhone,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      setHeight(3, 65);
                                      return 'Enter Your Phone Number';
                                    } else {
                                      setHeight(3, 45);
                                    }
                                    if (value!.length > 10 || value.length < 10) {
                                      setHeight(3, 65);
                                      return 'Number length must be 10';
                                    } else {
                                      setHeight(3, 45);
                                    }
                                    return null;
                                  },
                                  onChanged: (v) {
                                    setState(() {
                                      tryRegistration = false;
                                    });
                                  },
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.teal)),
                                    labelText: 'Phone Number',
                                    labelStyle: TextStyle(fontSize: 13),
                                    prefixText: ' ',
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.only(right: 0),
                                      child: Icon(
                                        Icons.lock,
                                        color: Colors.indigo,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: textForm4height,
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
                                      setHeight(4, 65);
                                      return 'Enter Your Password';
                                    } else {
                                      setHeight(4, 45);
                                    }
                                    if (value!.length < 4) {
                                      setHeight(4, 65);
                                      return 'Password min length is 4';
                                    } else {
                                      setHeight(4, 45);
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
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      border: const OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.teal)),
                                      labelText: 'Password',
                                      labelStyle: const TextStyle(fontSize: 13),
                                      prefixIcon: const Padding(
                                        padding: EdgeInsets.only(left: 1.0),
                                        child: Icon(
                                          Icons.lock,
                                          color: Colors.indigo,
                                          size: 20,
                                        ),
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
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      checkBoxValue = !checkBoxValue;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: checkBoxValue ? true : false,
                                        checkColor: Colors.white,
                                        activeColor: Colors.indigo,
                                        side: const BorderSide(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                        onChanged: (bool? value) {},
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 1.0),
                                        child: Text(
                                          "agree with our term and conditions",
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                showError
                                    ? const Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 1.0),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        'Please check the term and condition ? ',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      ),
                                    ),
                                  ),
                                )
                                    : Container(),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            BlocConsumer<AuthCubit, AuthState>(
                              listener: (context, state) {
                                if (state is AuthCodeSentState) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OtpVerification(
                                            name: _controllerName.text,
                                            email: _controllerEmail.text,
                                            mobile: _controllerPhone.text,
                                            pwd: _controllerPassword.text,
                                          )));
                                }if (state is AuthMobileAlreadyExist) {
                                  showToast(
                                      msg:
                                      'Mobile ${_controllerPhone.text} is already registered');
                                }
                              },
                              builder: (context, state) {
                                if (state is AuthLoadingState) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return SizedBox(
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
                                          'Sign Up',
                                          style: TextStyle(color: Colors.white),
                                        )));
                              },
                            ),
                          ],),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    navigateAndFinsh(context, const LoginScreen());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      Text(
                        " Login",
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600,
                            color: Colors.indigo),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _verifyUser(BuildContext context) async {
    setState(() {
      cardHeight = 520;
    });
    if (formKey.currentState!.validate()) {
      setState(() {
        cardHeight = 450;
      });
      if (checkBoxValue == true) {
        setState(() {
          showError = false;
        });
        String phoneNumber = "+91${_controllerPhone.text}";
        BlocProvider.of<AuthCubit>(context).sendOTP(phoneNumber);
      } else {
        setState(() {
          showError = true;
        });
      }
    }
  }

  void setHeight(int field, double height) {
    if (field == 1) {
      setState(() {
        textForm1height = height;
      });
    } else if (field == 2) {
      setState(() {
        textForm2height = height;
      });
    } else if (field == 3) {
      setState(() {
        textForm3height = height;
      });
    } else if (field == 4) {
      setState(() {
        textForm4height = height;
      });
    }
  }

  bool _isEmailValidate(String txt) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(txt);
  }
}
