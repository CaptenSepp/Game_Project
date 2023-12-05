// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
// import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  final void Function() flipCart;

  const QRViewExample({
    Key? key,
    required this.flipCart,
  }) : super(key: key);

  @override
  State<QRViewExample> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool canScan = true;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
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
          child: (result != null)
              ? Text(
                  'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
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
            result = scanData;
            widget.flipCart();
            canScan = false;
            Timer(const Duration(seconds: 2), () {
              canScan = true;
            });
          }
        },
      );
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
