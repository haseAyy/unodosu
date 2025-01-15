import 'package:flutter/material.dart';
import 'Shape/ShapeEducationScreen.dart';
import 'Calc/CalcadditionScreen.dart';
import 'Calc/CalcSubtractionScreen.dart';
import 'Color/ColorEducationScreen.dart';
import 'Letter/LetterEducationScreen.dart'; // 他の画面もインポート

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
          borderRadius: BorderRadius.circular(20),
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
              fontFamily: 'Comic Sans MS',
            ),
          ),
        ),
      ),
    );
  }
}

// 正解画面
class EducationCorrectScreen extends StatefulWidget {
  final int questionCount;
  final int correctCount;
  final String correctAnswer;
  final String? questionImage;
  final String nextScreenFlag;

  const EducationCorrectScreen({
    required this.questionCount,
    required this.correctCount,
    required this.correctAnswer,
    this.questionImage,
    required this.nextScreenFlag,
  });

  @override
  State<EducationCorrectScreen> createState() => _EducationCorrectScreenState();
}

class _EducationCorrectScreenState extends State<EducationCorrectScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // フェードアウト用のアニメーションを追加
    _fadeAnimation = Tween<double>(begin: 3.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
      default:
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

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 31, 130, 242),
        elevation: 0,
        title: const Text(
          'すごい！',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Comic Sans MS',
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                color: Color.fromARGB(50, 255, 182, 193),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                color: Color.fromARGB(50, 173, 216, 230),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'せいかい！',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comic Sans MS',
                  ),
                ),
                const SizedBox(height: 20),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _opacityAnimation.value,
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: const Icon(
                            Icons.check_circle_outline,
                            size: 120,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 0.5),
                if (widget.questionImage != null)
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.network(
                      widget.questionImage!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text('画像を読み込めませんでした');
                      },
                    ),
                  ),

                  
                const SizedBox(height: 1),
                //解説部分
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: const Color.fromARGB(255, 205, 205, 205),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(16),
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
                      text: 'こたえ:',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Comic Sans MS',
                      ),
                      children: [
                        TextSpan(
                          text: widget.correctAnswer,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                        builder: (context) => _getNextScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),  // ボタン下に追加の空白を挿入
              ],
            ),
          ),
        ],
      ),
    );
  }
}
