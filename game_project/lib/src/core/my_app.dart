import 'package:flutter/material.dart';
import 'package:game_project/src/modules/home/pages/home_page.dart';
import 'package:game_project/src/modules/home/pages/test.dart';

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
      // home: const HomePage(title: 'Memory Mayhem'),
      home: const Test(title: 'Memory Mayhem'),
    );
  }
}
