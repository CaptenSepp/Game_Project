import 'package:flutter/material.dart';
import 'package:game_project/src/constants/map.dart';
import 'package:game_project/src/core/models/app_barcode.dart';

class ImageShowWidget extends StatelessWidget {
  final bool showImage;
  final AppBarcode? barcodeResult;

  const ImageShowWidget({
    super.key,
    this.showImage = true,
    required this.barcodeResult,
  });

  String getValueForKey(String key, Map<String, String> qrToImage) {
    // Return an empty value if the code was not found.
    return qrToImage[key] ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(
        child: showImage
            ? Image.asset(getValueForKey(barcodeResult?.code ?? "", qrToImageMap))
            : Image.asset("assets/qmark card20.png"),
      ),
    );
  }
}
