import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_package1/components.dart';
import 'package:ows_bigcareer/model/cubits/auth_cubit/auth_cubit.dart';
import 'package:ows_bigcareer/model/cubits/auth_cubit/auth_state.dart';
import 'package:ows_bigcareer/view/auth/register.dart';
import 'package:ows_bigcareer/view_model/sharedpreferences_view_model.dart';
import 'package:provider/provider.dart';
import 'login.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key, required this.mobile}) : super(key: key);
  final mobile;
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late FocusNode text1, text2;
  bool showOTP = false;
  bool showPawssord = false;

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
  final TextEditingController _controllerPwd = TextEditingController();
  final TextEditingController _controllerConfirmPwd = TextEditingController();
  bool tryRegistration = false;
  bool isRegistered = false;
  int? status = 0;
  double height = 45.0;
  double cardHeight = 280;

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
                              'Change Password',
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
                                controller: _controllerPwd,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    setState(() {
                                      height = 65;
                                    });
                                    return 'Enter New Password';
                                  } else {
                                    setState(() {
                                      height = 45;
                                    });
                                  }
                                  if (value!.length < 4) {
                                    setState(() {
                                      height = 65;
                                    });
                                    return 'password minimum length must be 4 digit';
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
                                  labelText: 'Enter New Password',
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
                                controller: _controllerConfirmPwd,
                                validator: (value) {
                                  if (_controllerPwd.text !=
                                      _controllerConfirmPwd.text) {
                                    setState(() {
                                      height = 65;
                                    });
                                    return 'password not match';
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
                                  labelText: 'Confirm Password',
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
                        BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            if (state is AuthChangePwdErrorState) {
                              showToast(msg: 'oops password Not changed');
                            }
                            if (state is AuthPasswordChangedSuccessfully) {
                              showToast(msg: 'password successfully changed');
                              BlocProvider.of<AuthCubit>(context).logOut();
                              var sharedPreferencesVM =
                              Provider.of<SharedPreferencesVM>(context,
                                  listen: false);
                              sharedPreferencesVM.setLoginStatus(false);
                              navigateAndFinsh(context, LoginScreen());
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
                                      child: const Text(
                                        'Change',
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
      height = 65;
      cardHeight = 340;
    });
    if (formKey.currentState!.validate()) {
      setState(() {
        height = 65;
        cardHeight = 280;
      });
      BlocProvider.of<AuthCubit>(context).changePassword(widget.mobile,_controllerPwd.text);
    }
  }

  bool _isEmailValidate(String txt) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(txt);
  }
}
