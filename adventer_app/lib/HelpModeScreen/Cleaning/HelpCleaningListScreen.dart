import 'package:flutter/material.dart';

class CleaningScreen extends StatelessWidget {
  const CleaningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
<<<<<<< HEAD
          // 背景色
          Container(color: Colors.lightBlue[300]),
=======
          // 背景色（温かみのある色調）
          Container(color: Colors.teal[50]),

          // 上部デコレーション（円形の装飾）
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.orangeAccent[100],
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
              decoration: BoxDecoration(
                color: Colors.lightGreen[200],
                shape: BoxShape.circle,
              ),
            ),
          ),
>>>>>>> origin/master

          // 質問部分
          Positioned(
            top: screenSize.height * 0.1,
            left: screenSize.width * 0.1,
            right: screenSize.width * 0.1,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.orange, width: 2),
              ),
              child: const Text(
                'どこからおかたづけする？',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // アイコン付きボタンの配置
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1行目：ベッドとおふろ
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildIconButton(
                      icon: Icons.bed,
                      label: 'ベッド',
                      onPressed: () {
                        // ベッド選択時の処理
                      },
                    ),
                    _buildIconButton(
                      icon: Icons.bathtub,
                      label: 'おふろ',
                      onPressed: () {
                        // おふろ選択時の処理
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20), // ボタン間の隙間

                // 2行目：テーブル
                _buildIconButton(
                  icon: Icons.table_restaurant,
                  label: 'テーブル',
                  onPressed: () {
                    // テーブル選択時の処理
                  },
                ),
              ],
            ),
          ),

          // 左下の戻るボタン
          Positioned(
            bottom: 20,
            left: 20,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context); // 前の画面に戻る
              },
              backgroundColor: Colors.grey[350],
              child: const Icon(Icons.arrow_back),
            ),
          ),
        ],
      ),
    );
  }

  // アイコン付きボタンを作る関数
  Widget _buildIconButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
<<<<<<< HEAD
        IconButton(
          icon: Icon(icon, size: 50),
          onPressed: onPressed,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
=======
        // アイコンの位置を調整（上にずらしたり、左右にずらしたりできます）
        Padding(
          padding: const EdgeInsets.only(bottom: 10), // アイコンを下にずらす
          child: IconButton(
            icon: Icon(icon, size: 100), // アイコンのサイズ調整
            onPressed: onPressed,
          ),
        ),
        // テキストの位置調整（上または下にずらす）
        Text(
          label,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
>>>>>>> origin/master
        ),
      ],
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> origin/master
