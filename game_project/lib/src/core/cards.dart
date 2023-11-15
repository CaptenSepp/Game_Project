import 'package:flutter/material.dart';

class ImageShowWidget extends StatelessWidget {
  final Key? key;
  final String faceName;
  final Color backgroundColor;
  final bool showImage;

  const ImageShowWidget(
      {this.key,
      this.faceName = "L",
      this.backgroundColor = Colors.blue,
      this.showImage = true});

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
          child: showImage ? Image.asset("lib/assets/1.png") : SizedBox()),
    );
  }
}
