// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: CircleAvatar(
              radius: 50.sp,
              backgroundImage: AssetImage(
                'assets/icon/Hamid.jpg',
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            "Md.Hamid Hosen",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "East Delta University",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Center(
              child: Container(
                child: Text(
                  "Abdullah Al Noman Road, Noman Society, Chattogram 4209",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "hamidhosen8444@gmail.com",
            style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.github,
                    color: Colors.white,
                    size: 30.sp,
                  )),
              IconButton(
                  onPressed: () async {},
                  icon: Icon(
                    FontAwesomeIcons.linkedin,
                    color: Colors.white,
                    size: 30.sp,
                  )),
            ],
          )
        ],
      ),
    );
  }
}