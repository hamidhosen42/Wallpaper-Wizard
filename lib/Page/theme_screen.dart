// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wallpaper_application/CategoryPage/image_category.dart';
import 'package:flutter_wallpaper_application/DetailsPage/details_screen.dart';

class ThemeScreen extends StatelessWidget {
  final Stream<QuerySnapshot> _imageStream =
      FirebaseFirestore.instance.collection('theme').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  return Hero(
                    tag: data,
                    child: Material(
                      borderRadius: BorderRadius.circular(10.h),
                      child: Stack(
                        children: [
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
                                      builder: (_) => DetailsScreen(data['img'], "Theme"))),
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