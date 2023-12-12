import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:game_project/src/constants/values.dart';
import 'package:game_project/src/modules/home/components/image_show_widget.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../components/qr_scan.dart';

class Test extends StatefulWidget {
  const Test({super.key, required this.title});
  final String title;
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  // Variables to store barcode result and card flip information
  Barcode? barcodeResult;
  List<bool> frontSide = [false, false];
  bool _flipXAxis = false;

  void changeBarcodeResult(Barcode? newBarcode) {
    // Check if the new barcode result is different from the current one
    if (barcodeResult != newBarcode) {
      setState(
        () {
          // Update the barcode result and trigger a state change
          barcodeResult = newBarcode;
        },
      );
    }
  }

  Widget _buildFront(int index) {
    return ImageShowWidget(
      // Use a key to track changes in the front side
      key: ValueKey<bool>(frontSide[index]),
      barcodeResult: barcodeResult,
    );
  }

  Widget _buildRear(int index) {
    // create the rear side of a card
    return ImageShowWidget(
      key: ValueKey<bool>(frontSide[index]),
      showImage: false,
      barcodeResult: barcodeResult,
    );
  }

  Widget _buildFlipAnimation(int index) {
    return AnimatedSwitcher(
      // AnimatedSwitcher for smooth transitions between widget changes
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (widget, animation) =>
          __transitionBuilder(widget, animation, _flipXAxis),
      child: frontSide[index] ? _buildFront(index) : _buildRear(index),
    );
  }

  void flipCartWithIndex(int index) {
    setState(
      () {
        frontSide[index] = !frontSide[index];
        _flipXAxis = !_flipXAxis; // Toggle the flipXAxis flag
        if (frontSide[0] && frontSide[1]) {
          Timer(
            Values.duration,
            () {
              //////////////////////////////////////////////////////////////////////
              flipCartWithIndex(0);
              flipCartWithIndex(1);
            },
          );
        }
      },
    );
  }

  void flipCart() {
    setState(
      () {
        if (!frontSide[0]) {
          flipCartWithIndex(0);
        } else if (!frontSide[1]) {
          flipCartWithIndex(1);
        }
      },
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: QRViewExample(
                      flipCart: flipCart,
                      changeBarcodeResult: changeBarcodeResult,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Opacity(
                            opacity: 0.4,
                            child: SizedBox(
                              height: 180,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: _buildFlipAnimation(0)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Opacity(
                            opacity: 0.4,
                            child: SizedBox(
                              height: 180,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: _buildFlipAnimation(1)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
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
                              "Flipped Cards \n\n1    5     4     7\n\n1    5     4     7\n\n1    5     4     7",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold)),
                        ),
                      ),
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
                          child: Text(
                              "    Points\n\n You        5 \n Nick       5 \n Vanes    5 ",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
