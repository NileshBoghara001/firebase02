import 'package:firebase02/Utils/Auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  TextEditingController txt_email = TextEditingController();
  TextEditingController txt_password = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Firebase.initializeApp().whenComplete(() {});
  }

  @override
  Widget build(BuildContext context) {
    Auth a1 = Auth();
    a1.currentUser(context);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              TextField(
                controller: txt_email,
                decoration: InputDecoration(hintText: "Email"),
              ),
              TextField(
                controller: txt_password,
                decoration: InputDecoration(hintText: "Password"),
              ),
              ElevatedButton(
                onPressed: () {
                  Auth a1 = Auth();
                  a1.singUP(txt_email.text, txt_password.text);
                },
                child: Text("Sign UP"),
              ),
              ElevatedButton(
                onPressed: () {
                  Auth a1 = Auth();
                  a1.signIN(txt_email.text, txt_password.text, context);
                },
                child: Text("Sign IN"),
              ),

              ElevatedButton(
                onPressed: () {
                  Auth a1 = Auth();
                  a1.googleSingIn(context);
                },
                child: Text("Google"),style: ElevatedButton.styleFrom(primary: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
