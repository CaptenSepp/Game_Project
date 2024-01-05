// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:game_project/src/constants/map.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ImageShowWidget extends StatelessWidget {
  // ignore: annotate_overrides, overridden_fields
  final Key key;
  final bool showImage;
  final Barcode? barcodeResult;

  const ImageShowWidget({
    required this.key,
    this.showImage = true,
    required this.barcodeResult, // New parameter
  });

  String getValueForKey(String key, Map<String, String> qrToImage) {
    return qrToImage[key] ?? ""; // Return empty string if key does not exist
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(
        child: showImage ? Image.asset(getValueForKey(barcodeResult?.code ?? "", qrToImageMap)) : Image.asset("assets/qmark card20.png"),
      ),
    );
  }
}
