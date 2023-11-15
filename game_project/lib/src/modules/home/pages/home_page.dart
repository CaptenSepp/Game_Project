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
  bool _showFrontSide = true;
  //* the second one should be added to the same functionality
  bool _showFrontSide2 = true;
  bool _flipXAxis = false;

  Widget _buildFront() {
    return ImageShowWidget(
      key: ValueKey<bool>(_showFrontSide),
      faceName: "Front",
      backgroundColor: Colors.blue,
    );
  }

  Widget _buildRear() {
    return ImageShowWidget(
      key: ValueKey<bool>(_showFrontSide),
      faceName: "Rear",
      backgroundColor: Colors.red,
      showImage: false,
    );
  }

  Widget _buildFlipAnimation() {
    return GestureDetector(
      onTap: () => setState(() {
        _showFrontSide = !_showFrontSide;
        _flipXAxis = !_flipXAxis; // Toggle the flipXAxis flag
      }),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        transitionBuilder: (widget, animation) =>
            __transitionBuilder(widget, animation, _flipXAxis),
        child: _showFrontSide ? _buildFront() : _buildRear(),
      ),
    );
  }

  Widget __transitionBuilder(
      Widget widget, Animation<double> animation, bool flipXAxis) {
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
            Expanded(
              flex: 3,
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.red,
                    child: const QRViewExample(),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // constraints: BoxConstraints.tight(Size.square(200.0)),
                        child: _buildFlipAnimation(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // constraints: BoxConstraints.tight(Size.square(200.0)),
                        child: _buildFlipAnimation(),
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
                    child: Text("Flipped Cards: 1 - 5 - 4 - 7 ",
                        style: TextStyle(fontSize: 30.0)),
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
                    child: Text(
                        "       Points\nYou ---------------5\nNick --------------5\nVanessa --------5",
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
