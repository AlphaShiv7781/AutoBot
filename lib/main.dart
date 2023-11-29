import 'package:chat_bot/color_pallete.dart';
import 'package:chat_bot/home_page.dart';
import 'package:chat_bot/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chatGPT/providers/model_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const SplashScreen(),
      theme: ThemeData.light(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Pallete.whiteColor,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white
        )
      ),
    );
  }
}
