import 'package:flutter/material.dart';
import 'HomeScreen.dart'; // 遷移先の画面

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              top: -50,
              left: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: 100,
              right: -30,
              child: Container(
                width: 150,
                height: 150,
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
                    width: 220,
                    height: 220,
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
                  const SizedBox(height: 40),
                  // タイトル
                  Text(
                    'ぼくとわたしの\n探検ワールド！',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Comic Sans MS', // ポップで親しみやすいフォント
                    ),
                  ),
                  const SizedBox(height: 20),
                  // サブタイトル
                  Text(
                    '画面をタップして次へ進もう',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // 飾りのアイコン
                  Icon(
                    Icons.touch_app,
                    size: 50,
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
                  height: 120,
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
