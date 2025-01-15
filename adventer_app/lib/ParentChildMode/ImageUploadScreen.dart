import 'package:flutter/material.dart';
import 'dart:ui';
import 'MissionSettingsScreen.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key});

  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  bool _isButtonPressed = false; // ボタンの状態

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // 背景（茶色基調にアクセントカラーを追加）
          Positioned.fill(
            child: Container(
              color: const Color.fromARGB(174, 250, 231, 213),
            ),
          ),
          // 左下に戻るボタン
          Positioned(
            bottom: 10,
            left: 10,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context); // 前の画面に戻る
              },
              backgroundColor: Colors.grey[100],
              child: const Icon(Icons.arrow_back),
            ),
          ),
          // ラベル
          Positioned(
            top: screenSize.height * 0.25, // 上部から25%の位置
            left: 0,
            right: 0,
            child: const Column(
              children: [
                Text(
                  '写真を選択してください', // ラベルのテキスト
                  style: TextStyle(
                    fontSize: 20, // フォントサイズ
                    fontWeight: FontWeight.bold, // 太字
                    color: Colors.black, // ラベルの色
                  ),
                ),
              ],
            ),
          ),
          // 画像選択ボタン（タップ可能、アニメーションあり）
          Positioned(
            top: screenSize.height * 0.3, // 上部から30%の位置
            left: screenSize.width * 0.25, // 左から25%の位置
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isButtonPressed = !_isButtonPressed;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: screenSize.width * 0.5, // 画面幅の50%の幅
                height: screenSize.height * 0.3, // 画面高さの30%の高さ
                color: _isButtonPressed ? Colors.purple.shade200 : Colors.white,
                child: const Center(
                  child: Text('+', style: TextStyle(fontSize: 50)),
                ),
              ),
            ),
          ),
          // 送信ボタン（アニメーションあり）
          Align(
            alignment: const Alignment(0.0, 0.5), // 横方向中央、縦方向は0.5（中央）
            child: CategoryButton(
              categoryName: '送信',
              backgroundColor: const Color.fromARGB(255, 165, 237, 141),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MissionSettingsScreen()),
                );
              },
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
    final buttonWidth = screenSize.width * 0.6; // ボタンの幅を調整

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