import 'package:flashie/services/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Splash extends StatefulWidget {
  const new({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    super.initState();
    checkLogin();
  }
    Future<void> checkLogin() async{
    final String? token = await StorageService.getToken();
    if (token == null){
      Navigator.pushReplacementNamed(context, "/signin");
    }
    else {
      Navigator.pushReplacementNamed(context, "/home");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}