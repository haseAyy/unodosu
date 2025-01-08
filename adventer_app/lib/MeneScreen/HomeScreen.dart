import 'package:flutter/material.dart';
import 'dart:ui';
import '../EducationModeScreen/EducationModeScreen.dart';
import '../HelpModeScreen/HelpModeScreen.dart';
import '../ParentChildMode/ParentChildModeScreen.dart';

// ホーム画面
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // 背景（白基調にアクセントカラーを追加）
          Positioned.fill(
            child: Container(
              color: Colors.white,
            ),
          ),
          // 上部デコレーション（雲のような柔らかい円形）
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
          // タイトル部分
          Positioned(
            top: screenSize.height * 0.15,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  'ぼうけんにでてみよう',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                    fontFamily: 'Comic Sans MS',
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'モードをえらんでみよう！',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          // くまさんアイコン（タイトル部分の下に配置）
          Positioned(
            top: screenSize.height * 0.25, // 「モードを選んでみよう！」の下に配置
            left: (screenSize.width - 100) / 2, // 画面中央に配置
            child: Container(
              width: 100,
              height: 100,
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
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // 長方形ボタン配置
          Align(
            alignment: Alignment.bottomCenter, // 下部に配置
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end, // これでボタンを下部に寄せる
              children: [
                CategoryButton(
                  categoryName: 'おべんきょう',
                  description: 'たのしくまなぼう！',
                  backgroundColor: Colors.green.shade100,
                  icon: Icons.school,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EducationModeScreen()),
                    );
                  },
                ),
                SizedBox(height: screenSize.height * 0.03), // ボタン間の間隔を画面サイズに基づく
                CategoryButton(
                  categoryName: 'おてつだい',
                  description: 'いっしょにおてつだいしよう！',
                  backgroundColor: const Color.fromARGB(255, 255, 222, 175),
                  icon: Icons.volunteer_activism,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HelpModeScreen()),
                    );
                  },
                ),
                SizedBox(height: screenSize.height * 0.03), // ボタン間の間隔を画面サイズに基づく
                CategoryButton(
                  categoryName: 'おやこ',
                  description: 'おやこでぼうけんをたのしもう！',
                  backgroundColor: Colors.pink.shade100,
                  icon: Icons.family_restroom,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ParentChildModeScreen(displayText: '星空を観察しよう!')),
                    );
                  },
                ),
                SizedBox(height: screenSize.height * 0.05), // ボタン間の間隔を画面サイズに基づく
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
