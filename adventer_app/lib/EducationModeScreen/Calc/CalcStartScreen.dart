import 'package:flutter/material.dart';
import 'CalcEducationScreen.dart'; // 計算問題出題画面

// 計算問題スタート画面
class CalcStartScreen extends StatelessWidget {
  const CalcStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 戻るボタンを非表示
        backgroundColor: Colors.pink.shade100,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white, // 背景を白に統一
      body: GestureDetector(
        behavior: HitTestBehavior.opaque, // 空白部分でもタップを認識する
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CalcEducationScreen()),
          );
        },
        child: Stack(
          children: [
            // 背景画像を設定
            Positioned.fill(
              child: Image.asset(
                'assets/images/keisan_startScreen.png', // 画像ファイルのパス
                fit: BoxFit.cover, // 画面全体にフィットさせる
              ),
            ),
            // 上部の「けいさんもんだいスタート」テキスト
            Positioned(
              top: screenSize.height * 0.05,
              left: screenSize.width * 0.1,
              right: screenSize.width * 0.1,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color.fromARGB(255, 12, 137, 129), width: 2),
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(255, 232, 255, 253),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: const Text(
                      'けいさんもんだいスタート！',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Comic Sans MS',
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10), // 下のテキストとの間隔を確保
                  const Text(
                    'がめんをタップして！',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
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
