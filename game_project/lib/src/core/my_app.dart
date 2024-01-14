import 'package:flutter/material.dart';
import 'package:game_project/src/modules/home/pages/home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Memory Mayhem',
      theme: ThemeData(),
      home: const HomePage(title: ''),
    );
  }
}
