import 'package:flutter/material.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key});

  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  bool _isButtonPressed = false; // ボタンの状態

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // 背景カラー1（上部の水色）と背景カラー2（下部の緑色）にアニメーションを追加
           Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.lightBlue[300]!, Colors.green[200]!],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              ),
            ),
          ),
          // 左下に戻るボタン
          Positioned(
            bottom: 10,
            left: 10,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context); // 前の画面に戻る
              },
              backgroundColor: Colors.grey[350],
              child: const Icon(Icons.arrow_back),
            ),
          ),
          // ラベル
          Positioned(
            top: screenSize.height * 0.25, // 上部から25%の位置
            left: 0,
            right: 0,
            child: const Column(
              children: [
                Text(
                  '写真を選択してください', // ラベルのテキスト
                  style: TextStyle(
                    fontSize: 20, // フォントサイズ
                    fontWeight: FontWeight.bold, // 太字
                    color: Colors.black, // ラベルの色
                  ),
                ),
              ],
            ),
          ),
          // 画像選択ボタン（タップ可能、アニメーションあり）
          Positioned(
            top: screenSize.height * 0.3, // 上部から30%の位置
            left: screenSize.width * 0.25, // 左から25%の位置
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isButtonPressed = !_isButtonPressed;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: screenSize.width * 0.5, // 画面幅の50%の幅
                height: screenSize.height * 0.3, // 画面高さの30%の高さ
                color: _isButtonPressed ? Colors.purple.shade200 : Colors.white,
                child: const Center(
                  child: Text('+', style: TextStyle(fontSize: 50)),
                ),
              ),
            ),
          ),
          // 送信ボタン（アニメーションあり）
          Positioned(
            bottom: screenSize.height * 0.2, // 下部から20%の位置
            right: screenSize.width * 0.3, // 右から30%の位置
            child: AnimatedOpacity(
              opacity: _isButtonPressed ? 1.0 : 0.5,
              duration: const Duration(milliseconds: 300),
              child: ElevatedButton(
                onPressed: () {
                  // 送信処理のコードを追加
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 68, 161, 14), // 赤色のボタン
                  minimumSize: Size(screenSize.width * 0.4, screenSize.height * 0.07), // ボタンのサイズ
                ),
                child: const Text('送信', style: TextStyle(color: Colors.white)), // ボタンテキスト
              ),
            ),
          ),
        ],
      ),
    );
  }
}
