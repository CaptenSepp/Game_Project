import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class MyGlassmorphic extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final double borderRadius;

  const MyGlassmorphic({
    super.key,
    required this.width,
    required this.height,
    required this.child,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: width,
      height: height,
      borderRadius: borderRadius,
      blur: 5,
      alignment: Alignment.topCenter,
      border: 1,
      linearGradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color.fromARGB(220, 249, 249, 249).withOpacity(0.4),
          const Color(0xFFFFFFFF).withOpacity(0.0),
        ],
        stops: const [
          0.1,
          1,
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [
          const Color(0xFFffffff).withOpacity(0.15),
          const Color((0xFFFFFFFF)).withOpacity(0.9),
        ],
      ),
      child: child,
    );
  }
}
