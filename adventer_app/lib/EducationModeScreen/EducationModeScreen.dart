import 'package:flutter/material.dart';
import '../MeneScreen/HomeScreen.dart';
import 'Calc/CalcStartScreen.dart';
import 'Color/ColorStartScreen.dart';
import 'Letter/LetterStartScreen.dart';
import 'Shape/ShapeStartScreen.dart';

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
                      MaterialPageRoute(builder: (context) => const ShapeStartScreen()),
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
                      MaterialPageRoute(builder: (context) => const ColorStartScreen()),
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
                      MaterialPageRoute(builder: (context) => const LetterStartScreen()),
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
                      MaterialPageRoute(builder: (context) => const CalcStartScreen()),
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
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: screenSize.height * 0.01, horizontal: screenSize.width * 0.05), // ボタン間の余白
        padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.025, horizontal: screenSize.width * 0.05), // 内部余白（少し大きく）
        height: screenSize.height * 0.135, // ボタンの高さを12%に変更
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
              size: screenSize.width * 0.12, // アイコンの大きさを画面幅の12%に変更
              color: Colors.black54,
            ),
            SizedBox(width: screenSize.width * 0.05), // アイコンとテキストの間隔
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  categoryName,
                  style: TextStyle(
                    fontSize: screenSize.width * 0.05, // フォントサイズ（画面幅の7%に変更）
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontFamily: 'Comic Sans MS', // ポップなフォント
                  ),
                ),
              ],
            ),
            SizedBox(width: screenSize.width * 0.05), // 説明文とタイトルの間隔
            Expanded(
              child: Text(
                description,
                style: TextStyle(
                  fontSize: screenSize.width * 0.03, // フォントサイズ（画面幅の5%に変更）
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
