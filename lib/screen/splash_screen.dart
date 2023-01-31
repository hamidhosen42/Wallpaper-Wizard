// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, sized_box_for_whitespace, annotate_overrides

import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wallpaper_application/route/route.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 1), vsync: this)
        ..repeat();

  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () => Get.toNamed(bottomNavController));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: 500.w,
            height: 500.h,
            child: Center(
              child: Image.asset(
                'assets/icon/logo1.png',
              ),
            ),
          ),
        ),
      ),
    );
  }
}