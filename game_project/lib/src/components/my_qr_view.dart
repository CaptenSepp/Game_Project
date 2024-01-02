import 'package:flutter/material.dart';
import 'package:game_project/src/modules/home/components/qr_scan.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class MyQRViewOpacity extends StatelessWidget {
  final void Function(Barcode?) flipCard;
  final void Function(Barcode?) changeBarcodeResult;
  const MyQRViewOpacity({
    super.key,
    required this.flipCard,
    required this.changeBarcodeResult,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.9,
      // TODO i need a very small shadow under this screen
      child: Positioned.fill(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(75),
            child: QRViewExample(
              flipCard: flipCard,
              changeBarcodeResult: changeBarcodeResult,
            ),
          ),
        ),
      ),
    );
  }
}