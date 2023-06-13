import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
class Utils{
  showErrorMsgToast(String customMsg){
    Fluttertoast.showToast(
        msg: customMsg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );

  }
  showSuccessMsgToast(String customMsg){
    Fluttertoast.showToast(
        msg: customMsg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );

  }
}