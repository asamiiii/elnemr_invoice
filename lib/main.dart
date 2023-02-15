import 'package:elnemr_invoice/core/theme.dart';
import 'package:flutter/material.dart';

import 'screens/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'فواتير أولاد النمر',
      theme: theme,
      home: const HomePage(),
    );
  }
}

