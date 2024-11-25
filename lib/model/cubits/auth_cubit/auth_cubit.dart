import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ows_bigcareer/model/apis/urls.dart';
import 'package:ows_bigcareer/model/cubits/auth_cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ows_bigcareer/view_model/sharedpreferences_view_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:ows_bigcareer/model/models/model_app_user.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loginStatus=false;
  AuthCubit() : super(AuthInitialState()) {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      emit(AuthLoggedInState());
    } else {
      emit(AuthLoggedOutState());
    }
  }

  getuid(){
    FirebaseAuth auth = FirebaseAuth.instance;
      final userid = auth.currentUser!.uid;
  }
  String? _verificationId;

  void checkLoginStatus(BuildContext context) async {
    var sharedPreferencesVM = Provider.of<SharedPreferencesVM>(context, listen: false);
    loginStatus=await sharedPreferencesVM.getLoginStatus();
    if(loginStatus==true){
      emit(AuthLoggedInState());
    }else{
      emit(AuthLoggedOutState());
    }
  }

  void sendOTP(String phoneNumber) async {
    emit(AuthLoadingState());
    DocumentSnapshot vari = await FirebaseFirestore.instance
        .collection("users")
        .doc(phoneNumber)
        .get();
    if (vari.exists) {
      print('-sendOTP1-----------${vari.exists}-');
      emit(AuthMobileAlreadyExist());
    } else {
      print('-sendOTP2-----------${vari.exists}-');
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        codeSent: (verificationId, forceResendingToken) {
          _verificationId = verificationId;
          emit(AuthCodeSentState());
        },
        verificationCompleted: (phoneAuthCredential) {
          // signInWithPhone(phoneAuthCredential);
        },
        verificationFailed: (error) {
          // emit( AuthErrorState(error.message.toString()) );
        },
        codeAutoRetrievalTimeout: (verificationId) {
          _verificationId = verificationId;
        },
      );
    }
  }

  void registerAfterVerifyingOtp(
    BuildContext context,
    String mobile,
    String name,
    String email,
    String pwd,
    String otp,
  ) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: otp);
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        final user = FirebaseAuth.instance.currentUser;
        print('userCredential.user != null-${user}--${user!.uid}-------${user!.phoneNumber}');
        Map<String, dynamic> userData = {
          "name": name,
          "email": email,
          "pwd": pwd,
          "mobile": mobile,
          "uid": user.uid,
          "image": "https://i.pinimg.com/736x/86/63/78/866378ef5afbe8121b2bcd57aa4fb061.jpg"
        };
        await FirebaseFirestore.instance
            .collection("users")
            .doc(mobile)
            .set(userData);
        var sharedPreferencesVM = Provider.of<SharedPreferencesVM>(context, listen: false);
        sharedPreferencesVM.setLoginStatus(true);
        sharedPreferencesVM.setUserDetails(AppUser(
            name: name,
            email: email,
            mobile: mobile,
            uid:user.uid,
            pwd: pwd,
            image: "https://i.pinimg.com/736x/86/63/78/866378ef5afbe8121b2bcd57aa4fb061.jpg"));
      }
    } on FirebaseAuthException catch (error) {
      // log(error.code.toString());
    }
  }

  void verifyOTP(String otp) async {
    print('otp----------$otp');
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: otp);
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        print('userCredential.user != null----------$otp');
      }
    } on FirebaseAuthException catch (error) {
      print("exception is : ${error.code.toString()}");
    }
  }

  void verifyOTP2(String otp) async {
    print('otp----------$otp');
    emit(AuthLoadingState());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: otp);
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        print('userCredential.user != null----------$otp');
        emit(AuthCodeVerifiedState());
      }
    } on FirebaseAuthException catch (error) {
      emit(AuthErrorState(error.message.toString()));
      // log(error.code.toString());
    }
  }

  void changePassword(String mobile, String pwd) async {
    print('mobile---$mobile-------$pwd');
    emit(AuthLoadingState());
    try {
      DocumentSnapshot vari = await FirebaseFirestore.instance
          .collection("users")
          .doc('+91$mobile')
          .get();
      Map<String, dynamic> userData = {
        'name': vari['name'],
        'mobile': vari['mobile'],
        'email': vari['email'],
        "pwd": pwd
      };
      if (vari.exists) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc('+91$mobile')
            .set(userData)
            .onError((error, stackTrace) {
          emit(AuthChangePwdErrorState());
        });
        emit(AuthPasswordChangedSuccessfully());
      } else {
        print('------------mobile not exist');
        emit(AuthMobileNotExist());
      }
    } on FirebaseAuthException catch (error) {
      emit(AuthErrorState(error.message.toString()));
      // log(error.code.toString());
    }
  }

  void setResetState() {
    emit(AuthResetState());
  }

  void verifyMobile(String mobile) async {
    print('mobile----------$mobile');
    emit(AuthLoadingState());
    try {
      DocumentSnapshot vari = await FirebaseFirestore.instance
          .collection("users")
          .doc(mobile)
          .get();
      if (vari.exists) {
        emit(AuthMobileAlreadyExist());
        await _auth.verifyPhoneNumber(
          phoneNumber: mobile,
          codeSent: (verificationId, forceResendingToken) {
            _verificationId = verificationId;
            emit(AuthCodeSentState());
          },
          verificationCompleted: (phoneAuthCredential) {
            // signInWithPhone(phoneAuthCredential);
          },
          verificationFailed: (error) {
            // emit( AuthErrorState(error.message.toString()) );
          },
          codeAutoRetrievalTimeout: (verificationId) {
            _verificationId = verificationId;
          },
        );
      } else {
        emit(AuthMobileNotExist());
      }
    } on FirebaseAuthException catch (error) {
      emit(AuthErrorState(error.message.toString()));
      // log(error.code.toString());
    }
  }

  void checkAndlogin(String mobile, String pwd, BuildContext context) async {
    emit(AuthLoadingState());
    try {
      DocumentSnapshot vari = await FirebaseFirestore.instance
          .collection("users")
          .doc(mobile)
          .get();
      if (vari.exists) {
        if (vari['pwd'] == pwd) {
          emit(AuthLoggedInState());
          var sharedPreferencesVM =
              Provider.of<SharedPreferencesVM>(context, listen: false);
          sharedPreferencesVM.setLoginStatus(true);
          sharedPreferencesVM.setUserDetails(AppUser(
              name: vari['name'].toString(),
              email: vari['email'].toString(),
              mobile: vari['mobile'].toString(),
              uid: vari['uid'].toString(),
              pwd: vari['pwd'].toString(),
              image: vari['image']));
        } else {
          emit(AuthPasswordNotMatch());
        }
      } else {
        print(vari.exists);
        print('${vari.runtimeType}');
        print('${vari}');
        emit(AuthMobileNotExist());
      }
      // }
    } on FirebaseAuthException catch (error) {
      emit(AuthErrorState('error of firebase auth'));
      // log(error.code.toString());
    }
  }

  void logOut() async {
    // await _auth.signOut();
    emit(AuthLoggedOutState());
  }
}
