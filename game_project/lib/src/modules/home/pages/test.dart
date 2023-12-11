import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key, required this.title});
  final String title;
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stack Example'),
      ),
      body: Stack(
        children: [
          Container(
            width: 600.0,
            height: 600.0,
            color: Colors.blue,
          ),
          Opacity(
            opacity: 0.4,
            child: Container(
              width: 200,
              height: 200,
              color: Colors.red,
              margin: const EdgeInsets.only(left: 80),
            ),
          ),
          Opacity(
            opacity: 0.4,
            child: Container(
              width: 300,
              height: 300,
              color: Colors.black,
              margin: const EdgeInsets.only(left: 180),
            ),
          ),
        ],
      ),
    );
  }
}
