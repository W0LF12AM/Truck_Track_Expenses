import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_app_vtwo/Page/Home_Page.dart';
import 'package:note_app_vtwo/settings/screen_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (contex) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    double ukuranWidget = ScreenUtils.getUkuranWidget(context, baseSize: 200);
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          'assets/Note Logo.svg',
          width: ukuranWidget,
          height: ukuranWidget,
        ),
      ),
    );
  }
}
