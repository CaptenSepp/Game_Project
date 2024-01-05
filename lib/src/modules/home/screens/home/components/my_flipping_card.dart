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
      child: ClipRRect( // TODO, must be tested what happens if this wieget removes
        borderRadius: BorderRadius.circular(40),
        child: child,
      ),
    );
  }
  
}


