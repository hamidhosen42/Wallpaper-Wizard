// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable, unused_local_variable, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wallpaper_application/DetailsPage/details_screen.dart';


class CategoryScreen extends StatelessWidget {
  String name;

  CategoryScreen(this.name);

  final _imageStream =
      FirebaseFirestore.instance.collection("image").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text(name,style: TextStyle(fontSize: 25.sp)),
      //   centerTitle: true,
      //   backgroundColor: AppColors.bg,
      // ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 5,
          bottom: 5,
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("image")
              .doc(name)
              .snapshots(),
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (snapshot.hasError) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return setUserData(data, context);
          },
        ),
      ),
    );
  }

  setUserData(data, context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 10.h,
      ),
      itemCount: data['img'].length,
      itemBuilder: (context, index) {
        return Material(
          borderRadius: BorderRadius.circular(5.h),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.h),
              image: DecorationImage(
                image: NetworkImage(
                 data['img'][index],
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => DetailsScreen(
                      data['img'][index],
                      name
                    ),
                  )),
            ),
          ),
        );
      },
    );
  }
}