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
                  description: 'かたちをまなぼう！\nいろんなかたちをさがしてみてね',
                  backgroundColor: Colors.orange.shade100,
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LetterEducationScreen()),
                    );
                  },
                ),
                CategoryButton(
                  categoryName: 'けいさん',
                  description: 'けいさんをまなぼう！\nかんたんなけいさんをとこう',
                  backgroundColor: Colors.pink.shade100,
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
  final VoidCallback onPressed;

  const CategoryButton({
    super.key,
    required this.categoryName,
    required this.description,
    required this.backgroundColor,
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
