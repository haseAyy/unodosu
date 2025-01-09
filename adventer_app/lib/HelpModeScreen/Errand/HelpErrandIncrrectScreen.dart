import 'HelpErrandScreen.dart';
import 'package:flutter/material.dart';

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
          borderRadius: BorderRadius.circular(20), // ボタンの角を丸く
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(3, 5),
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
              fontFamily: 'Comic Sans MS', // フォントを統一
            ),
          ),
        ),
      ),
    );
  }
}

// 不正解画面
class HelpErrandIncorrectScreen extends StatelessWidget {
  const HelpErrandIncorrectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 戻るボタンを非表示
        backgroundColor: const Color.fromARGB(255, 222, 94, 94),
        elevation: 0,
        title: const Text(
          'ざんねん',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Comic Sans MS',
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white, // 背景を白に統一
      body: Stack(
        children: [
          // 上部のソフトな装飾
          Positioned(
            top: -0.1 * screenSize.height,
            left: -0.1 * screenSize.width,
            child: Container(
              width: 0.3 * screenSize.width,
              height: 0.3 * screenSize.width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(50, 255, 182, 193), // 薄いピンク
                shape: BoxShape.circle,
              ),
            ),
          ),
          // 下部のソフトな装飾
          Positioned(
            bottom: -0.1 * screenSize.height,
            right: -0.1 * screenSize.width,
            child: Container(
              width: 0.4 * screenSize.width,
              height: 0.4 * screenSize.width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(50, 173, 216, 230), // 薄い水色
                shape: BoxShape.circle,
              ),
            ),
          ),
          // 中央のコンテンツ
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // アイコンのサイズを画面の高さに基づいて調整
                Icon(
                  Icons.cancel_outlined,
                  size: 0.2 * screenSize.height, // 画面高さに基づいてアイコンのサイズを決定
                  color: Colors.red,
                ),
                SizedBox(height: 0.05 * screenSize.height), // 高さに基づいて余白を調整
                Text(
                  'ざんねん！\nつぎもがんばろう！',
                  style: TextStyle(
                    fontSize: 0.04 * screenSize.height, // 画面高さに基づいてフォントサイズを調整
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comic Sans MS',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 0.08 * screenSize.height), // 高さに基づいて余白を調整
                // 解説部分
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(horizontal: 0.1 * screenSize.width), // ここを修正
                  decoration: BoxDecoration(
                    color: Colors.transparent, // 背景色を透明に設定
                    border: Border.all(
                      color: const Color.fromARGB(255, 205, 205, 205), // 枠の色
                      width: 2, // 枠の太さ
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 182, 182, 182).withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Text(
                    '解説: この問題は形を正しく識別することが求められました。次回はもっとがんばろう！',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Comic Sans MS',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 0.08 * screenSize.height), // 高さに基づいて余白を調整
                RectangularButton(
                  text: 'つぎのもんだい',
                  width: 0.6 * screenSize.width, // 幅を画面幅に基づいて調整
                  height: 0.1 * screenSize.height, // 高さを画面高さに基づいて調整
                  buttonColor: const Color.fromARGB(255, 250, 240, 230),
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HelpErrandScreen(),
                      ),
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