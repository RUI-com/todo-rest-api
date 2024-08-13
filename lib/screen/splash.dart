// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/todo_list.dart';
import 'package:flutter_application_1/theme/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 11000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => TodoListPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          "assets/logo/Todo_icon.svg",
          color: textColorW,
        ),
      ),
    );
  }
}
