import 'package:flutter/material.dart';
import 'package:adventer_app/screen/HomeScreen.dart';  // HomeScreenのインポート

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

// スタート画面
class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),  // HomeScreenに遷移
        );
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: screenHeight * 0.9,
              child: Container(color: Colors.lightBlue[300]),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: screenHeight * 0.1,
              child: Container(color: Colors.green),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orangeAccent[200],
                    ),
                    child: const Center(
                      child: Text(
                        'ぼくとわたしの\n探検ワールド',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  const Text(
                    'スタート',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}