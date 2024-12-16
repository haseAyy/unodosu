import 'package:flutter/material.dart';
import 'Cleaning/HelpCleaningListScreen.dart';
import '../MeneScreen/HomeScreen.dart';

/*
// 四角のボタンを定義
class RectangularButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor; // ボタンの色
  final double width; // ボタンの幅
  final double height; // ボタンの高さ
  final Color textColor;

  const RectangularButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.buttonColor,
    this.width = 200, // デフォルト幅
    this.height = 60, // デフォルト高さ
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // MediaQueryキャッシュ
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),  // アニメーションを追加
        width: screenSize.width * 0.8,
        height: screenSize.height * 0.15,
        decoration: BoxDecoration(
          color: buttonColor, // 指定された色を使用
          border: Border.all(
            color: Colors.black, // 黒い枠線を追加
            width: 2,  // 枠線の太さ
          ),
          borderRadius: BorderRadius.circular(25), // 角をもっと丸くして柔らかく
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
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

// お手伝い問題一覧画面(お手伝いモード)
class HelpModeScreen extends StatelessWidget {
  const HelpModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // MediaQueryキャッシュ
    return Scaffold(
      body: Stack(
        children: [
          // 背景グラデーション（上部の水色、下部の緑色）
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.lightBlue[300]!, Colors.green[200]!],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          // 左下に戻るボタン
          Positioned(
            bottom: 10,
            left: 10,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context); // 前の画面に戻る
              },
              backgroundColor: Colors.grey[350],
              child: const Icon(Icons.arrow_back),
            ),
          ),
          // おうちボタン（中央より上）
          Align(
            alignment: const Alignment(0.0, -0.3), // 横方向中央、縦方向は-0.3（上寄り）
            child: RectangularButton(
              text: 'おかたづけ',
              width: screenSize.width * 0.7, // 幅を画面幅の70%に設定
              height: screenSize.height * 0.15, // 高さを画面高さの15%に設定
              buttonColor: Colors.pink.shade200,  // かわいいピンク
              textColor: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CleaningScreen()),
                );
              },
            ),
          ),
          // おかねボタン（中央より下）
          Align(
            alignment: const Alignment(0.0, 0.3), // 横方向中央、縦方向は0.3（下寄り）
            child: RectangularButton(
              text: 'おつかい',
              width: screenSize.width * 0.7, // 幅を画面幅の70%に設定
              height: screenSize.height * 0.15, // 高さを画面高さの15%に設定
              buttonColor: Colors.yellow.shade200, // かわいい黄色
              textColor: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpModeScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
*/



import 'package:flutter/material.dart';
import 'Cleaning/HelpCleaningListScreen.dart'; // 必要なインポート
import '../MeneScreen/HomeScreen.dart'; // ホーム画面へのインポート

class HelpModeScreen extends StatelessWidget {
  const HelpModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // MediaQueryキャッシュ
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal, // 横にスライド
        children: [
          // 「おかたづけ」の画面
          CategoryScreen(
            categoryName: 'おかたづけ',
            backgroundColor: const Color.fromARGB(255, 220, 168, 255),
            textColor: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CleaningScreen()), // おかたづけに遷移
              );
            },
          ),
          // 「おつかい」の画面
          CategoryScreen(
            categoryName: 'おつかい',
            backgroundColor: const Color.fromARGB(255, 253, 253, 125),
            textColor: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpModeScreen()), // おつかいに遷移
              );
            },
          ),
        ],
      ),
      // 左下の戻るボタン
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Builder(
        builder: (context) {
          return Positioned(
            bottom: 10,
            left: 10,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
              backgroundColor: Colors.grey[350],
              child: const Icon(Icons.arrow_back),
            ),
          );
        },
      ),
    );
  }
}

class CategoryScreen extends StatelessWidget {
  final String categoryName;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed; // ボタンが押された時に呼ばれる関数

  CategoryScreen({
    required this.categoryName,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor, // 背景色を設定
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$categoryName',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: textColor,
              fontFamily: 'Comic Sans MS', // ポップなフォント
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30), // テキストとボタンの間にスペースを追加
          // 「問題を始める」ボタン
          ElevatedButton(
            onPressed: onPressed, // ボタン押下時に遷移
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 249, 93, 91),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // 丸いボタン
              ),
              elevation: 5,
            ),
            child: Text(
              '問題を始める',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

