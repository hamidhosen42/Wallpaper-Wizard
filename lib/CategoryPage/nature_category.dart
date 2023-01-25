// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wallpaper_application/DetailsPage/details_screen.dart';
import 'package:flutter_wallpaper_application/const/app_colors.dart';

class NatureScreen extends StatelessWidget {

  final Stream<QuerySnapshot> _imageStream =
      FirebaseFirestore.instance.collection('images').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text("Nature Wellpaper"),
      //   centerTitle: true,
      //   backgroundColor: AppColors.bg,
      // ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 20,
          bottom: 10,
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
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 10.h,
              ),
              children: snapshot.data!.docs.map(
                (DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
    
                  return Hero(
                    tag: data['img'],
                    child: Material(
                      borderRadius: BorderRadius.circular(10.h),
                      child: Ink(
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
                                builder: (_) => DetailsScreen(
                                  data['img'],
                                ),
                              )),
                        ),
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