import 'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {
  final Key? key;
  final String faceName;
  final Color backgroundColor;

  CustomWidget(
      {this.key, this.faceName = "R", this.backgroundColor = Colors.blue});

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
        child: Text(
          faceName.substring(0, 1),
          style: const TextStyle(fontSize: 80.0),
        ),
      ),
    );
  }
}
