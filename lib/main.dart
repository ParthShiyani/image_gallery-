import 'package:flutter/material.dart';
import 'package:image_gallary/screens/home_page.dart';
import 'package:image_gallary/screens/slider_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'homepage',
      routes: {
        'homepage': (context) => const HomePage(),
        'slider': (context) => const Photo_slider(),
      },
    ),
  );
}
