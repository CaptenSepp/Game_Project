import 'package:flutter/material.dart';

import '../constants/map.dart';
import 'my_glassmorphism.dart';

class MyFlippedcardsGridview extends StatelessWidget {
  const MyFlippedcardsGridview({
    super.key,
    required this.columnCount,
    required this.gridAspectRatio,
  });

  final int columnCount;
  final double gridAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      // shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0), // must be there because of the lag of gridView
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columnCount,
        childAspectRatio: gridAspectRatio,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 1.0,
      ),
      itemCount: toShowCards.length, // todo itemCount, define up in the code
      itemBuilder: (context, index) {
        int cardNumber = int.parse(toShowCards[index]);
        return Padding(
          padding: const EdgeInsets.all(1.0),
          child: MyGlassmorphic(
            width: double.infinity,
            height: double.infinity,
            borderRadius: 10,
            child: Center(
              child: Text(
                '$cardNumber',
                style: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white60,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
