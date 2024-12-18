import 'package:flutter/material.dart';

<<<<<<< HEAD
class ImageUploadScreen extends StatelessWidget {
  const ImageUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // 背景カラー1（上部の水色）
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenSize.height * 0.9, // 上部90%
            child: Container(color: Colors.lightBlue[300]),
          ),
          // 背景カラー2（下部の緑色）
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: screenSize.height * 0.1, // 下部10%
            child: Container(color: Colors.green),
=======
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
>>>>>>> origin/master
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
<<<<<<< HEAD
          //ラベル
        Positioned(
          top: screenSize.height * 0.25, // 上部から30%の位置
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
          // 画像選択ボタン
          Positioned(
            top: screenSize.height * 0.3,
            left: screenSize.width * 0.25,
            child: GestureDetector(
              onTap: null, // 動作を無効化
              child: Container(
                width: screenSize.width * 0.5,
                height: screenSize.height * 0.3,
                color: Colors.white,
=======
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
>>>>>>> origin/master
                child: const Center(
                  child: Text('+', style: TextStyle(fontSize: 50)),
                ),
              ),
            ),
          ),
<<<<<<< HEAD
          // 送信ボタン
          Positioned(
            bottom: screenSize.height * 0.2,
            right: screenSize.width * 0.3,
            child: ElevatedButton(
              onPressed: null, // 動作を無効化
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade100,
                minimumSize: Size(screenSize.width * 0.4, screenSize.height * 0.07),
              ),
              child: const Text('送信', style: TextStyle(color: Colors.white)),
=======
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
>>>>>>> origin/master
            ),
          ),
        ],
      ),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> origin/master
