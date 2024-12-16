import 'package:flutter/material.dart';
import 'HomeScreen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height; // MediaQueryキャッシュ
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
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
            // ロゴとスタートテキスト
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min, // 中央にまとめて配置
                children: [
                  // ロゴ部分
                  Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orangeAccent[200],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.5),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'ぼくとわたしの\n探検ワールド',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50), // ロゴとテキストの間隔
                  // スタートテキスト
                  const Text(
                    '画面をタップして冒険を始めよう！',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Icon(
                    Icons.touch_app,
                    size: 36,
                    color: Colors.yellow[700],
                  ),
                ],
              ),
            ),
            // アニメーションする星（飾り）
            Positioned(
              top: 100,
              left: 50,
              child: _buildAnimatedStar(Colors.yellowAccent, 1.0),
            ),
            Positioned(
              top: 200,
              right: 60,
              child: _buildAnimatedStar(Colors.white, 0.8),
            ),
            Positioned(
              bottom: 100,
              left: 120,
              child: _buildAnimatedStar(Colors.orange, 1.2),
            ),
          ],
        ),
      ),
    );
  }

  // アニメーションする星の装飾
  Widget _buildAnimatedStar(Color color, double scale) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.8, end: 1.2),
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value * scale,
          child: child,
        );
      },
      onEnd: () {
        Future.delayed(const Duration(milliseconds: 300), () => const HomeScreen());
      },
      child: Icon(
        Icons.star,
        size: 40,
        color: color,
      ),
    );
  }
}



/*
class StartScreen extends StatelessWidget {
  const StartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('教育アプリ'),
        backgroundColor: Colors.orangeAccent,
      ),*/
    
        
      body: PageView(
        scrollDirection: Axis.horizontal, // 横にスライド
        children: [
          CategoryScreen(
            categoryName: 'かたち',
            backgroundColor: const Color.fromARGB(255, 252, 194, 214),
            textColor: Colors.white,
          ),
          CategoryScreen(
            categoryName: 'いろ',
            backgroundColor: const Color.fromARGB(255, 161, 225, 255),
            textColor: Colors.white,
          ),
          CategoryScreen(
            categoryName: 'もじ',
            backgroundColor: const Color.fromARGB(255, 135, 254, 133),
            textColor: Colors.black,
          ),
          CategoryScreen(
            categoryName: 'けいさん',
            backgroundColor: const Color.fromARGB(255, 248, 194, 151),
            textColor: Colors.white,
          ),
        ],
      ),
      // 左下の戻るボタン
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Builder(
        builder: (context) {
          return Positioned(
            bottom: 10,
            left: 10,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StartScreen(),
                  ),
                );
              },
              backgroundColor: Colors.grey[350],
              child: const Icon(Icons.arrow_back),
            ),
          );
        },
      ),
    );
  }
}

   

class CategoryScreen extends StatelessWidget {
  final String categoryName;
  final Color backgroundColor;
  final Color textColor;

  CategoryScreen({
    required this.categoryName,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor, // 背景色を設定
      child: Center(
        child: Text(
          '$categoryNameの問題を解こう！',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: textColor,
            fontFamily: 'Comic Sans MS', // ポップなフォント
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
*/
