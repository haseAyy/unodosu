import 'package:flutter/material.dart';
import 'ShapeEducationModeScreen.dart'; // 追加
import '../MeneScreen/HomeScreen.dart';

/*
import 'package:flutter/material.dart';

// 丸いボタンを定義
class CircularButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;  // ボタン色を追加

  const CircularButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.buttonColor,  // コンストラクタにcolorを追加
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // MediaQueryキャッシュ
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: screenSize.width * 0.4,
        height: screenSize.height * 0.4,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: buttonColor,  // 渡された色を使う
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
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

//教育問題一覧画面(教育モード)
class EducationModeScreen extends StatelessWidget {
  const EducationModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // MediaQueryキャッシュ
    return Scaffold(
      body: Stack(
        children: [
          // 背景カラー1（上部の水色）
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenSize.height * 0.9, // 上部90%
            child: Container(color: Colors.lightBlue[300]),
          ),
          // 背景カラー2（下部の緑色）
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: screenSize.height * 0.1, // 下部10%
            child: Container(color: Colors.green),
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
          // メインコンテンツ（丸いボタン）
          //形
          Positioned(
            bottom: screenSize.height * 0.6, // 画面下部から60%下に配置
            left: screenSize.width * 0.3, // ボタンを水平中央に配置
            child: CircularButton(
              text: 'かたち',
              buttonColor: Colors.orange.shade100, // かたちボタンの色
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EducationModeScreen()),
                );
              },
            ),
          ),
          //色
          Positioned(
            bottom: screenSize.height * 0.4, // 画面下部から40%下に配置
            left: screenSize.width * 0.3, // ボタンを水平中央に配置
            child: CircularButton(
              text: 'いろ',
              buttonColor: Colors.blue.shade100,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EducationModeScreen()),
                );
              },
            ),
          ),
          //文字
          Positioned(
            bottom: screenSize.height * 0.2,
            right: screenSize.width * 0.3,
            child: CircularButton(
              text: 'もじ',
              buttonColor: Colors.red.shade100,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EducationModeScreen()),
                );
              },
            ),
          ),
          //計算
          Positioned(
            bottom: screenSize.width * 0.0,
            left: screenSize.width * 0.3,
            child: CircularButton(
              text: 'けいさん',
              buttonColor: Colors.orangeAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EducationModeScreen()),
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


class EducationModeScreen extends StatelessWidget {
  const EducationModeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal, // 横にスライド
        children: [
          CategoryScreen(
            categoryName: 'かたち',
            backgroundColor: const Color.fromARGB(255, 252, 194, 214),
            textColor: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShapeEducationModeScreen()), // おかたづけに遷移
              );
            },
          ),
          CategoryScreen(
            categoryName: 'いろ',
            backgroundColor: const Color.fromARGB(255, 161, 225, 255),
            textColor: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShapeEducationModeScreen()), // おかたづけに遷移
              );
            },
          ),
          CategoryScreen(
            categoryName: 'もじ',
            backgroundColor: const Color.fromARGB(255, 135, 254, 133),
            textColor: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShapeEducationModeScreen()), // おかたづけに遷移
              );
            },
          ),
          CategoryScreen(
            categoryName: 'けいさん',
            backgroundColor: const Color.fromARGB(255, 248, 194, 151),
            textColor: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShapeEducationModeScreen()), // おかたづけに遷移
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
            onPressed: () {
              // ボタンを押すとShapeEducationModeScreenに遷移
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShapeEducationModeScreen(),
                ),
              );
            },
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
