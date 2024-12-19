import 'package:flutter/material.dart';
import 'CalcEducationScreen.dart'; // 計算問題出題画面

// 計算問題スタート画面
class CalcStartScreen extends StatefulWidget {
  const CalcStartScreen({super.key});

  @override
  _CalcStartScreenState createState() => _CalcStartScreenState();
}

class _CalcStartScreenState extends State<CalcStartScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // アニメーションコントローラーを初期化
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // 数字が上下に動くアニメーション
    _animation = Tween<double>(begin: 0, end: -30).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    // アニメーション開始
    _controller.forward();
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
            MaterialPageRoute(builder: (context) => const CalcEducationScreen()),
          );
        },
        child: Stack(
          children: [
            // 数字がふよふよ浮いているアニメーション
            _buildFloatingNumber(screenSize, '1', 0.35, 0.1, Colors.orange, 0.15),
            _buildFloatingNumber(screenSize, '2', 0.6, 0.7, Colors.green, 0.1),
            _buildFloatingNumber(screenSize, '3', 0.25, 0.65, Colors.blue, 0.12),
            _buildFloatingNumber(screenSize, '4', 0.65, 0.2, Colors.purple, 0.15),
            _buildFloatingNumber(screenSize, '5', 0.45, 0.45, Colors.red, 0.1),
            _buildFloatingNumber(screenSize, '6', 0.15, 0.3, const Color.fromARGB(255, 173, 217, 30), 0.12),
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

  // 数字を配置するメソッド
  Widget _buildFloatingNumber(Size screenSize, String text, double top, double left, Color color, double sizeFactor) {
    return Positioned(
      top: screenSize.height * top,
      left: screenSize.width * left,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _animation.value),
            child: child,
          );
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: screenSize.height * sizeFactor,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
