import 'dart:async';

import 'package:firebase02/Screen/Home_Screen.dart';
import 'package:firebase02/Screen/Login_Screen.dart';
import 'package:flutter/material.dart';

import '../Utils/Auth.dart';

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({Key? key}) : super(key: key);

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
  @override
  Widget build(BuildContext context) {
    check(context);

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text("Splesh"),
        ),
      ),
    );
  }

  void check(BuildContext context) {

    if(Auth().currentUser(context)==true)
      {
        Timer(Duration(seconds: 3), () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) {
            return Home_Screen();
          }));
        });
      }
    else
      {
        Timer(Duration(seconds: 3), () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) {
            return Login_Screen();
          }));
        });
      }



  }
}
