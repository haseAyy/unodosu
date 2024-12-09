import 'package:flutter/material.dart';
import 'EducationModeScreen.dart';
import 'HelpModeScreen.dart';
import 'ParentChildModeScreen.dart';

// 丸いボタンを定義
class CircularButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;  // ボタン色を追加

  const CircularButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.buttonColor,  // コンストラクタにcolorを追加
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // MediaQueryキャッシュ
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: screenSize.width * 0.4,
        height: screenSize.height * 0.4,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: buttonColor,  // 渡された色を使う
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
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

// ホーム画面
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          // メインコンテンツ（丸いボタン）
          Positioned(
            top: screenSize.height * 0.35, // 画面上部から35%下に配置
            left: screenSize.width * 0.3, // ボタンを水平中央に配置
            child: CircularButton(
              text: 'おべんきょう',
              buttonColor: Colors.green.shade100,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EducationModeScreen()),
                );
              },
            ),
          ),
          Positioned(
            bottom: screenSize.width * 0.1,
            left: screenSize.width * 0.05,
            child: CircularButton(
              text: 'おてつだい',
              buttonColor: Colors.yellow.shade100,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpModeScreen()),
                );
              },
            ),
          ),
          Positioned(
            bottom: screenSize.width * 0.1,
            right: screenSize.width * 0.05,
            child: CircularButton(
              text: 'おやこ',
              buttonColor: Colors.pink.shade50,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ParentChildModeScreen(displayText: '星空を観察しよう!', )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}