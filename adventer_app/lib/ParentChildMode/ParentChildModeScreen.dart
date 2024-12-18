import 'package:flutter/material.dart';
import 'ImageUploadScreen.dart';
import 'MissionSettingsScreen.dart';
import '../MeneScreen/HomeScreen.dart';

// 四角のボタンを定義
class RectangularButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor; // ボタンの色
  final double width; // ボタンの幅
  final double height; // ボタンの高さ
  final Color textColor;

  const RectangularButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.buttonColor,
    this.width = 200, // デフォルト幅
    this.height = 60, // デフォルト高さ
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200), // アニメーションを追加
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: buttonColor, // 指定された色を使用
          border: Border.all(
            color: Colors.black, // 黒い枠線を追加
            width: 2, // 枠線の太さ
          ),
          borderRadius: BorderRadius.circular(25), // 角をもっと丸くして柔らかく
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}

// ミッション画面(親子モード)
class ParentChildModeScreen extends StatelessWidget {
  final String displayText; // 表示する文字列
  const ParentChildModeScreen({
    super.key,
    required this.displayText, // コンストラクタで受け取る
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // MediaQueryキャッシュ
    return Scaffold(
      body: Stack(
        children: [
          // 背景グラデーション（上部の水色、下部の緑色）
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.lightBlue[300]!, Colors.green[200]!],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          // 左下に戻るボタン
          Positioned(
            bottom: 10,
            left: 10,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              backgroundColor: Colors.grey[350],
              child: const Icon(Icons.arrow_back),
            ),
          ),
          // ミッション設定ボタン
          Align(
            alignment: const Alignment(0.0, -0.4), // 横方向中央、縦方向は-0.4（上寄り）
            child: RectangularButton(
              text: 'ミッション設定',
              width: screenSize.width * 0.7, // 幅を画面幅の70%に設定
              height: screenSize.height * 0.07, // 高さを画面高さの10%に設定
              buttonColor: Colors.pink.shade200, // ピンク色
              textColor: Colors.white,
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
            alignment: const Alignment(0.0, 0.5), // 横方向中央、縦方向は0.2（少し下寄り）
            child: RectangularButton(
              text: 'アップロード',
              width: screenSize.width * 0.7, // 幅を画面幅の70%に設定
              height: screenSize.height * 0.07, // 高さを画面高さの10%に設定
              buttonColor: Colors.orange.shade200, // オレンジ色
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ImageUploadScreen()),
                );
              },
            ),
          ),
          // 表示する文字
          Align(
            alignment: const Alignment(0.0, -0.0), // 画面の中央に配置
            child: Container(
              padding: const EdgeInsets.all(20.0), // 文字の周りにパディングを追加
              color: Colors.white.withOpacity(0.7), // 半透明な背景色を設定
              child: Text(
                displayText, // 渡された文字列を表示
                style: const TextStyle(
                  fontSize: 24, // 文字サイズ
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
