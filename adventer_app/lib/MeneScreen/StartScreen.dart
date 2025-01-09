import 'package:flutter/material.dart';
import 'HomeScreen.dart'; // 遷移先の画面

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

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
            // 背景（白基調にアクセントカラーを追加）
            Positioned.fill(
              child: Container(
                color: Colors.white,
              ),
            ),
            // 上部のデコレーション（柔らかな雲のイメージ）
            Positioned(
              top: -screenHeight * 0.07,
              left: -screenWidth * 0.1,
              child: Container(
                width: screenWidth * 0.4,
                height: screenWidth * 0.4,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.1,
              right: -screenWidth * 0.1,
              child: Container(
                width: screenWidth * 0.3,
                height: screenWidth * 0.3,
                decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // メインコンテンツ
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // くまさんアイコン
                  Container(
                    width: screenWidth * 0.55,
                    height: screenWidth * 0.55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.brown[200],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.brown.withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.pets, // くまさん風のアイコン
                        size: 120,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  // タイトル
                  Text(
                    'ぼくとわたしの\n探検ワールド！',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: screenWidth * 0.07,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Comic Sans MS', // ポップで親しみやすいフォント
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // サブタイトル
                  Text(
                    '画面をタップして次へ進もう',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  // 飾りのアイコン
                  Icon(
                    Icons.touch_app,
                    size: screenWidth * 0.13,
                    color: Colors.blue[300],
                  ),
                ],
              ),
            ),
            // 下部のアクセント（柔らかい波のデザイン）
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: screenHeight * 0.15,
                  color: const Color.fromARGB(255, 250, 213, 148),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 波のデザイン用のカスタムクリッパー
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height - 30);
    path.quadraticBezierTo(
        size.width * 3 / 4, size.height - 60, size.width, size.height - 30);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
