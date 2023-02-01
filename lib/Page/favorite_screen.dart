// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final Stream<QuerySnapshot> _imageStream =
      FirebaseFirestore.instance.collection('favorite').snapshots();

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
                  var name = data['name'];
                  var id = data['id'];

                  return Material(
                    borderRadius: BorderRadius.circular(10.h),
                    child: Container(
                        height: 200.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.h),
                          image: DecorationImage(
                            image: NetworkImage(
                              data['img'],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      FirebaseFirestore.instance
                                          .collection('favorite')
                                          .doc(id)
                                          .delete()
                                          .then((value) {
                                        Fluttertoast.showToast(
                                            msg:
                                                'Delete ${name} theme');
                                      }).onError((error, stackTrace) {
                                        Fluttertoast.showToast(
                                            msg: error.toString());
                                      });
                                    });
                                  },
                                  icon: Icon(Icons.delete_sharp,
                                      color: Colors.red, size: 30.sp)),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(data['name'],
                                  style: TextStyle(
                                      fontSize: 25.sp,
                                      color: Colors.white)),
                            ],
                          ),
                        )),
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