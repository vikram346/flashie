import 'package:flashie/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flashie/services/secure_storage.dart';

class Signin extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 20, left: 8, right: 8, bottom: 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Login with your details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 14),
                    Image.asset('assets/images/Sign up-rafiki.png', height: 300),
                    SizedBox(height: 14),
                    TextField(
                      style: TextStyle(color: Colors.white),
                      controller: emailController,
                      decoration: InputDecoration(labelText: "Enter Email"),
                    ),
                    SizedBox(height: 14),
                    TextField(
                      style: TextStyle(color: Colors.white),
                      controller: passwordController,
                      decoration: InputDecoration(labelText: "Enter Password"),
                    ),
                    SizedBox(height: 14),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          final message = await AuthService.signin(
                            email: emailController.text.trim(),
                            password: passwordController.text,
                          );
                          final token = message['access_token'];
                          await StorageService.saveToken(token);
                          // final int user_id = int.parse(message["userId"].toString());
                          if (!context.mounted) return;
                          Navigator.pushReplacementNamed(context, "/home");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Login successfully",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            
                          );
                        } catch (e) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                e.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }
                      },
                      child: Text("Login"),
                    ),
                    SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Dont have an account?",
                          style: TextStyle(color: Colors.white30),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, "/signup");
                          },
                          child: Text("Sign-up here"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
