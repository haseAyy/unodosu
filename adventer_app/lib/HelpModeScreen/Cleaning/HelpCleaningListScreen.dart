import 'package:adventer_app/HelpModeScreen/Cleaning/Bed/HelpBedStartScreen.dart';
import 'package:adventer_app/MeneScreen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'Bath/HelpBathStartScreen.dart';
import 'Table/HelpTableStartScreen.dart';

class HelpCleaningListScreen extends StatelessWidget {
  const HelpCleaningListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Scaffold(
      body: Stack(
        children: [
          // 背景色（温かみのある色調）
          Container(color: Colors.teal[50]),

          // 上部デコレーション（円形の装飾）
          Positioned(
            top: -screenHeight * 0.05, // 画面サイズに基づく位置調整
            left: -screenWidth * 0.1,
            child: Container(
              width: screenWidth * 0.4, // 画面サイズに基づくサイズ調整
              height: screenWidth * 0.4,
              decoration: BoxDecoration(
                color: Colors.orangeAccent[100],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.2, // 画面サイズに基づく位置調整
            right: -screenWidth * 0.1,
            child: Container(
              width: screenWidth * 0.3,
              height: screenWidth * 0.3,
              decoration: BoxDecoration(
                color: Colors.lightGreen[200],
                shape: BoxShape.circle,
              ),
            ),
          ),

          // 質問部分
          Positioned(
            top: screenHeight * 0.07,
            left: screenWidth * 0.1,
            right: screenWidth * 0.1,
            child: Container(
              padding: EdgeInsets.all(screenHeight * 0.02), // 余白調整
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.orange, width: 2),
              ),
              child: const Text(
                'どのへやをおかたづけする？',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          // アイコン付きボタンの配置（縦並び）
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.15), // ボタン間の隙間
                // 1番目：ベッド
                _buildIconButton(
                  context: context, // contextを渡す
                  icon: Icons.bed,
                  label: 'ベッド',
                  backgroundColor: const Color.fromARGB(255, 20, 154, 127),
                  onPressed: () {
                    // ベッド選択時の処理
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HelpBedStartScreen()),
                    );
                  },
                ),
                SizedBox(height: screenHeight * 0.01), // ボタン間の隙間
                // 2番目：おふろ
                _buildIconButton(
                  context: context, // contextを渡す
                  icon: Icons.bathtub,
                  label: 'おふろ',
                  backgroundColor: Colors.blueAccent[100]!,
                  onPressed: () {
                    // おふろ選択時の処理
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HelpBathStartScreen()),
                    );
                  },
                ),
                SizedBox(height: screenHeight * 0.01), // ボタン間の隙間
                // 3番目：テーブル
                _buildIconButton(
                  context: context, // contextを渡す
                  icon: Icons.table_restaurant,
                  label: 'テーブル',
                  backgroundColor: const Color.fromARGB(255, 255, 224, 120),
                  onPressed: () {
                    // テーブル選択時の処理
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HelpTableStartScreen()),
                    );
                  },
                ),
              ],
            ),
          ),

          // 左下の戻るボタン
          Positioned(
            bottom: screenHeight * 0.03, // ボタンの位置調整
            left: screenWidth * 0.05,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen(initialIndex: 2),),
                    );
              },
              backgroundColor: Colors.grey[100],
              child: const Icon(Icons.arrow_back),
            ),
          ),
        ],
      ),
    );
  }

  // アイコン付きボタンを作る関数
  Widget _buildIconButton({
    required BuildContext context, // contextを引数として受け取る
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Column(
      children: [
        // アイコンの位置を調整（上にずらしたり、左右にずらしたりできます）
        Container(
          height: screenHeight * 0.2, // ボタンの高さを画面サイズに基づいて設定
          width: screenHeight * 0.2,  // ボタンの幅を画面サイズに基づいて設定
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20), // 丸みをつけて柔らかい印象
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(5, 5),
              ),
            ],
          ),
          child: Stack(
            children: [
              // 縫い目のデザインを描画
              CustomPaint(
                painter: StitchPainter(),
                child: Container(),
              ),
              // アイコン
              Center(
                child: IconButton(
                  icon: Icon(icon, size: screenWidth * 0.25), // アイコンのサイズを画面サイズに基づいて調整
                  onPressed: onPressed,
                  color: Colors.black54, // アイコン色を黒に設定
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.02), // アイコンとテキストの間隔
        // テキストの位置調整（上または下にずらす）
        Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.06, // フォントサイズを画面幅に基づいて設定
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class StitchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint stitchPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0; // 縫い目の太さ

    const double dashWidth = 10.0;
    const double dashSpace = 6.0;

    // 縫い目をボタンの内側に少しだけ描画
    const double padding = 4.0; // 縫い目の内側に少しだけ余白を追加

    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(padding, padding, size.width - padding * 2, size.height - padding * 2),
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