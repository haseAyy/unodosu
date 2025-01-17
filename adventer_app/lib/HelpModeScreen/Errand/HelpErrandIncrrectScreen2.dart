import 'package:adventer_app/EducationModeScreen/Shape/ShapeEducationScreen.dart';
import 'HelpErrandScreen2.dart';
import 'package:flutter/material.dart';
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
   
        return HelpErrandScreen(
          questionCount: widget.questionCount,
          correctCount: widget.correctCount,
        );
    
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
          'おしい！',
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
                FadeTransition(
                  opacity: _opacityAnimation,
                  child: const Icon(
                    Icons.cancel_outlined,
                    size: 150,
                    color: Colors.red,
                  ),
                ),

                const SizedBox(height: 0.5),
                if (widget.questionImage != null)
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: Image.network(
                      widget.questionImage!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text('画像を読み込めませんでした');
                      },
                    ),
                  ),


                const SizedBox(height: 1),
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
                            fontSize: 25, // 文字サイズを大きく
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
                        builder: (context) => _getNextScreen(), // 遷移先の画面
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