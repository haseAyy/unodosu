import 'package:flutter/material.dart';
import '../MeneScreen/HomeScreen.dart';
import 'Letter/LetterStartScreen.dart'; //もじスタート画面
import 'Color/ColorStartScreen.dart'; //いろスタート画面
import 'Calc/CalcStartScreen.dart'; //けいさんスタート画面
import 'Shape/ShapeStartScreen.dart'; //かたちスタート画面

// カテゴリーボタンのウィジェット
class CategoryButton extends StatelessWidget {
  final String categoryName;
  final String description;
  final Color backgroundColor;
  final IconData icon;
  final VoidCallback onPressed;

  const CategoryButton({
    super.key,
    required this.categoryName,
    required this.description,
    required this.backgroundColor,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        height: 120,
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
              icon,
              size: 40,
              color: Colors.black54,
            ),
            const SizedBox(width: 20),
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
                    fontFamily: 'Comic Sans MS',
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontFamily: 'Comic Sans MS',
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 教育モード画面
class EducationModeScreen extends StatelessWidget {
  const EducationModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.white,
            ),
          ),
          // 上部のデコレーション
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
          // メインコンテンツ
          Positioned(
            top: screenSize.height * 0.2,
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
                  icon: Icons.star,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ShapeStartScreen()),
                    );
                  },
                ),
                CategoryButton(
                  categoryName: 'いろ',
                  description: 'いろをまなぼう！\nカラフルなせかいがひろがるよ',
                  backgroundColor: Colors.blue.shade100,
                  icon: Icons.palette,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ColorStartScreen()),
                    );
                  },
                ),
                CategoryButton(
                  categoryName: 'もじ',
                  description: 'もじをまなぼう！\nたのしくもじをおぼえよう',
                  backgroundColor: Colors.green.shade100,
                  icon: Icons.text_fields,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LetterStartScreen()),
                    );
                  },
                ),
                CategoryButton(
                  categoryName: 'けいさん',
                  description: 'けいさんをまなぼう！\nけいさんをといてみよう',
                  backgroundColor: Colors.pink.shade100,
                  icon: Icons.calculate,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CalcStartScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          // 戻るボタン
          Positioned(
            bottom: 10,
            left: 10,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
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