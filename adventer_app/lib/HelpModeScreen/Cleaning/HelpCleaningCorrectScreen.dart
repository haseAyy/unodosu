import 'package:adventer_app/HelpModeScreen/Cleaning/Bed/HelpBedScreen.dart';
import 'package:flutter/material.dart';
import 'Bed/HelpBedScreen.dart'; // ベッドの画面
import 'Bath/HelpBathScreen.dart'; // おふろの画面
import 'package:http/http.dart' as http; // httpパッケージをインポート
import 'dart:convert'; // jsonDecodeを使うためにインポート
import 'HelpCleaningResultScreen.dart';

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
class HelpCleaningCorrectScreen extends StatefulWidget {
  final String message; // 受け取るメッセージ（いろ、もじなど）
  final int questionCount;
  final int correctCount;
  final String? correctAnswer; // 正解の答えを追加
  final String selectedAnswerContent; // 選択した答え
  final String questionId; //質問id

  const HelpCleaningCorrectScreen(
      {Key? key,
      required this.message,
      required this.questionCount,
      required this.correctCount,
      this.correctAnswer,
      required this.selectedAnswerContent, // 選択した答え
      required this.questionId //取得した問題ID

      })
      : super(key: key);

  @override
  _HelpCleaningCorrectScreenState createState() =>
      _HelpCleaningCorrectScreenState();
}

class _HelpCleaningCorrectScreenState extends State<HelpCleaningCorrectScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation; // 拡大縮小のアニメーションを追加
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();

    _fetchGif();
  }

  Future<void> _fetchGif() async {
    final response = await http.get(
      Uri.parse(
          'http://10.24.110.65:8080/api/getGifByAnswer?message=${widget.message}&selectedAnswer=${widget.selectedAnswerContent}&questionId=${widget.questionId}'),
    );

    if (response.statusCode == 200) {
      setState(() {
        imageUrl = response.body;
      });
    } else {
      throw Exception('Failed to load Gif');
    }
  }

  //次の画面へ遷移するメソッド
  Widget _getNextScreen() {
    if (widget.message == "ベッド") {
      return HelpBedScreen(
        questionCount: widget.questionCount,
        correctCount: widget.correctCount,
      );
    } else if (widget.message == "おふろ") {
      return HelpBathScreen(
        questionCount: widget.questionCount,
        correctCount: widget.correctCount,
      );
    } else {
      return HelpBedScreen(
        questionCount: widget.questionCount,
        correctCount: widget.correctCount,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 222, 94, 94),
        elevation: 0,
        title: const Text(
          'すごい！',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
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
            top: -0.1 * screenSize.height,
            left: -0.1 * screenSize.width,
            child: Container(
              width: 0.3 * screenSize.width,
              height: 0.3 * screenSize.width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(50, 255, 182, 193),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -0.1 * screenSize.height,
            right: -0.1 * screenSize.width,
            child: Container(
              width: 0.4 * screenSize.width,
              height: 0.4 * screenSize.width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(50, 173, 216, 230),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 0.00008 * screenSize.height),
                // AnimatedBuilderを使ったアニメーション付きのアイコン
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _opacityAnimation.value,
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Icon(
                          Icons.cancel_outlined,
                          size: 0.15 * screenSize.height,
                          color: Colors.red,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 0.01 * screenSize.height),
                Text(
                  'せいかいだよ！',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comic Sans MS',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 0.03 * screenSize.height),

                // GIFの画像表示部分
                Container(
                  width: screenSize.width * 0.9, // 比率調整
                  height: screenSize.width * 0.58, // 比率調整
                  child: imageUrl != null
                      ? Image.network(
                          imageUrl!,
                          //width: 0.9 * screenSize.width,
                          //height: 0.9 * screenSize.height,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.error,
                                      color: Colors.red, size: 50),
                                  Text("画像を読み込めませんでした",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 18)),
                                  Text("URL: $imageUrl",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black)),
                                ],
                              ),
                            );
                          },
                        )
                      : const SizedBox.shrink(),
                ),
                SizedBox(height: 0.025 * screenSize.height),
                // 解説部分
                Container(
                  padding: const EdgeInsets.all(16),
                  margin:
                      EdgeInsets.symmetric(horizontal: 0.1 * screenSize.width),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: const Color.fromARGB(255, 205, 205, 205),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 182, 182, 182)
                            .withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    widget.correctAnswer != null
                        ? 'こたえは「${widget.correctAnswer}」だよ！！'
                        : '次回もがんばろう！',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Comic Sans MS',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 0.02 * screenSize.height),
                // 次の問題ボタン
                RectangularButton(
                  text: widget.questionCount == 10 ? 'けっかがめんへ' : 'つぎのもんだい',
                  width: 0.6 * screenSize.width,
                  height: 0.1 * screenSize.height,
                  buttonColor: const Color.fromARGB(255, 250, 240, 230),
                  textColor: Colors.black,
                  onPressed: () {
                    if (widget.questionCount >= 10) {
                      // 結果画面へ遷移するロジック
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HelpCleaningResultScreen(
                            correctCount: widget.correctCount,
                          ),
                        ),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => _getNextScreen()),
                      );
                    }
                  },
                ),
                SizedBox(height: 0.04 * screenSize.height),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
