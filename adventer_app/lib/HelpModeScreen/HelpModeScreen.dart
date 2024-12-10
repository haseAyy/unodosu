import 'package:flutter/material.dart';
import 'Cleaning/HelpCleaningListScreen.dart';

//四角のボタンを定義
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
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: buttonColor, // 指定された色を使用
          borderRadius: BorderRadius.circular(10), // 角を少し丸める
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
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

//お手伝い問題一覧画面(お手伝いモード)
class HelpModeScreen extends StatelessWidget {
  const HelpModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // MediaQueryキャッシュ
    return Scaffold(
      body: Stack(
        children: [
          // 背景カラー1（上部の水色）
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenSize.height * 0.9, // 上部90%
            child: Container(color: Colors.lightBlue[300]),
          ),
          // 背景カラー2（下部の緑色）
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: screenSize.height * 0.1, // 下部10%
            child: Container(color: Colors.green),
          ),
          // 左下に戻るボタン
          Positioned(
            bottom: 10,
            left: 10,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context); // 前の画面に戻る
              },
              backgroundColor: Colors.grey[350],
              child: const Icon(Icons.arrow_back),
            ),
          ),
          // おうちボタン
          Align(
          alignment: const Alignment(0.0, -0.3), // 横方向中央、縦方向は-0.5（上寄り）
          child: RectangularButton(
            text: 'おかたづけ',
            width: screenSize.width * 0.7, // 幅を画面幅の50%に設定
            height: screenSize.height * 0.15, // 高さを画面高さの10%に設定
            buttonColor: const Color.fromARGB(255, 255, 212, 193),
            textColor: Colors.black,
             onPressed: () {
               Navigator.push(
                  context,
                 MaterialPageRoute(builder: (context) => const CleaningScreen()),
                );
              },
            ),
        ),
        // おかねボタン
        Align(
          alignment: const Alignment(0.0, 0.3), // 横方向中央、縦方向は-0.5（上寄り）
          child: RectangularButton(
          text: 'おつかい',
          width: screenSize.width * 0.7, // 幅を画面幅の50%に設定
          height: screenSize.height * 0.15, // 高さを画面高さの10%に設定
          buttonColor: const Color.fromARGB(255, 245, 255, 187),
          textColor: Colors.black,
          onPressed: () {
           Navigator.push(
             context,
              MaterialPageRoute(builder: (context) => const HelpModeScreen()),
            );
           },
          ),
         ),
        ],
      ),
    );
  }
}