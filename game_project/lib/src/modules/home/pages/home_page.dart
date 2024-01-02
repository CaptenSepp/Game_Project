import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:game_project/src/components/my_animated_background.dart';
import 'package:game_project/src/components/my_flipping_card.dart';
import 'package:game_project/src/constants/map.dart';
import 'package:game_project/src/constants/values.dart';
import 'package:game_project/src/modules/home/components/image_show_widget.dart';
import 'package:game_project/src/modules/home/components/qr_scan.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../components/my_flippedcards_gridview.dart';
import '../../../components/my_glassmorphism.dart';
import '../../../components/my_leaderboard_listview.dart';

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
  // created a method which calculates the number of rows and columns each time
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

        // to add to flipped and toShowList Lists in values
        flippedCards.add(barcodeResult1!.code!);
        flippedCards.add(barcodeResult2!.code!);
        toShowCards.remove(barcodeResult1!.code!);
        toShowCards.remove(barcodeResult2!.code!);
        columnCountCalculator();
      }
    }
  }

  // here we calculate how many columns we need for flipped cards
  void columnCountCalculator() {
    // here get checked how many cards are remaining not flipped
    if (toShowCards.length <= 20 && toShowCards.length > 12) {
      columnCount = 5; //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!------------------------------------
    } else if (toShowCards.length <= 12 && toShowCards.length > 6) {
      columnCount = 4;
    } else if (toShowCards.length <= 6 && toShowCards.length > 2) {
      columnCount = 3;
      // TODO here it should be a error catcher which the numbers doesn't go something fully wrong
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
        // TODO we must flip, if new barcode is not the old barcode.
        return;
        // TODO we also must add: don't flip the card if its in the List of flipped cards in the map.dart
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
    return Stack(
      children: [
        //?----------------------- background Image -----------------------------
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/bg (10).png"), fit: BoxFit.cover),
            ),
          ),
        ),
        Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,

          //?----------------------- App bar -----------------------------
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              widget.title,
              style: const TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                alignment: Alignment.topLeft,
                onPressed: restartAndShuffle,
                icon: const Icon(
                  Icons.refresh_rounded,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ],
          ), //?----------------------- Animated background  -----------------------------
          body: MyAnimatedBackground(child: homepageBody()),
        ),
      ],
    );
  }

  //?----------------------- Scaffolds body -----------------------------
  Padding homepageBody() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            flex: 13,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                //?----------------------- QR Scanner camera -----------------------------
                Opacity(
                  opacity: 0.9,
                  // TODO i need a very small shadow under this screen
                  child: Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(75),
                        child: QRViewExample(
                          flipCart: whichCardMustFlip,
                          changeBarcodeResult: changeBarcodeResult,
                        ),
                      ),
                    ),
                  ),
                ),
                //?----------------------- Leader-board  -----------------------------
                const Positioned(
                  top: 50,
                  left: -25, //* -30 left side out of the screen
                  child: MyGlassmorphic(
                    width: 120,
                    height: 170,
                    borderRadius: 20,
                    child: MyLeaderboardListView(),
                  ),
                ),
                Positioned(
                  // bottom: 0, // TODO i don't know what this line is for
                  bottom: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    //?----------------------- Flipping Cards -----------------------------
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: MyGlassmorphic(
                          width: 150,
                          height: 150,
                          borderRadius: 20,
                          child: MyFlippingCard(child: _buildFlipAnimationAct(0)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: MyGlassmorphic(
                          width: 150,
                          height: 150,
                          borderRadius: 20,
                          child: MyFlippingCard(child: _buildFlipAnimationAct(1)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            //?----------------------- Flipped Cards -----------------------------
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: MyFlippedcardsGridview(columnCount: columnCount, gridAspectRatio: gridAspectRatio),
            ),
          ),
        ],
      ),
    );
  }

  double get gridAspectRatio => 1.5; // TODO, Arman i tried to put this method up with others but i get an error for that
  // TODO, generally i want to get all the information, profesionally from another file like Constant.dart or such
}
