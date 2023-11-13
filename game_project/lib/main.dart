import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Memory Mayhem',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Memory Mayhem'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
              child: Container(
                  color: Colors.red,
                  child: Row(
                    children: const [
                      Text("Camera"),
                    ],
                  )),
            ),
            Expanded(
              flex: 3,
              child: Container(
                  color: Colors.blue,
                  child: Row(
                    children: const [
                      Text("To pairing cards"),
                    ],
                  )),
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
