import 'package:flutter/material.dart';
import 'ColorEducationScreen.dart'; // 色教育画面への遷移

class ColorStartScreen extends StatelessWidget {
  const ColorStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: Colors.white, // 背景を真っ白に設定
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'いろをまなぼう！', // タイトルを統一
              style: TextStyle(
                fontSize: 28, // ShapeStartScreenと同じサイズ
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ColorEducationScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.2,
                  vertical: screenHeight * 0.02,
                ),
                backgroundColor: const Color.fromARGB(255, 237, 165, 9), // ShapeStartScreenと一致
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
              ),
              child: const Text(
                'スタート', // ボタンテキストのスタイルを統一
                style: TextStyle(
                  fontSize: 30, // ShapeStartScreenと同じフォントサイズ
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
