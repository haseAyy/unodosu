import 'package:flutter/material.dart';
import 'dart:ui';
import 'Calc/CalcStartScreen.dart';
import 'Color/ColorStartScreen.dart';
import 'Letter/LetterStartScreen.dart';
import 'Shape/ShapeStartScreen.dart';

class EducationModeScreen extends StatelessWidget {
  const EducationModeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // 背景（ノート風の罫線デザイン）
          Positioned.fill(
            child: CustomPaint(
              painter: SchoolBackgroundPainter(),
            ),
          ),
          // メインコンテンツ（カテゴリー画面）
          Positioned(
            top: screenSize.height * 0.1,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'おべんきょうをはじめよう！',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      backgroundColor: Color.fromARGB(255, 255, 248, 248),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: screenSize.height * 0.03),
                CategoryButton(
                  categoryName: 'かたち',
                  description: 'かたちをまなぼう！\nいろんなかたちをさがそう',
                  backgroundColor: Colors.blue.shade100,
                  icon: Icons.star,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ShapeStartScreen()),
                    );
                  },
                ),
                SizedBox(height: screenSize.height * 0.03),
                CategoryButton(
                  categoryName: 'いろ',
                  description: 'いろをまなぼう！\nカラフルなせかいがひろがるよ',
                  backgroundColor: Colors.orange.shade100,
                  icon: Icons.palette,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ColorStartScreen()),
                    );
                  },
                ),
                SizedBox(height: screenSize.height * 0.03),
                CategoryButton(
                  categoryName: 'もじ',
                  description: 'もじをまなぼう！\nたのしくもじをおぼえよう',
                  backgroundColor: Colors.green.shade100,
                  icon: Icons.text_fields,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LetterStartScreen()),
                    );
                  },
                ),
                SizedBox(height: screenSize.height * 0.03),
                CategoryButton(
                  categoryName: 'けいさん',
                  description: 'けいさんをまなぼう！\nけいさんをといてみよう',
                  backgroundColor: Colors.pink.shade100,
                  icon: Icons.calculate,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CalcStartScreen()),
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

class SchoolBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    const double lineSpacing = 40.0;

    // ノート風の横罫線を描画
    for (double y = 0; y < size.height; y += lineSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    // 左側の赤い縦線を描画
    final Paint marginPaint = Paint()
      ..color = Colors.red.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawLine(const Offset(50, 0), Offset(50, size.height), marginPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // 再描画は不要
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

    final buttonHeight = screenSize.height * 0.15; // ボタンの高さを調整
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

    const double dashWidth = 10.0;
    const double dashSpace = 6.0;

    // ボタンの内側に収まるように調整
    const double padding = 5.0; // 内側の余白を設定

    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(
          padding, padding, // 余白を考慮して内側に合わせる
          buttonWidth - padding * 2, // 内側に合わせて幅を調整
          buttonHeight - padding * 2, // 内側に合わせて高さを調整
        ),
        const Radius.circular(20), // 角丸の半径を調整
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
