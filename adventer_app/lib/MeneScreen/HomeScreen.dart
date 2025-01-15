import 'package:flutter/material.dart';
import '../EducationModeScreen/EducationModeScreen.dart';
import '../HelpModeScreen/HelpModeScreen.dart';
import '../ParentChildMode/ParentChildModeScreen.dart';

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

// ホーム画面
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          // 上部デコレーション（雲のような柔らかい円形）
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.blue[100],
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
                color: Colors.yellow[100],
                shape: BoxShape.circle,
              ),
            ),
          ),
          // タイトル部分
          Positioned(
            top: screenSize.height * 0.15,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  'ぼうけんにでてみよう',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                    fontFamily: 'Comic Sans MS',
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'モードをえらんでみよう！',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          // くまさんアイコン（タイトル部分の下に配置）
          Positioned(
            top: screenSize.height * 0.25, // 「モードを選んでみよう！」の下に配置
            left: (screenSize.width - 100) / 2, // 画面中央に配置
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.brown[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.pets, // くまさん風のアイコン
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // 長方形ボタン配置
          Align(
            alignment: Alignment.bottomCenter, // 下部に配置
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end, // これでボタンを下部に寄せる
              children: [
                RectangularButton(
                  title: 'おべんきょう',
                  description: 'たのしくまなぼう！',
                  buttonColor: Colors.green.shade100,
                  icon: Icons.school,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EducationModeScreen()),
                    );
                  },
                ),
                RectangularButton(
                  title: 'おてつだい',
                  description: 'いっしょにおてつだいしよう！',
                  buttonColor: Colors.yellow.shade100,
                  icon: Icons.volunteer_activism,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HelpModeScreen()),
                    );
                  },
                ),
                RectangularButton(
                  title: 'おやこ',
                  description: 'おやこでぼうけんをたのしもう！',
                  buttonColor: Colors.pink.shade100,
                  icon: Icons.family_restroom,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ParentChildModeScreen(
                              displayText: '星空を観察しよう!')),
                    );
                  },
                ),
                const SizedBox(height: 30), // ボタンの下に空白を追加
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 長方形ボタンの定義
class RectangularButton extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onPressed;
  final Color buttonColor;
  final IconData icon;

  const RectangularButton({
    super.key,
    required this.title,
    required this.description,
    required this.onPressed,
    required this.buttonColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(
            vertical: 5, horizontal: 10), // ボタン間の余白を狭める
        padding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 20), // 内部余白
        height: 150, // ボタンの高さを大きくする
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(20), // 角丸のサイズ
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(4, 6),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 60, // アイコンを大きくする
              color: Colors.black54,
            ),
            const SizedBox(width: 30), // アイコンとテキストの間隔
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22, // タイトルフォントサイズを大きく
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16, // 説明テキストを大きく
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}