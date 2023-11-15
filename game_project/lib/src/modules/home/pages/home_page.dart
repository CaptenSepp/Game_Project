import 'package:flutter/material.dart';

import '../../../core/qr_scan.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // void _incrementCounter() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const Text("Hello guys, Are you ready to start!!!"),
            Expanded(
              flex: 3,
              child: InkWell(
                child: Container(
                  color: Colors.red,
                  child: const QRViewExample(),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue,
                child: Row(
                  children: const [
                    Text("To pairing cards"),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.green,
                child: Row(
                  children: const [
                    Text("Already flipped cards/ not working QR-codes"),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.yellow,
                child: Row(
                  children: const [
                    Text("players points"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
