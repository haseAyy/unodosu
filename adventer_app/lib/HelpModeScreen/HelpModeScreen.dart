import 'package:flutter/material.dart';
import 'dart:ui';
import 'Cleaning/HelpCleaningListScreen.dart';
import 'Errand/HelpErrandStartScreen.dart';

class HelpModeScreen extends StatelessWidget {
  const HelpModeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Scaffold(
      body: Stack(
        children: [
          // 背景（白基調にアクセントカラーを追加）
          Positioned.fill(
            child: Container(
              color: Colors.teal[50],
            ),
          ),
          // 上部デコレーション（柔らかい円形の装飾）
          Positioned(
            top: -screenHeight * 0.05, // 画面サイズに基づく位置調整
            left: -screenWidth * 0.1,
            child: Container(
              width: screenWidth * 0.5,
              height: screenWidth * 0.5,
              decoration: BoxDecoration(
                color: Colors.pinkAccent[100],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.1, // 画面サイズに基づく位置調整
            right: -screenWidth * 0.1,
            child: Container(
              width: screenWidth * 0.4,
              height: screenWidth * 0.4,
              decoration: BoxDecoration(
                color: Colors.greenAccent[100],
                shape: BoxShape.circle,
              ),
            ),
          ),
          // メインコンテンツ（カテゴリー画面）
          Positioned(
            top: screenHeight * 0.2, // 画面上部に配置
            left: 0,
            right: 0,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: const Text(
                    'おてつだいをしてみよう！',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: screenHeight * 0.1),
                CategoryButton(
                  categoryName: 'おかたづけ',
                  description: 'おかたづけをしよう！\nおへやをきれいにしよう',
                  backgroundColor: const Color.fromARGB(255, 226, 199, 255),
                  icon: Icons.cleaning_services, // アイコン追加
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HelpCleaningListScreen()),
                    );
                  },
                ),
                SizedBox(height: screenHeight * 0.05), // ボタン間の間隔を画面サイズに基づく
                CategoryButton(
                  categoryName: 'おつかい',
                  description: 'おつかいをしよう！\nおかねをまなべるよ',
                  backgroundColor: const Color.fromARGB(255, 255, 212, 198),
                  icon: Icons.shopping_cart, // アイコン追加
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HelpErrandStartScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String categoryName;
  final String description;
  final Color backgroundColor;
  final IconData icon;
  final VoidCallback onPressed;

  const CategoryButton({
    super.key,
    required this.categoryName,
    required this.description,
    required this.backgroundColor,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final buttonHeight = screenSize.height * 0.2; // ボタンの高さを調整
    final buttonWidth = screenSize.width * 0.9; // ボタンの幅を調整

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: buttonHeight,
        width: buttonWidth,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(4, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            // 縫い目を描画する CustomPaint
            CustomPaint(
              painter: StitchPainter(buttonWidth, buttonHeight),
              child: Container(),
            ),
            // ボタンのコンテンツ（アイコン、テキスト）
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05), // 左右のパディングを調整
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: screenSize.width * 0.15, // アイコンのサイズ調整
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 20), // アイコンとテキストの間隔調整
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        categoryName,
                        style: TextStyle(
                          fontSize: screenSize.width * 0.06, // テキストサイズ調整
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: screenSize.width * 0.03, // 説明文のサイズ調整
                          color: Colors.black54,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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

class StitchPainter extends CustomPainter {
  final double buttonWidth;
  final double buttonHeight;

  StitchPainter(this.buttonWidth, this.buttonHeight);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint stitchPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0; // 縫い目の太さ

    final double dashWidth = 10.0;
    final double dashSpace = 6.0;

    // ボタンの内側に収まるように調整
    final double padding = 5.0; // 内側の余白を設定

    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(
          padding, padding, // 余白を考慮して内側に合わせる
          buttonWidth - padding * 2, // 内側に合わせて幅を調整
          buttonHeight - padding * 2, // 内側に合わせて高さを調整
        ),
        Radius.circular(20), // 角丸の半径を調整
      ));

    // 破線を描画
    for (PathMetric pathMetric in path.computeMetrics()) {
      double distance = 0;
      while (distance < pathMetric.length) {
        final Path segment = pathMetric.extractPath(
          distance,
          distance + dashWidth,
        );
        canvas.drawPath(segment, stitchPaint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // 再描画は不要
  }
}
