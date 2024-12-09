import 'package:flutter/material.dart';
import 'HelpModeScreen.dart';

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
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(2, 4),
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
            ),
          ),
        ),
      ),
    );
  }
}

// 形問題出題画面
class ShapeEducationModeScreen extends StatelessWidget {
  const ShapeEducationModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // 背景の上部と下部
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenSize.height * 0.9,
            child: Container(color: Colors.lightBlue[300]),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: screenSize.height * 0.1,
            child: Container(color: Colors.green),
          ),
          // 左下の戻るボタン
          Positioned(
            bottom: 10,
            left: 10,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              backgroundColor: Colors.grey[350],
              child: const Icon(Icons.arrow_back),
            ),
          ),
          // 四択ボタン
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RectangularButton(
                  text: 'A.まる',
                  width: screenSize.width * 0.4,
                  height: screenSize.height * 0.1,
                  buttonColor: const Color.fromARGB(255, 255, 212, 193),
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HelpModeScreen()),
                    );
                  },
                ),
                const SizedBox(height: 20), // ボタン間のスペース
                RectangularButton(
                  text: 'B.しかく',
                  width: screenSize.width * 0.4,
                  height: screenSize.height * 0.1,
                  buttonColor: const Color.fromARGB(255, 255, 212, 193),
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HelpModeScreen()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                RectangularButton(
                  text: 'C.さんかく',
                  width: screenSize.width * 0.4,
                  height: screenSize.height * 0.1,
                  buttonColor: const Color.fromARGB(255, 255, 212, 193),
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HelpModeScreen()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                RectangularButton(
                  text: 'D.ほし',
                  width: screenSize.width * 0.4,
                  height: screenSize.height * 0.1,
                  buttonColor: const Color.fromARGB(255, 255, 212, 193),
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HelpModeScreen()),
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