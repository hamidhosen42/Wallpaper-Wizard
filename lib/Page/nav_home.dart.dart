// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wallpaper_application/CategoryPage/image_category.dart';
import 'package:flutter_wallpaper_application/const/app_strings.dart';
import 'package:flutter_wallpaper_application/route/route.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final Stream<QuerySnapshot> _imageStream =
      FirebaseFirestore.instance.collection('home').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.AppName,
          style: TextStyle(fontSize: 25.sp),
        ),
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
                onPressed: () {
                  Get.toNamed(profileScreen);
                },
                icon: Icon(
                  Icons.person,
                  size: 25.sp,
                )),
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 5,
          bottom: 5,
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: _imageStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

            return GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 2,
                mainAxisSpacing: 10.h,
                // crossAxisSpacing: 10.h,
              ),
              children: snapshot.data!.docs.map(
                (DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  var name = data['name'];
                  return Hero(
                    tag: data,
                    child: Material(
                      borderRadius: BorderRadius.circular(10.h),
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.center,
                              child: Text(
                                name,
                                style: TextStyle(
                                    fontSize: 25.sp, color: Colors.white),
                              )),
                          Ink(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.h),
                              image: DecorationImage(
                                image: NetworkImage(
                                  data['img'],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () => Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (_) => CategoryScreen(name))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ).toList(),
            );
          },
        ),
      ),
    );
  }
}