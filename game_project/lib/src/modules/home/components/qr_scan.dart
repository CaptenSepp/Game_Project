import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_project/src/constants/map.dart';
import 'package:game_project/src/modules/home/components/image_show_widget.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  final void Function() flipCart;
  final void Function(Barcode?) changeBarcodeResult;

  const QRViewExample({
    Key? key,
    required this.flipCart,
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

  //* In order to get hot reload to work we need to pause the camera if the platform
  //* is android, or resume the camera if the platform is iOS.
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
          flex: 5,
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(),
          ),
        ),
        Center(
          child: (barcodeResult != null)
              ? Text('Data: ${barcodeResult!.code}')
              //* Barcode Type: ${describeEnum(result!.format)}
              : const Text('Scan a code'),
        ),
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
              if (barcodeResult != null && (barcodeResult?.code != (scanData.code ?? ''))) {
                barcodeResult = scanData;
                widget.flipCart();
                widget.changeBarcodeResult(scanData);
                canScan = false;
                Timer(const Duration(seconds: 2), () {
                  canScan = true;
                });
              } else if (barcodeResult == null) {
                barcodeResult = scanData;
                widget.flipCart();
                widget.changeBarcodeResult(scanData);
                canScan = false;
                Timer(const Duration(seconds: 2), () {
                  canScan = true;
                });
              }
            }
          }
        },
      );
    });
  }

  bool keyExist(String key) {
    return qrToImage.containsKey(key);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
