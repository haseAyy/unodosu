import 'package:flutter/material.dart';
import 'LetterEducationScreen.dart'; // 文字問題出題画面

// 文字問題スタート画面
class LetterStartScreen extends StatelessWidget {
  const LetterStartScreen({super.key});

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
              'assets/images/LetterStartScreen.png', // 絵の具の背景画像を配置
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
                    'もじをまなぼう！', // タイトル
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                // 遊び方説明文
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(255, 151, 209, 147), width: 1),
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: const Text(
                    'もんだいとおなじことばを\nこたえからえらぼう', // 説明文
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    int questionCount = 0;  // 任意の値をセット
                    int correctCount = 0;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LetterEducationScreen(questionCount: questionCount,correctCount: correctCount),
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