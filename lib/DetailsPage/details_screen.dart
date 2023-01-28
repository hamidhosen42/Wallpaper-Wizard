// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, unused_local_variable, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

import '../const/app_colors.dart';

class DetailsScreen extends StatefulWidget {
  String imgUrl,name;
  DetailsScreen(this.imgUrl, this.name);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final firestore = FirebaseFirestore.instance.collection('favorite');

  setWallpaperHomeScreen(url) async {
    try {
      int location = WallpaperManager.HOME_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(url);
      await WallpaperManager.setWallpaperFromFile(file.path, location);
      Fluttertoast.showToast(msg: 'set successfully');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed');
    }
  }

  setWallpaperLockScreen(url) async {
    try {
      int location = WallpaperManager.LOCK_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(url);
      await WallpaperManager.setWallpaperFromFile(file.path, location);
      Fluttertoast.showToast(msg: 'set successfully');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed');
    }
  }

  downloadWallpaper(url) async {
    try {
      var imageId =
          await ImageDownloader.downloadImage(url).catchError((error) {
        if (error is PlatformException) {
          var path = "";
          if (error.code == "404") {
            Fluttertoast.showToast(msg: 'Not Found Error.');
          } else if (error.code == "unsupported_file") {
            Fluttertoast.showToast(msg: 'UnSupported FIle Error.');
            path = error.details["unsupported_file_path"];
          }
        }
      });
      if (imageId == null) {
        return;
      } else {
        var path = await ImageDownloader.findPath(imageId);
        Fluttertoast.showToast(msg: 'image saved to: $path');
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'failed',
      );
    }
  }

  shareImage(url) {
    Share.share(
      url,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        labelsBackgroundColor: AppColors.vividYellow,
        labelsStyle: TextStyle(
          fontWeight: FontWeight.w600,
        ),
        speedDialChildren: [
          SpeedDialChild(
            child: const Icon(
              Icons.wallpaper,
              size: 18,
            ),
            label: 'Set Homescreen',
            onPressed: () => setWallpaperHomeScreen(widget.imgUrl),
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.lock,
              size: 18,
            ),
            label: 'Set Lockscreen',
            onPressed: () => setWallpaperLockScreen(widget.imgUrl),
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.cloud_download,
              size: 18,
            ),
            label: 'Download',
            onPressed: () => downloadWallpaper(widget.imgUrl),
          ),
          SpeedDialChild(
            child: const Icon(
              Icons.share,
              size: 18,
            ),
            label: 'Share',
            onPressed: () => shareImage(widget.imgUrl),
          ),
        ],
        child: const Icon(
          Icons.add_circle_outline_outlined,
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.imgUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
           top: 100.h,
           right: 40.w,
            child: IconButton(
                onPressed: () {
                  setState(() {
                  //  String id = DateTime.now().microsecondsSinceEpoch.toString();
                   firestore.doc().set({'img':widget.imgUrl,'name':widget.name}).then((value) {
                    Fluttertoast.showToast(msg: 'Add Favorite');
                   }).onError((error, stackTrace){
                    Fluttertoast.showToast(msg: error.toString());
                   });
                  });
                },
                icon: Icon(
                  Icons.favorite_outline,
                  color: Colors.white,
                  size: 40,
                )),
          ),
        ],
      ),
    );
  }
}
