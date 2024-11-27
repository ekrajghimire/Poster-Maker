import 'package:flutter/material.dart';
import 'screens/poster_screen.dart';

void main() {
  runApp(const PosterMakerApp());
}

class PosterMakerApp extends StatelessWidget {
  const PosterMakerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poster Maker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const PosterScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
