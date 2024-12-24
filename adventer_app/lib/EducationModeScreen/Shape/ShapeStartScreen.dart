import 'package:flutter/material.dart';
import 'dart:math';
import 'ShapeEducationScreen.dart';

class ShapeStartScreen extends StatefulWidget {
  const ShapeStartScreen({super.key});

  @override
  _ShapeStartScreenState createState() => _ShapeStartScreenState();
}

class _ShapeStartScreenState extends State<ShapeStartScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20), // アニメーションの速度を遅く設定
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Scaffold(
      body: Stack(
        children: [
          // 背景アニメーション
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: ShapeBackgroundPainter(_controller.value),
                );
              },
            ),
          ),
          // タイトルとスタートボタン
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'かたちあわせであそぼう！',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ShapeEducationScreen(),
                    ),
                  );
                },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.2,
                      vertical: screenHeight * 0.02,
                    ),
                    backgroundColor: const Color.fromARGB(255, 237, 165, 9),
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

class ShapeBackgroundPainter extends CustomPainter {
  final double progress;

  ShapeBackgroundPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.fill;

    final random = Random(12345); // 固定のシード値でランダム性を維持
    final numShapes = 10;

    for (int i = 0; i < numShapes; i++) {
      paint.color = Colors.primaries[i % Colors.primaries.length]
          .withOpacity(0.1 + (i % 5) * 0.1);

      final dx = (size.width * random.nextDouble() + progress * size.width) % size.width;
      final dy = (size.height * random.nextDouble() + progress * size.height) % size.height;
      final radius = size.width * (0.1 + 0.05 * random.nextDouble());

      canvas.drawCircle(Offset(dx, dy), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // アニメーションに応じて再描画
  }
}
