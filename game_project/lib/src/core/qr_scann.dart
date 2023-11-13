import 'package:flutter/material.dart';
import 'package:native_qr/native_qr.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('QR Code Scanner'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Scan a QR code to get information'),
              ElevatedButton(
                onPressed: () async {
                  final scannedQrCode = await scanQrCode();
                  if (scannedQrCode != null) {
                    final qrCodeInfo = await getQrCodeInfo(scannedQrCode.qrcode);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('QR Code Information'),
                        content: Text(qrCodeInfo),
                      ),
                    );
                  } else {
                    // Show an error message to the user.
                  }
                },
                child: Text('Scan QR Code'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Barcode?> scanQrCode() async {
    final scanner = NativeQrScanner();
    final result = await scanner.scan();
    return result;
  }

  Future<String?> getQrCodeInfo(String qrCode) async {
    final parser = QrCodeParser();
    final result = parser.parse(qrCode);
    return result?.data;
  }
}
