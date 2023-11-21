import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../../core/cards.dart';
import '../../../core/qr_scan.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> frontSide = [false, false];
  bool _flipXAxis = false;

  Widget _buildFront(int index) {
    return ImageShowWidget(
      key: ValueKey<bool>(frontSide[index]),
      faceName: "Front",
      backgroundColor: Colors.white,
    );
  }

  Widget _buildRear(int index) {
    return ImageShowWidget(
      key: ValueKey<bool>(frontSide[index]),
      faceName: "Rear",
      backgroundColor: Colors.white,
      showImage: false,
    );
  }

  Widget _buildFlipAnimation(int index) {
    return GestureDetector(
      onTap: () => setState(() {
        frontSide[index] = !frontSide[index];
        _flipXAxis = !_flipXAxis; // Toggle the flipXAxis flag
      }),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        transitionBuilder: (widget, animation) => __transitionBuilder(widget, animation, _flipXAxis),
        child: frontSide[index] ? _buildFront(index) : _buildRear(index),
      ),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation, bool flipXAxis) {
    final rotateAnim = Tween(begin: math.pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final angle = flipXAxis ? -rotateAnim.value : rotateAnim.value;
        return Transform(
          transform: Matrix4.rotationY(angle),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const Text("Hello guys, Are you ready to start!!!"),
            const Expanded(
              flex: 3,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: QRViewExample(),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // constraints: BoxConstraints.tight(Size.square(200.0)),
                        child: _buildFlipAnimation(0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // constraints: BoxConstraints.tight(Size.square(200.0)),
                        child: _buildFlipAnimation(1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.blueGrey,
                  ),
                  child: const Center(
                    child: Text("Flipped Cards: 1 - 5 - 4 - 7 ", style: TextStyle(fontSize: 30.0)),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.blueGrey,
                  ),
                  child: const Center(
                    child: Text("       Points\nYou ---------------5\nNick --------------5\nVanessa --------5",
                        style: TextStyle(fontSize: 40.0)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
