import 'package:cloud_hospital/apis/dashboard_apis.dart';
import 'package:cloud_hospital/controllers/dashboard_controller.dart';
import 'package:cloud_hospital/services/sp_helper.dart';
import 'package:cloud_hospital/utils/helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

/////
import 'constants/style.dart';
import 'controllers/app_controller.dart';
import 'controllers/auth_controller.dart';
import 'controllers/menu_controller.dart';
import 'controllers/navigation_controller.dart';
import 'layout.dart';
import 'pages/404/error.dart';
import 'pages/authentication/auth_page.dart';
import 'pages/authentication/login_screen.dart';
import 'pages/authentication/register_screen.dart';
import 'pages/clients/widgets/client_disease.dart';
import 'routing/routes.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('backgroundMessage');
  print(message.data.toString());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: FirebaseOptions(
      apiKey: "AIzaSyCAA0KmD5JUmbTXC1nBCOCzQh0OTkHY6k4",
      appId: "1:1043456810875:web:23c7c139be9ba3da2fa7de",
      messagingSenderId: "1043456810875",
      projectId: "trustproject-72236",
    ),
  );
  var token = await FirebaseMessaging.instance.getToken();

  FirebaseMessaging.onMessage.listen((event) {
    print('comeNotificcation');

    // print('yehyaabasem'+event.data['id'].toString());
    Get.snackbar(event.notification.title, event.notification.body,
        backgroundColor: Colors.green.withOpacity(0.7),
        colorText: Colors.white,
    duration: const Duration(seconds: 5));
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    Helper.setToast(event.notification.title);
    Fluttertoast.showToast(msg: event.notification.body);
    print('comeNotificcation');
    print(event.data.toString());
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  print(token);
  await SPHelper.spHelper.initSharedPrefrences();
  Get.put(MenuController());
  Get.put(NavigationController());
  Get.put(AuthController());
  Get.put(DashboardController());
  Get.put(AppController());
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = primaryColor
    ..backgroundColor = Colors.white
    ..indicatorColor = primaryColor
    ..textColor = Colors.black
    ..dismissOnTap = false;
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    DashboardApis.dashboardApis.getSpecialties();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: SPHelper.spHelper.getToken() == '' ||
              SPHelper.spHelper.getToken() == null
          ? '/auth'
          : '/',
      unknownRoute: GetPage(
          name: '/not-found',
          page: () => PageNotFound(),
          transition: Transition.fadeIn),
      getPages: [
        GetPage(
            name: rootRoute,
            page: () {
              return SiteLayout();
            }),
        GetPage(name: authenticationPageRoute, page: () => AuthPage()),
        GetPage(name: loginPageRoute, page: () => LoginScreen()),
        GetPage(name: registerPageRoute, page: () => RegisterScreen()),
        GetPage(name: clientDiseasePageRoute, page: () => ClientDisease()),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Hospital Cloud',
      theme: ThemeData(
        scaffoldBackgroundColor: light,
        textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        }),
        primarySwatch: Colors.blue,
      ),
      builder: EasyLoading.init(),
      locale: const Locale('ar'),
      fallbackLocale: const Locale('ar'),
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'AE'),
      ],
      // home: AuthenticationPage(),
    );
  }
}
