import 'package:flutter/material.dart';

class AppConstants {
  static const String backgroundImage = 'assets/background.png';

  static const TextStyle defaultTextStyle = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    shadows: [
      Shadow(
        blurRadius: 10.0,
        color: Colors.black,
        offset: Offset(5.0, 5.0),
      ),
    ],
  );
}
