import 'package:flashie/card_details.dart';
import 'package:flashie/card_page.dart';
import 'package:flashie/homescreen.dart';
import 'package:flashie/regis/signin.dart';
import 'package:flashie/regis/signup.dart';
import 'package:flashie/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(66, 140, 140, 141),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {TargetPlatform.android: ZoomPageTransitionsBuilder()},
        ),
      ),
      initialRoute: '/splash',
      routes: {
        '/home': (context) => Homescreen(),
        '/cards': (context) => CardPage(),
        "/details": (context) => CardDetails(),
        "/signup":(context) => Signup(),
        "/signin":(context) => Signin(),
        "/splash":(context) => Splash()
      },
    );
  }
}
