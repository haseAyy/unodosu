import 'package:flutter/material.dart';
import 'dart:ui';
import 'ImageUploadScreen.dart';
import 'MissionSettingsScreen.dart';

// 親子モードのミッション設定画面
class ParentChildModeScreen extends StatelessWidget {
  final String displayText; // 表示する文字列
  const ParentChildModeScreen({
    super.key,
    required this.displayText, // コンストラクタで受け取る
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    return Scaffold(
      body: Stack(
        children: [
          // 背景（茶色基調にアクセントカラーを追加）
          Positioned.fill(
            child: Container(
              color: const Color.fromARGB(174, 250, 231, 213),
            ),
          ),
          // 上部デコレーション（旗と星）
          Align(
            alignment: Alignment.topCenter, // 横方向に中心、縦方向は上からの距離を調整
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.1),
              child: Row(
                mainAxisSize: MainAxisSize.min, // Row の幅を内容の幅に合わせる
                children: [
                  const Icon(Icons.flag, color: Colors.blue, size: 40),
                  const SizedBox(width: 8),
                  Text(
                    'ミッションにチャレンジしよう！',
                    style: TextStyle(
                      fontSize: screenHeight * 0.025,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // ミッション設定ボタン
          Align(
            alignment: const Alignment(0.0, 0.8),
            child: CategoryButton(
              categoryName: 'ミッション設定',
              backgroundColor: const Color.fromARGB(255, 166, 232, 237),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MissionSettingsScreen()),
                );
              },
            ),
          ),
          // アップロードボタン
          Align(
            alignment: const Alignment(0.0, 0.5),
            child: CategoryButton(
              categoryName: 'アップロード',
              backgroundColor: Colors.orange.shade200,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ImageUploadScreen()),
                );
              },
            ),
          ),
          // クエスト受付場風の木製看板
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: screenHeight * 0.3),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFEDCFA9), // 木製風の明るい色
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: const Color(0xFF9B7642), // 濃い木の色
                  width: 4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(4, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.map,
                    color: Colors.brown[700],
                    size: screenWidth * 0.08,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    displayText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DotGothic16',
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class CategoryButton extends StatelessWidget {
  final String categoryName;
  //final String description;
  final Color backgroundColor;
  //final IconData icon;
  final VoidCallback onPressed;

  const CategoryButton({
    super.key,
    required this.categoryName,
    //required this.description,
    required this.backgroundColor,
    //required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final buttonHeight = screenSize.height * 0.1; // ボタンの高さを調整
    final buttonWidth = screenSize.width * 0.8; // ボタンの幅を調整

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
            // ボタンのコンテンツ（テキストを中央に配置）
            Center(
              child: Text(
                categoryName,
                style: TextStyle(
                  fontSize: screenSize.width * 0.06, // テキストサイズ調整
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
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