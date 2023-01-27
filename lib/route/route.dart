// ignore_for_file: prefer_const_constructors

import 'package:flutter_wallpaper_application/CategoryPage/nature_category.dart';
import 'package:flutter_wallpaper_application/Page/nav_controller.dart';
import 'package:flutter_wallpaper_application/Page/nav_home.dart.dart';
import 'package:flutter_wallpaper_application/screen/splash_screen.dart';
import 'package:get/get.dart';

const String splash = "/splash_screen";
const String homeScreen = '/home-screen';
const String bottomNavController='/bottomNav-screen';
const String natureScreen='/nature_screen';

List<GetPage> getPages = [
  GetPage(name: splash, page: () => SplashScreen()),
  GetPage(name: homeScreen, page: () => HomeScreen()),
  GetPage(name: bottomNavController, page: () => BottomNavController()),
  // GetPage(name: bottomNavController, page: () => NatureScreen()),
];