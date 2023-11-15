import 'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {
  final Key? key;
  final String faceName;
  final Color backgroundColor;

  const CustomWidget(
      {this.key, this.faceName = "L", this.backgroundColor = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
        color: backgroundColor,
      ),
      child: Center(
        child: Image.asset("lib/assets/1.png"),
      ),
    );
  }
}
