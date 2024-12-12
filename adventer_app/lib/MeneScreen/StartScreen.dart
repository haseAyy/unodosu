import 'package:flutter/material.dart';
import 'HomeScreen.dart';

// スタート画面
class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height; // MediaQueryキャッシュ
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      },
      child: Scaffold(
        body: Stack(
          children: [
            // 背景カラー1（上部の水色）
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: screenHeight * 0.9, // 上部90%
              child: Container(color: Colors.lightBlue[300]),
            ),
            // 背景カラー2（下部の緑色）
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: screenHeight * 0.1, // 下部10%
              child: Container(color: Colors.green),
            ),
            // ロゴとスタートテキスト
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min, // 中央にまとめて配置
                children: [
                  // ロゴ部分
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
                  const SizedBox(height: 70), // ロゴとテキストの間隔
                  // スタートテキスト
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