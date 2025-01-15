import 'package:adventer_app/MeneScreen/HomeScreen.dart';
import 'package:flutter/material.dart';
import '../EducationCorrectScreen.dart';
import '../EducationIncorrectScreen.dart';

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

// 計算問題出題画面
class CalcEducationScreen extends StatelessWidget {
  const CalcEducationScreen({super.key});

  // ポップアップダイアログを表示する関数
  void _showQuitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ほんとうにやめる？'),
          content: const Text('もんだいをおわってもいいですか？'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // ダイアログを閉じる
              },
              child: const Text('つづける'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // ダイアログを閉じて、問題一覧画面に戻る
                Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen(initialIndex: 1),));
              },
              child: const Text('やめる'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 戻るボタンを非表示にする
        backgroundColor: Colors.pink.shade100,
        elevation: 0,
        title: const Text(
          'けいさんもんだい',
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
          // 背景（ノート風の罫線デザイン）
          Positioned.fill(
            child: CustomPaint(
              painter: SchoolBackgroundPainter(),
            ),
          ),
          // 問題中断ボタン（左下）
          Positioned(
            bottom: screenSize.height * 0.05, // 位置調整
            left: 10,
            child: TextButton(
              onPressed: () {
                _showQuitDialog(context); // ダイアログを表示
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.pink.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // 角丸
                ),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              ),
              child: const Text(
                'やめる',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // テキストカラー（白）
                  fontFamily: 'Comic Sans MS', // フォント
                ),
              ),
            ),
          ),
          // 問題テキスト
          Positioned(
            top: screenSize.height * 0.15,
            left: 0,
            right: 0,
            child: const Column(
              children: [
                Text(
                  'このもんだいをといてみよう！',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    backgroundColor: Colors.white,
                    fontFamily: 'Comic Sans MS',
                  ),
                ),
              ],
            ),
          ),
          // ボタンエリア
          Positioned(
            bottom: screenSize.height * 0.15, // 位置調整
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RectangularButton(
                      text: 'A.３',
                      buttonColor: const Color.fromARGB(255, 250, 240, 230),
                      textColor: Colors.black,
                      width: screenSize.width * 0.4, // 横幅調整
                      height: 70, // 高さ調整
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const EducationCorrectScreen()));
                      },
                    ),
                    RectangularButton(
                      text: 'B.２',
                      buttonColor: const Color.fromARGB(255, 250, 240, 230),
                      textColor: Colors.black,
                      width: screenSize.width * 0.4, // 横幅調整
                      height: 70, // 高さ調整
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const EducationIncorrectScreen()));
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RectangularButton(
                      text: 'C.６',
                      buttonColor: const Color.fromARGB(255, 250, 240, 230),
                      textColor: Colors.black,
                      width: screenSize.width * 0.4, // 横幅調整
                      height: 70, // 高さ調整
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const EducationIncorrectScreen()));
                      },
                    ),
                    RectangularButton(
                      text: 'D.９',
                      buttonColor: const Color.fromARGB(255, 250, 240, 230),
                      textColor: Colors.black,
                      width: screenSize.width * 0.4, // 横幅調整
                      height: 70, // 高さ調整
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const EducationIncorrectScreen()));
                      },
                    ),
                  ],
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