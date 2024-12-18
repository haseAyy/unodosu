<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'ShapeEducationModeScreen.dart';
import 'wordsEducationModeScreen.dart';
import '../MeneScreen/HomeScreen.dart';

// 丸いボタンを定義
class CircularButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor; // ボタン色を追加

  const CircularButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.buttonColor, // コンストラクタにcolorを追加
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
          color: buttonColor, // 渡された色を使う
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
=======
import 'package:adventer_app/EducationModeScreen/CalcEducationScreen.dart';
import 'package:adventer_app/EducationModeScreen/LetterEducationScreen.dart';
import 'package:flutter/material.dart';
import 'ShapeEducationScreen.dart'; 
import 'ColorEducationScreen.dart';
import '../MeneScreen/HomeScreen.dart';

class EducationModeScreen extends StatelessWidget {
  const EducationModeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // 背景（白基調にアクセントカラーを追加）
          Positioned.fill(
            child: Container(
              color: Colors.white,
            ),
          ),
          // 上部デコレーション（柔らかい円形の装飾）
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 116, 253, 201),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 100,
            right: -30,
            child: Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 226, 180, 255),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // メインコンテンツ（カテゴリー画面）
          Positioned(
            top: screenSize.height * 0.2, // 画面上部に配置
            left: 0,
            right: 0,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'もんだいをえらぼう！',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                CategoryButton(
                  categoryName: 'かたち',
                  description: 'かたちをまなぼう！\nいろんなかたちをさがそう',
                  backgroundColor: Colors.orange.shade100,
                  icon: Icons.star, // アイコン追加
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ShapeEducationScreen()),
                    );
                  },
                ),
                CategoryButton(
                  categoryName: 'いろ',
                  description: 'いろをまなぼう！\nカラフルなせかいがひろがるよ',
                  backgroundColor: Colors.blue.shade100,
                  icon: Icons.palette, // アイコン追加
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ColorEducationScreen()),
                    );
                  },
                ),
                CategoryButton(
                  categoryName: 'もじ',
                  description: 'もじをまなぼう！\nたのしくもじをおぼえよう',
                  backgroundColor: Colors.green.shade100,
                  icon: Icons.text_fields, // アイコン追加
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LetterEducationScreen()),
                    );
                  },
                ),
                CategoryButton(
                  categoryName: 'けいさん',
                  description: 'けいさんをまなぼう！\nけいさんをといてみよう',
                  backgroundColor: Colors.pink.shade100,
                  icon: Icons.calculate, // アイコン追加
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CalcEducationScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          // 左下の戻るボタン
>>>>>>> origin/master
          Positioned(
            bottom: 10,
            left: 10,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
<<<<<<< HEAD
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
                  MaterialPageRoute(
                      builder: (context) => const ShapeEducationModeScreen()),
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
                  MaterialPageRoute(
                      builder: (context) => const EducationModeScreen()),
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
                  MaterialPageRoute(
                      builder: (context) => const wordsEducationModeScreen()),
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
                  MaterialPageRoute(
                      builder: (context) => const EducationModeScreen()),
                );
              },
            ),
          ),
=======
              backgroundColor: Colors.grey[100],
              child: const Icon(Icons.arrow_back),
            ),
          ),
>>>>>>> origin/master
        ],
      ),
    );
  }
}
<<<<<<< HEAD
=======

class CategoryButton extends StatelessWidget {
  final String categoryName;
  final String description; // 説明文を追加
  final Color backgroundColor;
  final IconData icon; // アイコンを追加
  final VoidCallback onPressed;

  const CategoryButton({
    super.key,
    required this.categoryName,
    required this.description,
    required this.backgroundColor,
    required this.icon, // アイコンを追加
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20), // ボタン間の余白
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20), // 内部余白
        height: 120, // ボタンの高さ
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(4, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon, // アイコンを表示
              size: 40, // アイコンの大きさ
              color: Colors.black54,
            ),
            const SizedBox(width: 20), // アイコンとテキストの間隔
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  categoryName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontFamily: 'Comic Sans MS', // ポップなフォント
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20), // 説明文とタイトルの間隔
            Expanded(
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontFamily: 'Comic Sans MS',
                ),
                overflow: TextOverflow.ellipsis, // テキストが長くても切れるように
              ),
            ),
          ],
        ),
      ),
    );
  }
}
>>>>>>> origin/master
