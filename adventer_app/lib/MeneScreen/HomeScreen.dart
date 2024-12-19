import 'package:flutter/material.dart';
import '../EducationModeScreen/EducationModeScreen.dart';
import '../HelpModeScreen/HelpModeScreen.dart';
import '../ParentChildMode/ParentChildModeScreen.dart';

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
                      MaterialPageRoute(builder: (context) => const EducationModeScreen()),
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
                      MaterialPageRoute(builder: (context) => const HelpModeScreen()),
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
                      MaterialPageRoute(builder: (context) => const ParentChildModeScreen(displayText: '星空を観察しよう!')),
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
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: screenHeight * 0.01, // ボタン間の垂直間隔
          horizontal: screenWidth * 0.03, // ボタン間の横の余白
        ),
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.02, // ボタン内の上下余白
          horizontal: screenWidth * 0.05, // ボタン内の左右余白
        ),
        height: screenHeight * 0.16, // ボタンの高さは画面高さの18%
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(20),
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
              size: screenWidth * 0.14, // アイコンのサイズは画面幅の14%
              color: Colors.black54,
            ),
            SizedBox(width: screenWidth * 0.1), // アイコンとテキストの間隔
            Expanded(  // これでテキストが横幅に合わせて表示されるようにする
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: screenWidth * 0.06, // タイトルフォントサイズは画面幅の6%
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01), // タイトルと説明の間隔
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: screenWidth * 0.03, // 説明テキストは画面幅の5%
                      color: Colors.black54,
                    ),
                    overflow: TextOverflow.ellipsis, // 文字がはみ出る場合は「...」で省略
                    maxLines: 1, // 1行に制限
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
