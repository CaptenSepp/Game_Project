import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:game_project/src/constants/map.dart';
import 'package:game_project/src/constants/values.dart';
import 'package:game_project/src/modules/home/components/image_show_widget.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../components/qr_scan.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Variables to store barcode result and card flip information
  Barcode? currentResult;
  Barcode? barcodeResult1;
  Barcode? barcodeResult2;

  List<bool> frontSide = [false, false];
  bool _flipXAxis = false;

  void changeBarcodeResult(Barcode? newBarcode) {
    // Check if the new barcode result is different from the current one
    if (currentResult?.code != newBarcode?.code) {
      setState(() {
        // Update the barcode result and trigger a state change
        currentResult = newBarcode;
        if (barcodeResult1 == null) {
          barcodeResult1 = newBarcode;
        } else if (barcodeResult2 == null) {
          barcodeResult2 = newBarcode;
        }
      });
    }
  }

  Widget _buildPhotoSide(int index) {
    return ImageShowWidget(
      // Use a key to track changes in the front side
      key: ValueKey<bool>(frontSide[index]),
      barcodeResult: (index == 0) ? barcodeResult1 : barcodeResult2,
    );
  }

  Widget _buildQuestionSide(int index) {
    // create the rear side of a card
    return ImageShowWidget(
      key: ValueKey<bool>(frontSide[index]),
      showImage: false,
      barcodeResult: barcodeResult1,
    );
  }

  Widget _buildFlipAnimation(int index) {
    return AnimatedSwitcher(
      // AnimatedSwitcher for smooth transitions between widget changes
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (widget, animation) => __transitionBuilder(widget, animation, _flipXAxis),
      child: frontSide[index] ? _buildPhotoSide(index) : _buildQuestionSide(index),
    );
  }

  void flipCardWithIndex(int index) {
    setState(() {
      frontSide[index] = !frontSide[index];
      _flipXAxis = !_flipXAxis; // Toggle the flipXAxis flag
      if (frontSide[0] && frontSide[1]) {
        Timer(Values.showSnackBarDelay, () {
          if (isPhotosMatches()) {
            // TODO: show snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('You find 1 mach.'),
                backgroundColor: Colors.green,
              ),
            );
          }
        });

        Timer(Values.flipBothCardDelay, () {
          //////////////////////////////////////////////////////////////////////
          flipCardWithIndex(0);
          flipCardWithIndex(1);
          clearAllBarcodes();
        });
      }
    });
  }

  void clearAllBarcodes() {
    currentResult = null;
    barcodeResult1 = null;
    barcodeResult2 = null;
  }

  bool isPhotosMatches() {
    return (qrToImage[barcodeResult1?.code] == qrToImage[barcodeResult2?.code]);
  }

  void flipCard(Barcode? barcode) {
    setState(() {
      if (currentResult?.code == barcode?.code) {
        return;
      }
      if (!frontSide[0]) {
        flipCardWithIndex(0);
      } else if (!frontSide[1]) {
        flipCardWithIndex(1);
      }
    });
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: QRViewExample(
                        flipCart: flipCard,
                        changeBarcodeResult: changeBarcodeResult,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    // bottom: -20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Opacity(
                            opacity: 0.6,
                            child: SizedBox(
                              height: 155,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: _buildFlipAnimation(0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Opacity(
                            opacity: 0.6,
                            child: SizedBox(
                              height: 155,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: _buildFlipAnimation(1),
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
                          child: Text("Flipped Cards \n\n1    5     4     7\n\n1    5     4     7\n\n1    5     4     7",
                              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
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
                          child: Text("    Points\n\nYou --------5\nNick -------5\nVanes -----5",
                              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
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
