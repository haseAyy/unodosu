<<<<<<< HEAD
import 'package:adventer_app/EducationModeScreen/demo/ShapeEducationModeScreen2.dart';
=======
import 'package:adventer_app/EducationModeScreen/ShapeEducationScreen.dart';
>>>>>>> origin/master
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
<<<<<<< HEAD
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(2, 4),
=======
          borderRadius: BorderRadius.circular(20), // ボタンの角を丸く
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(3, 5),
>>>>>>> origin/master
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
<<<<<<< HEAD
=======
              fontFamily: 'Comic Sans MS', // フォントを統一
>>>>>>> origin/master
            ),
          ),
        ),
      ),
    );
  }
}

// 不正解画面
class EducationIncorrectScreen extends StatelessWidget {
  const EducationIncorrectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
<<<<<<< HEAD
      body: Stack(
        children: [
          // 背景の色
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.lightBlue[300], // ここで背景カラーを設定
            ),
          ),
          // 背景の下部色
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: screenSize.height * 0.1,
            child: Container(color: Colors.green),
=======
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
>>>>>>> origin/master
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
<<<<<<< HEAD
=======
                    fontFamily: 'Comic Sans MS',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                // 解説部分
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.transparent, // 背景色を透明に設定
                    border: Border.all(
                      color: const Color.fromARGB(255, 205, 205, 205), // 枠の色
                      width: 2, // 枠の太さ
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Text(
                    '解説: この問題は形を正しく識別することが求められました。次回はもっとがんばろう！',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Comic Sans MS',
                    ),
                    textAlign: TextAlign.center,
>>>>>>> origin/master
                  ),
                ),
                const SizedBox(height: 40),
                RectangularButton(
                  text: 'つぎのもんだい',
                  width: screenSize.width * 0.6,
                  height: screenSize.height * 0.1,
<<<<<<< HEAD
                  buttonColor: const Color.fromARGB(255, 255, 227, 193),
=======
                  buttonColor: const Color.fromARGB(255, 250, 240, 230),
>>>>>>> origin/master
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
<<<<<<< HEAD
                        builder: (context) => const ShapeEducationModeScreen2(),
=======
                        builder: (context) => const ShapeEducationScreen(),
>>>>>>> origin/master
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
<<<<<<< HEAD
}
=======
}
>>>>>>> origin/master
