import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_core/src/smart_management.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:powerbank/App/LoginRegister/Ui/Auth.Screen.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/Get.Routes.dart';

import 'Constants/strings.dart';
import 'GlobalBindings.dart';
import 'HelperClasses/Widgets.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Pass all uncaught errors from the framework to Crashlytics.

    await Hive.initFlutter();
    await Hive.openBox(hiveBoxName);

    await Firebase.initializeApp();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: false,
    );

    SmartDialog.config
      ..clickBgDismiss = false
      ..isLoading = true
      ..isUseAnimation = true
      ..animationDuration = const Duration(milliseconds: 230)
      ..isPenetrate = false
      ..maskColor = color1.withOpacity(0.7)
      ..alignment = Alignment.centerRight;

    GlobalBindings().dependencies();
    runApp(const MyApp());
  },
      (error, stack) =>
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver gAnalyticsObserver =
      FirebaseAnalyticsObserver(analytics: analytics);
  @override
  void initState() {
    super.initState();
    initOneSignalService();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Future<void> initOneSignalService() async {
    OneSignal.shared.setAppId(oneSignalAppId);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DREAM LIGHT CITY',
      debugShowCheckedModeBanner: false,
      getPages: myGetRoutes,
      theme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.encodeSansTextTheme(
          Theme.of(context).textTheme,
        ),
        androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
      ),
      navigatorObservers: [FlutterSmartDialog.observer, gAnalyticsObserver],
      builder: FlutterSmartDialog.init(),
      smartManagement: SmartManagement.keepFactory,
      home: const SplashIntro(),
    );
  }
}

class SplashIntro extends StatefulWidget {
  const SplashIntro({Key? key}) : super(key: key);

  @override
  _SplashIntroState createState() => _SplashIntroState();
}

class _SplashIntroState extends State<SplashIntro> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4),
        () => Get.offAllNamed(AuthScreen.screenName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 70,
            ),

            const DelayedDisplay(
              fadingDuration: Duration(milliseconds: 200),
              child: SizedBox(width: 100, height: 100, child: AppIconWidget()),
            ),
            const SizedBox(height: 20),
            const DelayedDisplay(
              fadingDuration: Duration(milliseconds: 200),
              child: Text(
                "DREAM\nLIGHT CITY",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 40,
                    color: colorWhite,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            DelayedDisplay(
              fadingDuration: const Duration(milliseconds: 200),
              delay: const Duration(milliseconds: 200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (Map i in introRowItems)
                    Column(
                      children: [
                        Icon(
                          i["icon"],
                          color: color4,
                          size: 32,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          i["text"],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            color: color4,
                          ),
                        )
                      ],
                    )
                ],
              ),
            ),

            ///
            const SizedBox(
              height: 100,
            ),
            DelayedDisplay(
              fadingDuration: const Duration(milliseconds: 200),
              delay: const Duration(seconds: 1),
              child: SizedBox(
                height: 80,
                child: Lottie.asset("assets/92803-loading.json"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Map> introRowItems = [
  {"text": "100 % SAFE", "icon": FontAwesomeIcons.shieldAlt},
  {"text": "FAST\nWITHDRAWAL", "icon": FontAwesomeIcons.handHoldingUsd},
  {"text": "NO BOTS", "icon": FontAwesomeIcons.robot},
];
