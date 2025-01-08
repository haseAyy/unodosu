import 'package:flutter/material.dart';
import 'ShapeEducationScreen.dart';
import 'CalcEducationScreen.dart';
import 'ColorEducationScreen.dart';
import 'LetterEducationScreen.dart'; // 他の画面もインポート

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
  final int questionCount;
  final int correctCount;
  final String nextScreenFlag; // 遷移先の画面を指定（文字列）

  const EducationCorrectScreen({
    required this.questionCount,
    required this.correctCount,
    required this.nextScreenFlag, // 必須パラメータに追加
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    // 遷移先の画面を取得するメソッド
    Widget _getNextScreen() {
      switch (nextScreenFlag) {
        case 'shape':
          return ShapeEducationScreen(
            questionCount: questionCount,
            correctCount: correctCount,
          );
        case 'calc':
          return CalcEducationScreen(
            questionCount: questionCount,
            correctCount: correctCount,
          );
        case 'color':
          return ColorEducationScreen(
            questionCount: questionCount,
            correctCount: correctCount,
          );
        case 'letter':
          return LetterEducationScreen(
            questionCount: questionCount,
            correctCount: correctCount,
          );
        default:
          // デフォルトケース
          return Scaffold(
            appBar: AppBar(
              title: const Text('エラー'),
            ),
            body: const Center(
              child: Text('次の画面が見つかりません。'),
            ),
          );
      }
    }

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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => _getNextScreen(), // 動的に遷移先を指定
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
