import 'package:flutter/material.dart';
import 'package:game_project/src/core/models/app_barcode.dart';
import 'package:game_project/src/modules/home/components/qr_scan.dart';

class MyQRViewOpacity extends StatelessWidget {
  final void Function(AppBarcode?) flipCard;
  final void Function(AppBarcode?) changeBarcodeResult;
  final List<String> matches;

  const MyQRViewOpacity({
    super.key,
    required this.flipCard,
    required this.changeBarcodeResult,
    required this.matches,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.9,
      // TODO i need a very small shadow under this screen
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 2, 10, 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: QRViewExample(
            flipCard: flipCard,
            changeBarcodeResult: changeBarcodeResult,
             matches: matches,
          ),
        ),
      ),
    );
  }
}
