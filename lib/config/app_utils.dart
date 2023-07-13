
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../config/dimensions.dart';

class AppUtils {
 
  static void showCustomSnackBar(String message, {bool isError = false}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor:
          isError ? Colors.red : Colors.green,
      textColor: Colors.white,
      fontSize: Dimensions.font16,
    );
  }

 }

