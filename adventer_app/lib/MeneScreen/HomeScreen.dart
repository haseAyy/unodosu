import 'package:flutter/material.dart';
import 'StartScreen.dart';
import '../EducationModeScreen/EducationModeScreen.dart';
import '../HelpModeScreen/HelpModeScreen.dart';
import '../ParentChildMode/ParentChildModeScreen.dart';

// 丸いボタンを定義（かわいらしいアニメーションとアイコンを追加）
class CircularButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;
  final IconData icon;  // アイコンを追加

  const CircularButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.buttonColor,
    required this.icon,  // アイコンも受け取る
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),  // アニメーションを追加
        width: screenSize.width * 0.4,
        height: screenSize.height * 0.4,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: buttonColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(4, 6),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,  // アイコンを大きめに設定
                color: Colors.black87,
              ),
              const SizedBox(height: 10),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
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
    final screenSize = MediaQuery.of(context).size; // MediaQueryキャッシュ
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StartScreen()),
        );
      },
      child: Scaffold(
        body: Stack(
          children: [
            // 背景カラー1（上部のグラデーション）
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StartScreen(),
                    ),
                  );
                },
                backgroundColor: Colors.grey[350],
                child: const Icon(Icons.arrow_back),
              ),
            ),
            // メインコンテンツ（丸いボタン）配置
            Positioned(
              top: screenSize.height * 0.35, // 画面上部から35%下に配置
              left: screenSize.width * 0.3, // ボタンを水平中央に配置
              child: CircularButton(
                text: 'おべんきょう',
                buttonColor: Colors.green.shade100,
                icon: Icons.school,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EducationModeScreen()),
                  );
                },
              ),
            ),
            Positioned(
              bottom: screenSize.width * 0.1,
              left: screenSize.width * 0.05,
              child: CircularButton(
                text: 'おてつだい',
                buttonColor: Colors.yellow.shade100,
                icon: Icons.volunteer_activism,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HelpModeScreen()),
                  );
                },
              ),
            ),
            Positioned(
              bottom: screenSize.width * 0.1,
              right: screenSize.width * 0.05,
              child: CircularButton(
                text: 'おやこ',
                buttonColor: Colors.pink.shade100,
                icon: Icons.family_restroom,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ParentChildModeScreen(displayText: '星空を観察しよう!')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}