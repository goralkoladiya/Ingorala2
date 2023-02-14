
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';


import 'config/app_config.dart' as config;
import 'package:flutter/material.dart';
import 'route_generator.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.black));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //9979267536

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Business Listing,Directory Flutter UI KIT',
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Color(0xFF252525),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF2C2C2C),
        accentColor: config.Colors().mainDarkColor(1),
        hintColor: config.Colors().secondDarkColor(1),
        focusColor: config.Colors().accentDarkColor(1),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xFF252525))
          ), //  <-- this auto selects the right color
        ),

        textTheme: TextTheme(
          // button: TextStyle(color: Color(0xFF252525)),
          headlineLarge: TextStyle(fontSize: 20.0, color: config.Colors().secondDarkColor(1)),
          displayLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: config.Colors().secondDarkColor(1)),
          displayMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: config.Colors().secondDarkColor(1)),
          displaySmall: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: config.Colors().mainDarkColor(1)),
          // display4: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: config.Colors().secondDarkColor(1)),
          headlineSmall: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: config.Colors().secondDarkColor(1)),
          titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: config.Colors().mainDarkColor(1)),
          bodyLarge: TextStyle(fontSize: 12.0, color: config.Colors().secondDarkColor(1)),
          bodyMedium:  TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: config.Colors().secondDarkColor(1)),
          // caption: TextStyle(fontSize: 12.0, color: config.Colors().secondDarkColor(0.7)),
        ),
      ),
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.white,
        brightness: Brightness.light,
        accentColor: config.Colors().mainColor(1),
        focusColor: config.Colors().textSecondeColor(1),
        hintColor: config.Colors().textAccentColor(1),
        // textButtonTheme: TextButtonThemeData(
        //   style: ButtonStyle(
        //     backgroundColor: MaterialStateProperty.all(config.Colors().textAccentColor(1))
        //   ), //  <-- this auto selects the right color
        // ),
        textTheme: TextTheme(
          // button: TextStyle(color: Colors.white),
          headlineLarge: TextStyle(fontSize: 20.0, color: config.Colors().textSecondeColor(1)),
          displayLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: config.Colors().textSecondeColor(1)),
          displayMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: config.Colors().textSecondeColor(1)),
          displaySmall: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color:Colors.white),
          // display4: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: config.Colors().textSecondeColor(1)),
          headlineSmall: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: config.Colors().textSecondeColor(1)),
          titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: config.Colors().textMainColor(1)),
          bodyLarge: TextStyle(fontSize: 12.0, color: config.Colors().textSecondeColor(1)),
          bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: config.Colors().textSecondeColor(1)),
          // caption: TextStyle(fontSize: 12.0, color: config.Colors().textAccentColor(0.6)),
        ),
      ),
    );
  }
}
