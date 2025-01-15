import 'package:flutter/material.dart';
import 'Shape/ShapeEducationScreen.dart'; // かたちの画面
import 'Color/ColorEducationScreen.dart'; // いろの画面
import 'Letter/LetterEducationScreen.dart'; // もじの画面
import 'Calc/CalcEducationScreen.dart';   //けいさんの画面

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

// 正解画面
class EducationCorrectScreen extends StatelessWidget {
  final String message; // 受け取るメッセージ（いろ、もじなど）

  final int questionCount;
  final int correctCount;

  const EducationCorrectScreen({
    required this.message,
    required this.questionCount,
    required this.correctCount,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 戻るボタンを非表示にする
        backgroundColor: const Color.fromARGB(255, 255, 182, 193), // ピンク色の背景
        elevation: 0,
        title: const Text(
          'せいかい！おめでとう！',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
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
            top: -50,
            left: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                color: Color.fromARGB(50, 255, 182, 193), // 薄いピンク
                shape: BoxShape.circle,
              ),
            ),
          ),
          // 下部のソフトな装飾
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
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
                const Icon(
                  Icons.check_circle_outline,
                  size: 150,
                  color: Colors.orange,
                ),
                const SizedBox(height: 20),
                const Text(
                  'せいかい！おめでとう！',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comic Sans MS',
                  ),
                ),
                const SizedBox(height: 40),
                RectangularButton(
                  text: 'つぎのもんだい',
                  width: screenSize.width * 0.6,
                  height: screenSize.height * 0.1,
                  buttonColor: const Color.fromARGB(255, 250, 240, 230),
                  textColor: Colors.black,
                  onPressed: () {
                    // メッセージに基づいて遷移先を変更
                    if (message == "いろ") {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ColorEducationScreen(
                            questionCount: questionCount,
                            correctCount: correctCount,
                          ), // いろの画面
                        ),
                      );
                    } else if (message == "もじ") {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LetterEducationScreen(
                            questionCount: questionCount,
                            correctCount: correctCount,
                          ), // もじの画面
                        ),
                      );
                    } else if (message == "けいさん") {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CalcEducationScreen(
                            questionCount: questionCount,
                            correctCount: correctCount,
                          ), // けいさんの画面
                        ),
                      );
                    } else {
                      // デフォルトの遷移
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShapeEducationScreen(
                            questionCount: questionCount,
                            correctCount: correctCount,
                          ),
                        ),
                      );
                    }
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