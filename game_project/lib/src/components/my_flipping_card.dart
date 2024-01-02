import 'package:flutter/material.dart';

class MyFlippingCard extends StatelessWidget {
  const MyFlippingCard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: child,
      ),
    );
  }
}
