import 'package:flutter/material.dart';
import 'ShapeEducationScreen.dart'; // 形問題出題画面

// 形問題スタート画面
class ShapeStartScreen extends StatelessWidget {
  const ShapeStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    // 確認: screenSize.height は double 型であるはず
    double iconSize = 0.2 * screenSize.height;
    double fontSize = 0.04 * screenSize.height;

    // iconSize と fontSize が正常な double 値か確認
    print("Icon Size: $iconSize");
    print("Font Size: $fontSize");

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 戻るボタンを非表示
        backgroundColor: const Color.fromARGB(255, 173, 216, 230), // 淡い水色
        elevation: 0,
        title: const Text(
          'かたちもんだいスタート',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Comic Sans MS',
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white, // 背景を白に統一
      body: GestureDetector(
        onTap: () {
          // タップしたら形問題出題画面に遷移
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ShapeEducationScreen(), // 形問題出題画面に遷移
            ),
          );
        },
        child: Stack(
          children: [
            // 上部のソフトな装飾
            Positioned(
              top: -0.1 * screenSize.height,
              left: -0.1 * screenSize.width,
              child: Container(
                width: 0.3 * screenSize.width,
                height: 0.3 * screenSize.width,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(50, 173, 216, 230), // 薄い水色
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // 下部のソフトな装飾
            Positioned(
              bottom: -0.1 * screenSize.height,
              right: -0.1 * screenSize.width,
              child: Container(
                width: 0.4 * screenSize.width,
                height: 0.4 * screenSize.width,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(50, 255, 182, 193), // 薄いピンク
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // 中央のコンテンツ
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star_border,
                    size: iconSize, // ここで iconSize を直接使用
                    color: Colors.orange,
                  ),
                  SizedBox(height: 0.05 * screenSize.height), // 高さに基づいて余白を調整
                  Text(
                    'かたちもんだいをはじめよう！',
                    style: TextStyle(
                      fontSize: fontSize, // 画面高さに基づいてフォントサイズを調整
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Comic Sans MS',
                    ),
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
