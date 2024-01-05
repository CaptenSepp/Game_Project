import 'package:flutter/material.dart';
<<<<<<< HEAD:Game_Project/game_project/lib/src/core/my_app.dart
import 'package:game_project/src/modules/home/pages/home_page.dart';
=======
import 'package:game_project/src/modules/home/pages/home/home_page.dart';
// import 'package:game_project/src/modules/home/pages/test.dart';
// import 'package:game_project/test.dart';
>>>>>>> a81de356309b82bc8a6f7e7a2d64e3a5eeb59167:game_project/lib/src/core/my_app.dart

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Memory Mayhem',
      theme: ThemeData(
        // primarySwatch: Colors.orange,
      ),
<<<<<<< HEAD:Game_Project/game_project/lib/src/core/my_app.dart
      home: const HomePage(title: 'Memory Mayhem'),
=======
      home: const HomePage(title: ''),
      // home: const Test(title: 'Memory Mayhem'),
>>>>>>> a81de356309b82bc8a6f7e7a2d64e3a5eeb59167:game_project/lib/src/core/my_app.dart
    );
  }
}
