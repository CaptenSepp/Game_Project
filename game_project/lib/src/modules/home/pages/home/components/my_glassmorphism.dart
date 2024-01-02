import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class MyGlassmorphic extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final double borderRadius;
  final double blur;
  final double border;

  const MyGlassmorphic({
    super.key,
    required this.width,
    required this.height,
    required this.child,
    required this.borderRadius,
    required this.blur,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: width,
      height: height,
      borderRadius: borderRadius,
      blur: blur,
      alignment: Alignment.topCenter,
      border: border,
      linearGradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color.fromARGB(255, 0, 255, 51).withOpacity(0.3),
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
          const Color(0xFFffffff).withOpacity(0.1),
          Color.fromARGB(255, 0, 255, 51).withOpacity(0.9),
        ],
      ),
      child: child,
    );
  }
}
