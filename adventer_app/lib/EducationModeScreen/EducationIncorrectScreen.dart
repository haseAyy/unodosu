import 'package:adventer_app/EducationModeScreen/Shape/ShapeEducationScreen.dart';
import 'package:adventer_app/MenuScreen/HomeScreen.dart';
import 'Color/ColorEducationScreen.dart';
import 'Calc/CalcadditionScreen.dart';
import 'Calc/CalcSubtractionScreen.dart';
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
class EducationIncorrectScreen extends StatefulWidget {
  final String correctAnswer;
  final int questionCount;
  final int correctCount;
  final String? questionImage;
  final String nextScreenFlag; // 追加: 遷移先を指定するフラグ

  const EducationIncorrectScreen({
    required this.correctAnswer,
    required this.questionCount,
    required this.correctCount,
    this.questionImage,
    required this.nextScreenFlag,
  });

  @override
  _EducationIncorrectScreenState createState() =>
      _EducationIncorrectScreenState();
}

class _EducationIncorrectScreenState extends State<EducationIncorrectScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    // アニメーションのコントローラーとフェードインの設定
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // フェードインの速度
      vsync: this,
    );
    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // アニメーションを開始
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 遷移先の画面を取得するメソッド
  Widget _getNextScreen() {
    switch (widget.nextScreenFlag) {
      case 'shape':
        return ShapeEducationScreen(
          questionCount: widget.questionCount,
          correctCount: widget.correctCount,
        );
      case 'addition':
        return CalcadditionScreen(
          questionCount: widget.questionCount,
          correctCount: widget.correctCount,
        );

      case 'subtraction':
        return CalcSubtractionScreen(
          questionCount: widget.questionCount,
          correctCount: widget.correctCount,
        );
      case 'color':
        return ColorEducationScreen(
          questionCount: widget.questionCount,
          correctCount: widget.correctCount,
        );
      case 'letter':
        return LetterEducationScreen(
          questionCount: widget.questionCount,
          correctCount: widget.correctCount,
        );
      case 'result':
        return EdcationResultScreen(
          correctCount: widget.correctCount,
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

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    debugPrint('遷移先で受け取った正解: ${widget.correctAnswer}'); // 正しく受け取れているか確認

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 戻るボタンを非表示
        backgroundColor: const Color.fromARGB(255, 250, 60, 60), // ピンク色の背景
        elevation: 0,
        title: const Text(
          'ざんねん！',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'Comic Sans MS',
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white, // 背景を白に統一
      body: Stack(
        children: [
          // 背景（ノート風の罫線デザイン）
          Positioned.fill(
            child: CustomPaint(
              painter: SchoolBackgroundPainter(),
            ),
          ),
          
          // 中央のコンテンツ
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'つぎもがんばろう！',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comic Sans MS',
                  ),
                  textAlign: TextAlign.center,
                ),

                
                FadeTransition(
                  opacity: _opacityAnimation,
                  child: const Icon(
                    Icons.cancel_outlined,
                    size: 150,
                    color: Colors.red,
                  ),
                ),

                const SizedBox(height: 0.2),
                
                
              
            


                SizedBox(height: 0.2 * screenSize.height),
                // 解説部分
                Container(
                  padding: const EdgeInsets.all(10), // 内部の余白大きく
                  margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20), // 外部の余白大きく
                  decoration: BoxDecoration(
                    color: Colors.transparent, // 背景色を透明に設定
                    border: Border.all(
                      color: const Color.fromARGB(255, 205, 205, 205), // 枠の色
                      width: 4, // 枠の太さ
                    ),
                    borderRadius: BorderRadius.circular(16), // 角の丸みを大きく
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
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Comic Sans MS',
                      ),
                      children: [
                        TextSpan(
                          text: widget.correctAnswer, // 正解の答え
                          style: const TextStyle(
                            fontSize: 24, // 文字サイズを大きく
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0), // 色も変えたい場合
                            fontFamily: 'Comic Sans MS',
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),


                //SizedBox(height: 40),
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
                        builder: (context) => _getNextScreen(), // 遷移先の画面
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          //画像
          //形の時
          if (widget.nextScreenFlag == 'shape')
            if (widget.questionImage != null)
              Positioned(
                top: screenSize.height * 0.3,
                left: 0,
                right: 0,
              child: Column(
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.network(
                      widget.questionImage!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text('画像を読み込めませんでした');
                      },
                    ),
                  ),
                ],
              ),
            ),
            //画像
          //色の時
          if (widget.nextScreenFlag == 'color')
            if (widget.questionImage != null)
              Positioned(
                top: screenSize.height * 0.25,
                left: 0,
                right: 0,
              child: Column(
                children: [
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: Image.network(
                      widget.questionImage!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text('画像を読み込めませんでした');
                      },
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class SchoolBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final double lineSpacing = 40.0;

    // ノート風の横罫線を描画
    for (double y = 0; y < size.height; y += lineSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    // 左側の赤い縦線を描画
    final Paint marginPaint = Paint()
      ..color = Colors.red.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawLine(const Offset(50, 0), Offset(50, size.height), marginPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // 再描画は不要
  }
}
