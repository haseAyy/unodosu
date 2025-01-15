import 'package:flutter/material.dart';
import 'CalcSubtractionScreen.dart'; // 計算問題出題画面
import 'CalcadditionScreen.dart'; // 足し算問題出題画面
import 'CalcSubtractionScreen.dart';//引き算問題出題画面

// 計算問題スタート画面
class CalcStartScreen extends StatelessWidget {
  const CalcStartScreen({super.key});

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
              'assets/images/CalcStartScreen.png',
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
                    'けいさんをまなぼう！', // タイトル
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Dancing Script', // フォントを変更
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                // 遊び方説明文
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(255, 147, 203, 209), width: 1),
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: const Text(
                    'たしざんかひきざんをえらんで\nけいさんもんだいにちょうせんしよう', // 説明文
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontFamily: 'Dancing Script', // フォントを変更
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
                        builder: (context) => CalcadditionScreen(questionCount: questionCount, correctCount: correctCount),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.2,
                      vertical: screenHeight * 0.02,
                    ),
                    backgroundColor: Colors.pink.shade200, // 可愛らしい色に変更
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 10, // 影を強調
                    side: BorderSide(width: 2, color: Colors.white), // ボーダー追加
                  ),
                  child: const Text(
                    'たしざんスタート',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: 'Dancing Script', // フォントを変更
                      fontWeight: FontWeight.bold, // 太字
                    ),
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
                        builder: (context) => CalcSubtractionScreen(questionCount: questionCount, correctCount: correctCount),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.2,
                      vertical: screenHeight * 0.02,
                    ),
                    backgroundColor: Colors.blue.shade300, // 可愛らしい色に変更
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 10, // 影を強調
                    side: BorderSide(width: 2, color: Colors.white), // ボーダー追加
                  ),
                  child: const Text(
                    'ひきざんスタート',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: 'Dancing Script', // フォントを変更
                      fontWeight: FontWeight.bold, // 太字
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
