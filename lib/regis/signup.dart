import 'package:flutter/material.dart';
import 'package:flashie/services/auth.dart';

class Signup extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(14),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text(
                "Create a Account",
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
                controller: usernameController,
                decoration: InputDecoration(labelText: "create Username"),
              ),
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
                decoration: InputDecoration(labelText: "create Password"),
              ),
              // SizedBox(height: 14),
              // TextField(
              //   controller: passwordController,
              //   decoration: InputDecoration(labelText: "confirm password"),
              // ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  // print("Create Account pressed");
                  try {
                    final message = await AuthService.signup(
                      username: usernameController.text.trim(),
                      email: emailController.text.trim(),
                      password: passwordController.text,
                    );
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          message,
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
                child: Text("Create Account"),
              ),
              SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "already have an account?",
                    style: TextStyle(color: Colors.white30),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/signin");
                    },
                    child: Text("Sign-in here"),
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
