import 'dart:io';
import 'package:ows_bigcareer/model/models/model_app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ows_bigcareer/model/cubits/auth_cubit/auth_cubit.dart';
import 'package:ows_bigcareer/model/cubits/auth_cubit/auth_state.dart';
import 'package:ows_bigcareer/view/auth/login.dart';
import 'package:ows_bigcareer/view/bottom_tabs/bottom_nav_bar.dart';
import 'package:ows_bigcareer/view/route.dart';
import 'package:ows_bigcareer/view_model/api_view_model.dart';
import 'package:ows_bigcareer/view_model/setting_view_model.dart';
import 'package:provider/provider.dart';
import 'package:ows_bigcareer/view_model/sharedpreferences_view_model.dart';
import 'package:ows_bigcareer/model/shared_preference/shared_preferens.dart';
import 'package:ows_bigcareer/view_model/chat_view_model.dart';
import 'package:overlay_support/overlay_support.dart';


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();
  AppPreferences.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp(
      prefs: AppPreferences.preferences,
    ));
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.prefs}) : super(key: key);
  final prefs;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState();

  bool displaySplashImage = true;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ApiViewModel()),
        ChangeNotifierProvider.value(value: SettingViewModel()),
        // ChangeNotifierProvider.value(value: FirebaseAuthViewModel()),
        ChangeNotifierProvider<SharedPreferencesVM>(
          create: (ctx) =>
              SharedPreferencesVM(appPreferences: AppPreferences()),
        ),
        ChangeNotifierProvider<ChatViewModel>(
          create: (ctx) =>
              ChatViewModel(
                firebaseFirestore: this.firebaseFirestore,
                firebaseStorage: this.firebaseStorage,
              ),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: const AppMaterial(),
    );
  }
}

class AppMaterial extends StatefulWidget {
  const AppMaterial({Key? key}) : super(key: key);

  @override
  State<AppMaterial> createState() => _AppMaterialState();
}

class _AppMaterialState extends State<AppMaterial> {
  bool displaySplashImage = true;
  var sharedPreferencesVM;
  late AppUser appUser;
  bool loginStatus=false;

  getUserDetails() async {
    print('-----getUserDetails------------------');
    BlocProvider.of<AuthCubit>(context).checkLoginStatus(context);
    var sharedPreferencesVM = Provider.of<SharedPreferencesVM>(context, listen: false);
    print('-----getUserDetails------------------');
    appUser = await sharedPreferencesVM.getUserDetails();
    print('-----getUserDetails-------------------${appUser}');
    setState(() {
      // flagUserData=false;
    });
  }
  @override
  void initState() {
    getUserDetails();
    super.initState();
    // Future.delayed(const Duration(seconds: 4),
    //     () => setState(() => displaySplashImage = false));
  }


  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Big Career',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(),
          primarySwatch: Colors.indigo,
          // accentColor: Colors.deepOrange,
          // backgroundColor: Colors.white
        ),
        // home: displaySplashImage
        //     ? const SplashScreen()
        home: BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (oldState, newState) {
                  return oldState is AuthInitialState;
                },
                builder: (context, state) {
                  if (state is AuthLoggedInState) {
                    return BigCareerBottomNavBar();
                  } else if (state is AuthLoggedOutState) {
                    return const LoginScreen();
                  } else {
                    return const Scaffold(
                      body: Center(
                        child: Text('error of loading app'),
                      ),
                    );
                  }
                },
              ),
        onGenerateRoute: (route) => RouteGenerator.generateRoute(route),
      ),
    );
  }
}

