import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:game_project/src/constants/map.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  final void Function(Barcode?) flipCard;
  final void Function(Barcode?) changeBarcodeResult;

  const QRViewExample({
    Key? key,
    required this.flipCard,
    required this.changeBarcodeResult,
  }) : super(key: key);

  @override
  State<QRViewExample> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? barcodeResult;
  QRViewController? controller;
  bool canScan = true;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 5, // todo must delete
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(),
            overlayMargin: EdgeInsetsGeometry.infinity,
          ),
        ),
        // Center(
        //   child: (barcodeResult != null) ? Text('Data: ${barcodeResult!.code}') : const Text('Scan a code'),
        // ),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(
        () {
          if (canScan) {
            if (keyExist(scanData.code ?? '')) {
              acceptBarcodeAndShowCart(scanData);
            }
          }
        },
      );
    });
  }

  void acceptBarcodeAndShowCart(Barcode scanBarcodeData) {
    barcodeResult = scanBarcodeData;
    widget.flipCard(scanBarcodeData);
    widget.changeBarcodeResult(scanBarcodeData);
    canScan = false;
    Timer(const Duration(seconds: 2), () {
      canScan = true;
    });
  }

  bool keyExist(String key) {
    return qrToImageMap.containsKey(key);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
