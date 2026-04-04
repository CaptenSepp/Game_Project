import 'package:flutter/material.dart';
import 'package:game_project/src/core/models/app_barcode.dart';

class QRViewExample extends StatelessWidget {
  // Keep the same constructor as mobile.
  final void Function(AppBarcode?) flipCard;

  // Keep the same constructor as mobile.
  final void Function(AppBarcode?) changeBarcodeResult;

  // Keep the same constructor as mobile.
  final List<String> matches;

  const QRViewExample({
    Key? key,
    required this.flipCard,
    required this.changeBarcodeResult,
    required this.matches,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      alignment: Alignment.center,
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'QR scanner is not supported on web in this project.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
