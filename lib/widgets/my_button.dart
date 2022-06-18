
import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final String text;
  final Color btnColor;
  final double btnRadius;

  MyButton({@required this.text, @required this.btnColor, @required this.btnRadius});

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  double widthLength = 400;
  double hightLength = 45;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      onHover: (value) {
        print(value);
        setState(() {
          widthLength = value?402 :600;
          hightLength = value?47 :45;
        });
      },
      hoverColor: Colors.transparent,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        curve: Curves.easeIn,
        width: widthLength,
        height: hightLength,
        child: Text(
          widget.text,
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        alignment: Alignment.center,
        padding:  const EdgeInsets.symmetric(horizontal: 20.0),
        margin:const  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: widget.btnColor,
          borderRadius: BorderRadius.circular(widget.btnRadius),
        ),
      ),
    );
  }
}