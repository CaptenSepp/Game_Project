import 'dart:convert';

import 'package:flutter/services.dart';

class ThemeData {
  final String backgroundImage;
  final Color buttonColor;
  List themedatas;

  ThemeData({required this.backgroundImage, required this.buttonColor, required this.themedatas});

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/colors.json');
    final data = await json.decode(response);
    themedatas = data["colors"];
  }

  // static Future<ThemeData> loadThemeData() async {
  //   String jsonString = await rootBundle.loadString('assets/theme_data.json');
  //   Map<String, dynamic> themeData = jsonDecode(jsonString);

  //   String backgroundImagePath = themeData['backgroundImage'];
  //   String buttonColorHex = themeData['buttonColor'];

  //   Color buttonColor = Color(int.parse(buttonColorHex));

  //   return ThemeData(backgroundImage: backgroundImagePath, buttonColor: buttonColor);
  // }
}
