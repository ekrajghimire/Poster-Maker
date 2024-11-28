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
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black, // Change app bar color here
          foregroundColor: Colors.white, // Color of the text and icons
          elevation: 4, // Optional: adds a shadow to the app bar
        ),
      ),
      home: const PosterScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
