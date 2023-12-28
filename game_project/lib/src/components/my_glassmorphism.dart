import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class MyGlassMorphism extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;

  const MyGlassMorphism({
    super.key,
    required this.width,
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: width,
      height: height,
      borderRadius: 20,
      blur: 2,
      alignment: Alignment.topCenter,
      border: 0.5,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color.fromARGB(255, 10, 10, 10).withOpacity(0.4),
          const Color(0xFFFFFFFF).withOpacity(0.0),
        ],
        stops: const [
          0.1,
          1,
        ],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFFffffff).withOpacity(0.15),
          const Color((0xFFFFFFFF)).withOpacity(0.9),
        ],
      ),
      child: child,
    );
  }
}
