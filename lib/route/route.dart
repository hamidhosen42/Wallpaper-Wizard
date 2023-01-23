// ignore_for_file: prefer_const_constructors

import 'package:flutter_wallpaper_application/HomeScreen/home_screen.dart';
import 'package:flutter_wallpaper_application/screen/splash_screen.dart';
import 'package:get/get.dart';

const String splash = "/splash_screen";
const String homeScreen = '/home-screen';

List<GetPage> getPages = [
  GetPage(name: splash, page: () => SplashScreen()),
  GetPage(name: homeScreen, page: () => HomeScreen()),
];