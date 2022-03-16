import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

class MixedClass {
  Future<File> saveFile(String url, title) async {
    var file = await DefaultCacheManager().getSingleFile(url);
    File _file = File(file.path);
    var basenam = basename(_file.path);
    var ext = basenam.split(".")[1];
    final filePath =
        '${(await getExternalStorageDirectory())?.path.replaceAll("Android/data/com.instax/files", '')}instax/$title[s].$ext';
    print(filePath);
    return File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytes(file.readAsBytesSync());
  }

  Future checkPermission() async {
    Permission.manageExternalStorage.request();
    Permission status = Permission.storage;
    if (await status.isLimited) {
      Fluttertoast.showToast(msg: "Please Allow Storage Permission");
      status.request().then((value) {
        if (value.isDenied) {
          Fluttertoast.showToast(
              msg: "Please Allow Storage Permission For Set Wallpaper");
          status.request();
        } else if (value.isGranted) {
          Fluttertoast.showToast(msg: "Welcome To Refox Wallpaper App");
        }
      });
    } else if (await status.isDenied) {
      Fluttertoast.showToast(
          msg: "Please Allow Storage Permission For Set Wallpaper");
      status.request().then((value) {
        if (value.isDenied) {
          Fluttertoast.showToast(
              msg: "Please Allow Storage Permission For Set Wallpaper");
          status.request();
        } else if (value.isGranted) {
          Fluttertoast.showToast(msg: "Welcome To Refox Wallpaper App");
        }
      });
    } else if (await status.isPermanentlyDenied) {
      Fluttertoast.showToast(
          msg:
              "Go to Setting app manager and allow storage permission to access wallpapers");
      status.request().then((value) {
        if (value.isDenied) {
          Fluttertoast.showToast(
              msg: "Please Allow Storage Permission For Set Wallpaper");
          status.request();
        } else if (value.isGranted) {
          Fluttertoast.showToast(msg: "Welcome To Refox Wallpaper App");
        }
      });
    } else if (await status.isRestricted) {
      Fluttertoast.showToast(
          msg:
              "Go to Setting app manager and allow storage permission to access wallpapers");
      status.request().then((value) {
        if (value.isDenied) {
          Fluttertoast.showToast(
              msg: "Please Allow Storage Permission For Set Wallpaper");
          status.request();
        } else if (value.isGranted) {
          Fluttertoast.showToast(msg: "Welcome To Refox Wallpaper App");
        }
      });
    } else if (await status.isGranted) {
      // Fluttertoast.showToast(
      //   msg: "Welcome Back!",
      // );
    }
  }

  void createFolder() async {
    Directory? baseDir = await getExternalStorageDirectory(); //only for Android
    // Directory baseDir = await getApplicationDocumentsDirectory(); //works for both iOS and Android
    String dirToBeCreated = "instaxdl";
    String finalDir = join(
        baseDir!.path.replaceAll("Android/data/com.instaxdl/files", ''),
        dirToBeCreated);
    var dir = Directory(finalDir);
    bool dirExists = await dir.exists();
    if (!dirExists) {
      dir.create(
          recursive:
              true /*recursive=true*/); //pass recursive as true if directory is recursive
    }
    //Now you can use this directory for saving file, etc.
    //In case you are using external storage, make sure you have storage permissio
  }

  // Future<bool> setVisitingBool() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   return await preferences.setBool("Visited", true);
  // }

  // Future<bool> allreadyVisitingBool() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();

  //   bool data = preferences.getBool("Visited") ?? false;
  //   return data;
  // }

}
