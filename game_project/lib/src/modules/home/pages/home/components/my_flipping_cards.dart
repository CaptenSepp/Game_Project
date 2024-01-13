import 'package:flutter/material.dart';
import 'package:game_project/src/modules/home/pages/home/components/my_flipping_card_base.dart';
import 'package:game_project/src/modules/home/pages/home/components/my_glassmorphism.dart';

class MyFlippingCards extends StatelessWidget {
  final Widget animationAct1;
  final Widget animationAct2;
  const MyFlippingCards({
    super.key,
    required this.animationAct1,
    required this.animationAct2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: MyGlassmorphic(
            width: 150,
            height: 150,
            borderRadius: 40,
            blur: 3,
            border: 1,
            child: MyFlippingCardBase(child: animationAct1),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: MyGlassmorphic(
            width: 150,
            height: 150,
            borderRadius: 40,
            blur: 3,
            border: 1,
            child: MyFlippingCardBase(child: animationAct2),
          ),
        ),
      ],
    );
  }
}
