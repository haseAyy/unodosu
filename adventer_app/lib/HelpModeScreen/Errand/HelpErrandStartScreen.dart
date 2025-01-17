import 'package:flutter/material.dart';
import 'HelpErrandScreen.dart';
import 'HelpErrandScreen2.dart';

// おつかい問題スタート画面
class HelpErrandStartScreen extends StatelessWidget {
  const HelpErrandStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Scaffold(
      body: Stack(
        children: [
          // 背景画像
          Positioned.fill(
            child: Image.asset(
              'assets/images/HelpErrandStartScreen.png',
              fit: BoxFit.cover, // 画面全体に広がるように
            ),
          ),
          // コンテンツ部分
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: const Text(
                    'おつかいにでかけよう！', // タイトル
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    int questionCount = 0; // 任意の値をセット
                    int correctCount = 0;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HelpErrandScreen(questionCount: questionCount,correctCount: correctCount),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.2,
                      vertical: screenHeight * 0.02,
                    ),
                    backgroundColor: const Color.fromARGB(255, 255, 123, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'スタート',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}