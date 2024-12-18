import 'package:flutter/material.dart';
import 'EducationIncorrectScreen2.dart';
import 'EducationCorrectScreen2.dart';

// 四角いボタンを定義
class RectangularButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;
  final double width;
  final double height;
  final Color textColor;

  const RectangularButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.buttonColor,
    this.width = 200,
    this.height = 60,
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
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
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

// 形問題出題画面
class ShapeEducationModeScreen2 extends StatelessWidget {
  final double topMargin;
  final double bottomMargin;

  const ShapeEducationModeScreen2({super.key, this.topMargin = 0.3, this.bottomMargin = 0.1});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // 背景の上部と下部
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenSize.height * 0.9,
            child: Container(color: Colors.lightBlue[300]),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: screenSize.height * 0.1,
            child: Container(color: Colors.green),
          ),
          // 左下の戻るボタン
          Positioned(
            bottom: 10,
            left: 10,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              backgroundColor: Colors.grey[350],
              child: const Icon(Icons.arrow_back),
            ),
          ),
          // ラベル
          Positioned(
            top: screenSize.height * 0.2, // 上部から25%の位置
            left: 0,
            right: 0,
            child: const Column(
              children: [
                Text(
                  'このかたちとおなじかたちは\nどれかな？', // ラベルのテキスト
                  style: TextStyle(
                    fontSize: 30, // フォントサイズ
                    fontWeight: FontWeight.bold, // 太字
                    color: Colors.black, // ラベルの色
                  ),
                ),
              ],
            ),
          ),
          // 四角の配置
          Positioned(
            top: screenSize.height * 0.35, // 上部から35%の位置に四角を配置
            left: screenSize.width * 0.25, // 左から25%の位置に配置（中央に近い位置）
            child: Container(
              width: 200, // 四角の幅
              height: 200, // 四角の高さ
              decoration: BoxDecoration(
                color: Colors.red, // 四角の色
                borderRadius: BorderRadius.circular(20), // 角を丸める（指定した値で丸くする）
              ),
            ),
          ),
          // ボタンの配置
          Positioned(
            top: screenSize.height * 0.6,
            left: screenSize.width * 0.05,
            child: RectangularButton(
              text: 'A.まる',
              width: screenSize.width * 0.4,
              height: screenSize.height * 0.1,
              buttonColor: const Color.fromARGB(255, 255, 212, 193),
              textColor: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EducationIncorrectScreen2(),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: screenSize.height * 0.6,
            right: screenSize.width * 0.05,
            child: RectangularButton(
              text: 'B.しかく',
              width: screenSize.width * 0.4,
              height: screenSize.height * 0.1,
              buttonColor: const Color.fromARGB(255, 255, 212, 193),
              textColor: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EducationCorrectScreen2(),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: screenSize.height * 0.75, // ボタン間隔を追加
            left: screenSize.width * 0.05,
            child: RectangularButton(
              text: 'C.さんかく',
              width: screenSize.width * 0.4,
              height: screenSize.height * 0.1,
              buttonColor: const Color.fromARGB(255, 255, 212, 193),
              textColor: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EducationIncorrectScreen2(),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: screenSize.height * 0.75, // ボタン間隔を追加
            right: screenSize.width * 0.05,
            child: RectangularButton(
              text: 'D.ほし',
              width: screenSize.width * 0.4,
              height: screenSize.height * 0.1,
              buttonColor: const Color.fromARGB(255, 255, 212, 193),
              textColor: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EducationIncorrectScreen2(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}