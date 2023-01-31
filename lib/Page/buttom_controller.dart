// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, prefer_final_fields, prefer_const_literals_to_create_immutables, unrelated_type_equality_checks, sized_box_for_whitespace, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wallpaper_application/Page/favorite_screen.dart';
import 'package:flutter_wallpaper_application/Page/nav_home.dart.dart';
import 'package:flutter_wallpaper_application/Page/theme_screen.dart';
import 'package:get/state_manager.dart';

class BottomNavController extends StatefulWidget {
  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  RxInt _currentIndex = 1.obs;

  RxBool _drawer = false.obs;

  final _pages = [
    ThemeScreen(),
    HomeScreen(),
    FavoriteScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 5.0,
          clipBehavior: Clip.antiAlias,
          child: Container(
            height: 50.h,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border(
                  top: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
              ),
              child: BottomNavigationBar(
                  currentIndex: _currentIndex.value,
                  backgroundColor: Colors.white,
                  selectedItemColor: Colors.black,
                  onTap: (value) => _currentIndex.value = value,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.image), label: "Theme"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined), label: ""),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.favorite_outlined),
                        label: "Favorite"),
                  ]),
            ),
          ),
        ),
        body: _pages[_currentIndex.value],
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(5.0),
          child: FloatingActionButton(
            backgroundColor:
                _currentIndex == 1 ? Colors.white : Colors.black,
            child: Icon(Icons.home,color:  _currentIndex == 1 ? Colors.black : Colors.white,),
            onPressed: () => setState(() {
              _currentIndex.value = 1;
            }),
          ),
        ),
      ));
  }
}