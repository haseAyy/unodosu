import 'package:flutter/material.dart';
import 'Cleaning/HelpCleaningListScreen.dart';
<<<<<<< HEAD

//四角のボタンを定義
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
=======
import '../MeneScreen/HomeScreen.dart';

class HelpModeScreen extends StatelessWidget {
  const HelpModeScreen({super.key});
  
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
              decoration: BoxDecoration(
                color: Colors.pinkAccent[100],
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
              decoration: BoxDecoration(
                color: Colors.greenAccent[100],
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
                const SizedBox(height: 100),
                CategoryButton(
                  categoryName: 'おかたづけ',
                  description: 'おかたづけをしよう！\nおへやをきれいにしよう',
                  backgroundColor: const Color.fromARGB(255, 162, 243, 254),
                  icon: Icons.cleaning_services, // アイコン追加
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CleaningScreen()),
                    );
                  },
                ),
                const SizedBox(height: 50), // ボタン間の間隔を追加
                CategoryButton(
                  categoryName: 'おつかい',
                  description: 'おつかいをしよう！\nおかねをまなべるよ',
                  backgroundColor: const Color.fromARGB(255, 249, 255, 198),
                  icon: Icons.shopping_cart, // アイコン追加
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CleaningScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          // 左下の戻るボタン
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
              backgroundColor: Colors.grey[100],
              child: const Icon(Icons.arrow_back),
            ),
          ),
        ],
      ),
    );
  }
}

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
>>>>>>> origin/master
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
<<<<<<< HEAD
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: buttonColor, // 指定された色を使用
          borderRadius: BorderRadius.circular(10), // 角を少し丸める
=======
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20), // ボタン間の余白
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20), // 内部余白
        height: 150, // ボタンの高さ
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
>>>>>>> origin/master
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
<<<<<<< HEAD
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
=======
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
                  fontSize: 12,
                  color: Colors.black54,
                  fontFamily: 'Comic Sans MS',
                ),
                overflow: TextOverflow.ellipsis, // テキストが長くても切れるように
              ),
            ),
          ],
>>>>>>> origin/master
        ),
      ),
    );
  }
}
<<<<<<< HEAD

//お手伝い問題一覧画面(お手伝いモード)
class HelpModeScreen extends StatelessWidget {
  const HelpModeScreen({super.key});

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
          // おうちボタン
          Align(
          alignment: const Alignment(0.0, -0.3), // 横方向中央、縦方向は-0.5（上寄り）
          child: RectangularButton(
            text: 'おかたづけ',
            width: screenSize.width * 0.7, // 幅を画面幅の50%に設定
            height: screenSize.height * 0.15, // 高さを画面高さの10%に設定
            buttonColor: const Color.fromARGB(255, 255, 212, 193),
            textColor: Colors.black,
             onPressed: () {
               Navigator.push(
                  context,
                 MaterialPageRoute(builder: (context) => const CleaningScreen()),
                );
              },
            ),
        ),
        // おかねボタン
        Align(
          alignment: const Alignment(0.0, 0.3), // 横方向中央、縦方向は-0.5（上寄り）
          child: RectangularButton(
          text: 'おつかい',
          width: screenSize.width * 0.7, // 幅を画面幅の50%に設定
          height: screenSize.height * 0.15, // 高さを画面高さの10%に設定
          buttonColor: const Color.fromARGB(255, 245, 255, 187),
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
=======
>>>>>>> origin/master
