import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:game_project/src/constants/map.dart';
import 'package:game_project/src/constants/values.dart';
import 'package:game_project/src/modules/home/components/image_show_widget.dart';
import 'package:game_project/src/modules/home/components/qr_scan.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:animated_background/animated_background.dart';
import 'package:glassmorphism/glassmorphism.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // Variables to store barcode result and card flip information

  Barcode? currentBarcodeResult; // stores the barcode
  Barcode? barcodeResult1; // first card
  Barcode? barcodeResult2; // second card

  List<bool> frontSide = [false, false]; // front side which we see, false means question, true means Photo
  List<String> matches = [];
  bool _flipXAxis = false;
  // created a methodd which calculates the number of rows and columns each time
  int itemCount = 0;
  int columnCount = 0;

  @override
  void initState() {
    columnCountCalculator();
    // shuffleMapValues(qrToImageMap);
    super.initState();
  }

  void restartAndShuffle() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Restart the Game"),
        content: const Text("Are you sure you want to restart the Game?"),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                clearAllBarcodes();
                frontSide = [false, false];
                matches = [];
                _flipXAxis = false;
                shuffleMapValues(qrToImageMap);
                Navigator.of(context).pop();
              });
            },
            child: const Text("Restart and Shuffle!!!"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("No"),
          )
        ],
      ),
    );
  }

  void changeBarcodeResult(Barcode? newBarcode) {
    // Check if the new barcode result is different from the current one
    if (currentBarcodeResult?.code != newBarcode?.code) {
      // if you want to change to not be same barcode as before, then check here, means new must be different than current barcode
      setState(() {
        // Update the barcode result and trigger a state change
        currentBarcodeResult = newBarcode;
        if (barcodeResult1 == null) {
          barcodeResult1 = newBarcode;
          // ignore: prefer_conditional_assignment
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
        barcodeResult: (index == 0) ? barcodeResult1 : barcodeResult2);
  }

  Widget _buildQuestionSide(int index) {
    // create the rear side of a card
    return ImageShowWidget(
      key: ValueKey<bool>(frontSide[index]),
      showImage: false,
      barcodeResult: barcodeResult1,
    );
  }

  Widget _buildFlipAnimationAct(int index) {
    return AnimatedSwitcher(
      // AnimatedSwitcher for smooth transitions between widget changes
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (widget, animation) => __transitionBuilder(widget, animation, _flipXAxis),
      child: frontSide[index] ? _buildPhotoSide(index) : _buildQuestionSide(index),
    );
  }

  void flipCardWithIndex(int index) {
    setState(() {
      frontSide[index] = !frontSide[index]; // flips any index we give to it, from true to false from false to true
      _flipXAxis = !_flipXAxis; // Toggle the flipXAxis flag
      if (frontSide[0] && frontSide[1]) {
        Timer(Values.showSnackBarDelay, () {
          if (doesPhotosMatch()) {
            // check if both photos (values) matching
            addToMatches();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('You found 1 match!!!'),
                backgroundColor: Colors.green,
              ),
            );
          }
        });

        Timer(Values.flipBothCardDelay, () {
          flipCardWithIndex(0);
          flipCardWithIndex(1);
          clearAllBarcodes();
        });
      }
    });
  }

  void clearAllBarcodes() {
    currentBarcodeResult = null;
    barcodeResult1 = null;
    barcodeResult2 = null;
  }

  void shuffleMapValues(Map<String, String> map) {
    final List<String> keys = map.keys.toList();
    final List<String> values = map.values.toList();
    final math.Random random = math.Random();

    // Shuffle the keys
    keys.shuffle(random);
    values.shuffle(random);

    // Create a new map with shuffled values
    final Map<String, String> shuffledMap = {};
    for (int i = 0; i < keys.length; i++) {
      shuffledMap[keys[i]] = values[i];
    }

    // Update the original map with shuffled values
    map.clear();
    map.addAll(shuffledMap);
  }

  void addToMatches() {
    if (barcodeResult1 != null && barcodeResult2 != null) {
      if (barcodeResult1?.code != null && barcodeResult2?.code != null) {
        matches.add(barcodeResult1!.code!);
        matches.add(barcodeResult2!.code!);

        // to add to flipped and toShowlist Lists in values
        flippedCards.add(barcodeResult1!.code!);
        flippedCards.add(barcodeResult2!.code!);
        toShowCards.remove(barcodeResult1!.code!);
        toShowCards.remove(barcodeResult2!.code!);
        columnCountCalculator();
      }
    }
  }

  // here we calculate how many columns we need for flipped cardds
  void columnCountCalculator() {
    // here get checked how many cards are remaining unflipped
    if (toShowCards.length <= 20 && toShowCards.length > 12) {
      columnCount = 5;
    } else if (toShowCards.length <= 12 && toShowCards.length > 6) {
      columnCount = 4;
    } else if (toShowCards.length <= 6 && toShowCards.length > 2) {
      columnCount = 3;
      // todo here it should be a error catcher which the numbers doesnt go something fully wrong
    } else {
      columnCount = 2;
    }
  }

  Color getBackgroundColorMatches(int index) {
    if (matches.contains(index.toString())) {
      return Colors.green;
    } else {
      return Colors.orangeAccent;
    }
  }

  bool doesPhotosMatch() {
    return (qrToImageMap[barcodeResult1?.code] == qrToImageMap[barcodeResult2?.code]);
  }

  void whichCardMustFlip(Barcode? barcode) {
    setState(() {
      if (currentBarcodeResult?.code == barcode?.code) {
        // todo we must flip, if new barcode is not the old barcode.
        return;
        // todo we also must add: dont flip the card if its in the List of flipped cards in the map.dart
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

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(onPressed: restartAndShuffle, icon: const Icon(Icons.refresh_rounded)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(children: [
        Container(child: Image.asset("assets/bg.png")),
        AnimatedBackground(
          behaviour: RandomParticleBehaviour(
            options: const ParticleOptions(
              spawnMaxRadius: 80,
              spawnMinRadius: 40,
              spawnMaxSpeed: 250,
              spawnMinSpeed: 100,
              particleCount: 20,
              maxOpacity: .8,
              minOpacity: .5,

              // spawnOpacity: 0.6,
              // baseColor: Colors.red,
              image: Image(image: AssetImage('assets/q.png')),
            ),
          ),
          vsync: this as TickerProvider,
          child: Center(
            child: bodyCreator(),
          ),
        )
      ] ////////////////////////////////////////
          ),
    );
  }

  Padding bodyCreator() {
    return Padding(
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Opacity(
                        opacity: 0.9,
                        child: QRViewExample(
                          flipCart: whichCardMustFlip,
                          changeBarcodeResult: changeBarcodeResult,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // bottom: 0,
                  bottom: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: GlassmorphicContainer(
                          width: 150,
                          height: 150,
                          borderRadius: 10,
                          blur: 5,
                          alignment: Alignment.bottomCenter,
                          border: 0,
                          linearGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 98, 41, 230).withOpacity(0.3),
                              Color(0xFFFFFFFF).withOpacity(0.0),
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
                              Color(0xFFffffff).withOpacity(0.15),
                              Color((0xFFFFFFFF)).withOpacity(0.9),
                            ],
                          ),
                          child: SizedBox(
                            height: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: _buildFlipAnimationAct(0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Opacity(
                          opacity: 0.7,
                          child: SizedBox(
                            height: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: _buildFlipAnimationAct(1),
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
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Opacity(
                    opacity: 0.8,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Center(
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: columnCount,
                            crossAxisSpacing: 1.0,
                            mainAxisSpacing: 1.0,
                          ),
                          itemCount: toShowCards.length, // TODO itemCount: itemCount, define up in the code
                          itemBuilder: (context, index) {
                            int cardNumber = int.parse(toShowCards[index]);
                            return Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white.withOpacity(0.5), spreadRadius: 1, blurRadius: 3, offset: const Offset(0, 2))
                                  ],
                                  // todo we dont need this anymore
                                  color: getBackgroundColorMatches(cardNumber),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.orange, width: 3.0),
                                ),
                                child: Center(
                                  child: Text(
                                    '${cardNumber}',
                                    style: const TextStyle(
                                      fontSize: 26.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Opacity(
                    opacity: 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Colors.white.withOpacity(0.5), spreadRadius: 1, blurRadius: 3, offset: const Offset(0, 2))
                          ],
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.orangeAccent,
                        ),
                        child: Center(
                          child: ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  // border: Border.all(color: Colors.white, width: 2.0),
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}' " Player",
                                    style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   Color(0xFF74EBD5),
//                   Color(0xFFACD8AA),
//                 ],
//               ),
//             ),
//           ),