import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'Screen/StartScreen.dart';
=======
import 'MeneScreen/StartScreen.dart';
>>>>>>> ayane

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '探検ワールド',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StartScreen(), // アプリ起動時の画面
    );
  }
}
<<<<<<< HEAD

=======
>>>>>>> ayane
