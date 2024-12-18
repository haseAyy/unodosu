import 'package:flutter/material.dart';
import 'ParentChildModeScreen.dart';

<<<<<<< HEAD
//四角のボタンを定義
=======
// 四角のボタンを定義
>>>>>>> origin/master
class RectangularButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor; // ボタンの色
  final double width; // ボタンの幅
  final double height; // ボタンの高さ
  final Color textColor;

  const RectangularButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.buttonColor,
    this.width = 200, // デフォルト幅
    this.height = 60, // デフォルト高さ
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
<<<<<<< HEAD
      child: Container(
=======
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),  // アニメーションを追加
>>>>>>> origin/master
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: buttonColor, // 指定された色を使用
<<<<<<< HEAD
          borderRadius: BorderRadius.circular(10), // 角を少し丸める
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
=======
          border: Border.all(
            color: Colors.black, // 黒い枠線を追加
            width: 2,  // 枠線の太さ
          ),
          borderRadius: BorderRadius.circular(25), // 角をもっと丸くして柔らかく
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
>>>>>>> origin/master
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}

<<<<<<< HEAD
//ユーザミッション設定画面(親子モード)
=======
// ユーザミッション設定画面(親子モード)
>>>>>>> origin/master
class MissionSettingsScreen extends StatelessWidget {
  const MissionSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'かんさつしよう！'; // 初期値をリストに存在する値に設定
    final screenSize = MediaQuery.of(context).size; // MediaQueryキャッシュ
<<<<<<< HEAD
=======

>>>>>>> origin/master
    return Scaffold(
      resizeToAvoidBottomInset: false, // キーボード表示時にリサイズを防ぐ
      body: Stack(  // Stackウィジェットを使って重ねる
        children: [
<<<<<<< HEAD
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
          // アニメーション背景（上部の水色、下部の緑色）
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(seconds: 3), // アニメーションの持続時間
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.lightBlue[300]!, Colors.green[200]!],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
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
          //ミッション設定適応ボタン
          Align(
          alignment: const Alignment(0.0, 0.5), // 横方向中央、縦方向は-0.5（上寄り）
          child: RectangularButton(
            text: '適用',
           width: screenSize.width * 0.7, // 幅を画面幅の57%に設定
           height: screenSize.height * 0.07, // 高さを画面高さの7%に設定,
           textColor: Colors.white,
           buttonColor: const Color.fromARGB(255, 215, 167, 167),
           onPressed: () {
              Navigator.push(
                context,
               MaterialPageRoute(builder: (context) => const ParentChildModeScreen(displayText: 'いちごをたべてみよう!', )),
             );
           },
         ),
        ),
        //ラベル
        Positioned(
          top: screenSize.height * 0.25, // 上部から30%の位置
          left: 0,
          right: 0,
          child: const Column(
            children: [
               Text(
               'ミッション内容', // ラベルのテキスト
                style: TextStyle(
                  fontSize: 30, // フォントサイズ
                  fontWeight: FontWeight.bold, // 太字
                  color: Colors.black, // ラベルの色
                ),
              ),
            ],
          ),
        ),
        //テキストボックス
        Positioned(
          top: screenSize.height * 0.35, // 上部から35%の位置
          left: 20,
          right: 20,
          child: Container(
            child: TextField(
              decoration: InputDecoration(
                labelText: 'ミッションのキーワードを入力してください',
                filled: true, // ボーダー内に背景色を適用
                fillColor: Colors.lightBlue[50], // 背景色を指定
=======
          // ミッション設定適応ボタン
          Align(
            alignment: const Alignment(0.0, 0.5), // 横方向中央、縦方向は0.5（中央）
            child: RectangularButton(
              text: '適用',
              width: screenSize.width * 0.7, // 幅を画面幅の57%に設定
              height: screenSize.height * 0.07, // 高さを画面高さの7%に設定
              textColor: Colors.white,
              buttonColor: const Color.fromARGB(255, 215, 167, 167),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ParentChildModeScreen(displayText: 'いちごをたべてみよう!',)
                  ),
                );
              },
            ),
          ),
          // ラベル
          Positioned(
            top: screenSize.height * 0.25, // 上部から30%の位置
            left: 0,
            right: 0,
            child: const Column(
              children: [
                Text(
                  'ミッション内容', // ラベルのテキスト
                  style: TextStyle(
                    fontSize: 30, // フォントサイズ
                    fontWeight: FontWeight.bold, // 太字
                    color: Colors.black, // ラベルの色
                  ),
                ),
              ],
            ),
          ),
          // テキストボックス
          Positioned(
            top: screenSize.height * 0.35, // 上部から35%の位置
            left: 20,
            right: 20,
            child: Container(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'ミッションのキーワードを入力してください',
                  filled: true, // ボーダー内に背景色を適用
                  fillColor: Colors.lightBlue[50], // 背景色を指定
>>>>>>> origin/master
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
<<<<<<< HEAD
          //プルダウン
=======
          // プルダウン
>>>>>>> origin/master
          Positioned(
            top: screenSize.height * 0.5,
            left: 20,
            right: 20,
            child: DropdownButtonFormField<String>(
              value: dropdownValue, // 初期値をリスト内の値に変更
              decoration: InputDecoration(
                labelText: 'カテゴリーを選択してください',
                filled: true, // ボーダー内に背景色を適用
                fillColor: Colors.lightBlue[50], // 背景色を指定
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: <String>['かんさつしよう！', 'たべてみよう！', 'ちょうせんしよう！']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                dropdownValue = newValue!; // 新しい値に更新
              },
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
