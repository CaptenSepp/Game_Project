import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:game_project/src/constants/map.dart';
import 'package:game_project/src/core/models/app_barcode.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  // Send scanned value back to the page.
  final void Function(AppBarcode?) flipCard;

  // Save the current scanned value.
  final void Function(AppBarcode?) changeBarcodeResult;

  // Keep already matched codes blocked.
  final List<String> matches;

  const QRViewExample({
    Key? key,
    required this.flipCard,
    required this.changeBarcodeResult,
    required this.matches,
  }) : super(key: key);

  @override
  State<QRViewExample> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  // This key is required by the scanner widget.
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // Keep controller for pause and dispose.
  QRViewController? controller;

  // Small guard so one scan does not repeat fast.
  bool canScan = true;

  @override
  void reassemble() {
    super.reassemble();

    // Camera handling is different on Android and iOS.
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(),
            overlayMargin: EdgeInsetsGeometry.infinity,
          ),
        ),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    // Store controller for later cleanup.
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) {
      // Stop if this widget is already gone.
      if (!mounted) {
        return;
      }

      setState(() {
        // Stop here if the widget is locked.
        if (!canScan) {
          return;
        }

        // Ignore unknown QR values.
        if (!keyExist(scanData.code ?? '')) {
          return;
        }

        // Ignore cards that were already matched.
        if (!notInMatches(scanData.code ?? '')) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('This card is already matched!!!'),
              backgroundColor: Colors.blueGrey,
            ),
          );

          canScan = false;
          Timer(const Duration(seconds: 2), () {
            canScan = true;
          });
          return;
        }

        acceptBarcodeAndShowCart(
          AppBarcode(code: scanData.code),
        );
      });
    });
  }

  bool notInMatches(String code) {
    return !widget.matches.contains(code);
  }

  void acceptBarcodeAndShowCart(AppBarcode scanBarcodeData) {
    // Update page state with the new scan.
    widget.flipCard(scanBarcodeData);
    widget.changeBarcodeResult(scanBarcodeData);

    // Delay next scan a little bit.
    canScan = false;
    Timer(const Duration(seconds: 2), () {
      // Stop if the widget is already removed.
      if (!mounted) {
        return;
      }

      canScan = true;
    });
  }

  bool keyExist(String key) {
    return qrToImageMap.containsKey(key);
  }

  @override
  void dispose() {
    // Always dispose the camera controller.
    controller?.dispose();
    super.dispose();
  }
}
