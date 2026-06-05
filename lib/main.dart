import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'screens/home/main_page.dart';

void main() {
  runApp(const YogaApp());
}

class YogaApp extends StatelessWidget {
  const YogaApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,

      home: const MainPage(),
    );
  }
}