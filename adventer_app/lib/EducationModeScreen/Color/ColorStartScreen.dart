import 'package:flutter/material.dart';
import 'ColorEducationScreen.dart'; // 色問題出題画面

// 色問題スタート画面
class ColorStartScreen extends StatefulWidget {
  const ColorStartScreen({super.key});

  @override
  _ColorStartScreenState createState() => _ColorStartScreenState();
}

class _ColorStartScreenState extends State<ColorStartScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // アニメーションコントローラーを初期化
    _controller = AnimationController(
      duration: const Duration(seconds: 5), // アニメーションの速度を遅く調整
      vsync: this,
    )..repeat(reverse: true);

    // 控えめな拡大縮小アニメーション
    _animation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 戻るボタンを非表示
        backgroundColor: const Color.fromARGB(141, 57, 154, 0),
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white, // 背景を白に統一
      body: GestureDetector(
        behavior: HitTestBehavior.opaque, // 空白部分でもタップを認識する
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ColorEducationScreen()),
          );
        },
        child: Stack(
          children: [
            // カラフルな円のアニメーション
            _buildColorfulCircle(screenSize, 0.2, 0.1, Colors.orange),
            _buildColorfulCircle(screenSize, 0.5, 0.7, Colors.green),
            _buildColorfulCircle(screenSize, 0.25, 0.35, Colors.blue),
            _buildColorfulCircle(screenSize, 0.7, 0.6, Colors.purple),
            _buildColorfulCircle(screenSize, 0.6, 0.3, Colors.red),
            _buildColorfulCircle(screenSize, 0.4, 0.55, const Color.fromARGB(255, 244, 54, 197)),
            //_buildColorfulCircle(screenSize, 0.4, 0.5, const Color.fromARGB(255, 159, 77, 100)),
            //_buildColorfulCircle(screenSize, 0.7, 0.15, const Color.fromARGB(255, 244, 228, 54)),
            _buildColorfulCircle(screenSize, 0.75, 0.4, const Color.fromARGB(255, 158, 244, 54)),
            _buildColorfulCircle(screenSize, 0.55, 0.05, const Color.fromARGB(255, 54, 244, 152)),
            _buildColorfulCircle(screenSize, 0.15, 0.6, const Color.fromARGB(255, 244, 225, 54)),
            _buildColorfulCircle(screenSize, 0.4, 0.1, const Color.fromARGB(255, 54, 105, 244)),

            // 上部の「いろもんだいスタート」テキスト
            Positioned(
              top: screenSize.height * 0.05,
              left: screenSize.width * 0.1,
              right: screenSize.width * 0.1,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color.fromARGB(255, 179, 181, 27), width: 2),
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(255, 254, 255, 232),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: const Text(
                      'いろもんだいスタート！',
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

  // カラフルな円を配置するメソッド
  Widget _buildColorfulCircle(Size screenSize, double top, double left, Color color) {
    return Positioned(
      top: screenSize.height * top,
      left: screenSize.width * left,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: child,
          );
        },
        child: Container(
          width: 130, // 円のサイズを大きく調整
          height: 130, // 円のサイズを大きく調整
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.7),
          ),
        ),
      ),
    );
  }
}
