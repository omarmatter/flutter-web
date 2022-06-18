import 'package:cloud_hospital/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../widgets/custom_text.dart';



class Helper {
  static setToast(String msg) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static getSheetError(String title) {
    return EasyLoading.showError(title,maskType: EasyLoadingMaskType.black);

  }

  static getSheetSucsses(String title) {
    return EasyLoading.showSuccess(title,maskType: EasyLoadingMaskType.black,);

  }

  static loading() {
    return Center(
        child: Column(
      children: [
        SizedBox(
          height: 10,
        ),
        CircularProgressIndicator(
          color: primaryColor,
        ),
      ],
    ));
  }

  static var appRaduis = BorderRadius.circular(8);

}
