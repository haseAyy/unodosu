import 'package:flutter/material.dart';
import 'Cleaning/HelpCleaningListScreen.dart';
import '../MeneScreen/HomeScreen.dart';

class HelpModeScreen extends StatelessWidget {
  const HelpModeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Scaffold(
      body: Stack(
        children: [
          // 背景（白基調にアクセントカラーを追加）
          Positioned.fill(
            child: Container(
              color: Colors.teal[50],
            ),
          ),
          // 上部デコレーション（柔らかい円形の装飾）
          Positioned(
            top: -screenHeight * 0.05, // 画面サイズに基づく位置調整
            left: -screenWidth * 0.1,
            child: Container(
              width: screenWidth * 0.5,
              height: screenWidth * 0.5,
              decoration: BoxDecoration(
                color: Colors.pinkAccent[100],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.1, // 画面サイズに基づく位置調整
            right: -screenWidth * 0.1,
            child: Container(
              width: screenWidth * 0.4,
              height: screenWidth * 0.4,
              decoration: BoxDecoration(
                color: Colors.greenAccent[100],
                shape: BoxShape.circle,
              ),
            ),
          ),
          // メインコンテンツ（カテゴリー画面）
          Positioned(
            top: screenHeight * 0.2, // 画面上部に配置
            left: 0,
            right: 0,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: const Text(
                    'もんだいをえらぼう！',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: screenHeight * 0.1),
                CategoryButton(
                  categoryName: 'おかたづけ',
                  description: 'おかたづけをしよう！\nおへやをきれいにしよう',
                  backgroundColor: const Color.fromARGB(255, 226, 199, 255),
                  icon: Icons.cleaning_services, // アイコン追加
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CleaningScreen()),
                    );
                  },
                ),
                SizedBox(height: screenHeight * 0.05), // ボタン間の間隔を画面サイズに基づく
                CategoryButton(
                  categoryName: 'おつかい',
                  description: 'おつかいをしよう！\nおかねをまなべるよ',
                  backgroundColor: const Color.fromARGB(255, 255, 212, 198),
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
            bottom: screenHeight * 0.03, // 画面サイズに基づく位置調整
            left: screenWidth * 0.05,
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
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02, horizontal: screenWidth * 0.05), // ボタン間の余白
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.03, horizontal: screenWidth * 0.05), // 内部余白
        height: screenHeight * 0.2, // ボタンの高さ
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
              size: screenWidth * 0.12, // アイコンの大きさ
              color: Colors.black54,
            ),
            SizedBox(width: screenWidth * 0.03), // アイコンとテキストの間隔
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  categoryName,
                  style: TextStyle(
                    fontSize: screenWidth * 0.05, // フォントサイズを画面幅に基づいて設定
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontFamily: 'Comic Sans MS', // ポップなフォント
                  ),
                ),
              ],
            ),
            SizedBox(width: screenWidth * 0.03), // 説明文とタイトルの間隔
            Expanded(
              child: Text(
                description,
                style: TextStyle(
                  fontSize: screenWidth * 0.03, // フォントサイズを画面幅に基づいて設定
                  color: Colors.black54,
                  fontFamily: 'Comic Sans MS',
                ),
                maxLines: null, // 最大行数を制限しない
                softWrap: true, // 改行を許可する
              ),
            ),
          ],
        ),
      ),
    );
  }
}
