
import 'dart:ui';

import 'package:flutter/material.dart';

import '../constants/style.dart';
import 'custom_text.dart';




class CustomButton extends StatelessWidget {
  final String title;
  final Function onTap;
  final double width;
  final double height;
  final Color btnColor;

  CustomButton(
      {this.title, this.onTap, this.width, this.height, this.btnColor});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: width ?? 335,
            height: height ?? 48,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
              color: btnColor ??primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: CustomText(
              text:  title ?? "",
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
