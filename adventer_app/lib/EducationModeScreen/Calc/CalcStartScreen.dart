import 'package:flutter/material.dart';
import 'CalcEducationScreen.dart'; // 計算問題出題画面

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
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalcEducationScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.2,
                      vertical: screenHeight * 0.02,
                    ),
                    backgroundColor: const Color.fromARGB(255, 255, 153, 58),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'たしざんスタート',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalcEducationScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.2,
                      vertical: screenHeight * 0.02,
                    ),
                    backgroundColor: const Color.fromARGB(255, 255, 88, 88),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'ひきざんスタート',
                    style: TextStyle(
                      fontSize: 25,
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