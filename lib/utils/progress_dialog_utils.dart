import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ProgressDialogUtils {
  static show() {
    EasyLoading.show(status: 'loading...');
  }

  static hide() {
    EasyLoading.dismiss();
  }
}
