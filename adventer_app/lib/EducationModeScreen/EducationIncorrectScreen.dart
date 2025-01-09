import 'package:adventer_app/EducationModeScreen/Shape/ShapeEducationScreen.dart';
import 'Color/ColorEducationScreen.dart';
import 'Calc/CalcEducationScreen.dart';
import 'Letter/LetterEducationScreen.dart';
import 'EdcationResultScreen.dart';

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
class EducationIncorrectScreen extends StatelessWidget {
  final String correctAnswer;
  final int questionCount;
  final int correctCount;
  final String nextScreenFlag; // 追加: 遷移先を指定するフラグ

  const EducationIncorrectScreen({
    required this.correctAnswer,
    required this.questionCount,
    required this.correctCount,
    required this.nextScreenFlag,
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
          case 'result':
          return EdcationResultScreen(
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
    
  debugPrint('遷移先で受け取った正解: $correctAnswer'); // 正しく受け取れているか確認
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 戻るボタンを非表示
        backgroundColor: const Color.fromARGB(255, 255, 182, 193), // ピンク色の背景
        elevation: 0,
        title: const Text(
          'ざんねん！',
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
                  Icons.cancel_outlined,
                  size: 150,
                  color: Colors.red,
                ),
                const SizedBox(height: 20),
                const Text(
                  'ざんねん！\nつぎもがんばろう！',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comic Sans MS',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                // 解説部分
                Container(
                  
                  padding: const EdgeInsets.all(32),  //内部の余白大きく
                  margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),  //外部の余白大きく
                  decoration: BoxDecoration(
                    color: Colors.transparent, // 背景色を透明に設定
                    border: Border.all(
                      color: const Color.fromARGB(255, 205, 205, 205), // 枠の色
                      width: 4, // 枠の太さ
                    ),
                    borderRadius: BorderRadius.circular(16),  //角野間の丸みを大きく
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text.rich(
                    TextSpan(
                      text: 'ただしいこたえ: \n',
                      style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Comic Sans MS',
                    
                    ),
                    children:[
                      TextSpan(
                        text: '$correctAnswer',  // $correctAnswerだけのスタイル
                        style: TextStyle(
                        fontSize: 25,  // 文字サイズを大きく
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0),  // 色も変えたい場合
                        fontFamily: 'Comic Sans MS',
                      ),
                    ),
                   ],
                    ),
                    textAlign: TextAlign.center,
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
                        builder: (context) => _getNextScreen(), // () を付けて実行
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
