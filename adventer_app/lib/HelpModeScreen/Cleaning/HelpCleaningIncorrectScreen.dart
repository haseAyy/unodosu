import 'package:adventer_app/HelpModeScreen/Cleaning/Bed/HelpBedScreen.dart';
import 'package:flutter/material.dart';
import 'Bed/HelpBedScreen.dart'; // ベッドの画面
import 'Bath/HelpBathScreen.dart'; // おふろの画面
import 'package:http/http.dart' as http; // httpパッケージをインポート
import 'dart:convert'; // jsonDecodeを使うためにインポート

// 四角いボタンを定義
class RectangularButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;
  final double width;
  final double height;
  final Color textColor;

  const RectangularButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.buttonColor,
    this.width = 200,
    this.height = 60,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(20), // ボタンの角を丸く
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(3, 5),
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
              fontFamily: 'Comic Sans MS', // フォントを統一
            ),
          ),
        ),
      ),
    );
  }
}

// 不正解画面
class HelpCleaningIncorrectScreen extends StatefulWidget {
  final String message; // 受け取るメッセージ（いろ、もじなど）
  final int questionCount;
  final int correctCount;
  final String? correctAnswer; // 正解の答えを追加
  final String selectedAnswerContent; // 選択した答え
  final String questionId; //質問id

  const HelpCleaningIncorrectScreen(
      {Key? key,
      required this.message,
      required this.questionCount,
      required this.correctCount,
      this.correctAnswer,
      required this.selectedAnswerContent, // 選択した答え
      required this.questionId})
      : super(key: key);

  @override
  _HelpCleaningIncorrectScreenState createState() =>
      _HelpCleaningIncorrectScreenState();
}

class _HelpCleaningIncorrectScreenState
    extends State<HelpCleaningIncorrectScreen> {
  String? imageUrl; // 画像URLを保存する変数

  @override
  void initState() {
    super.initState();
    _fetchGif();
  }

  // 選択した答えに基づいて画像URLを取得
  Future<void> _fetchGif() async {
    final response = await http.get(
      Uri.parse(
          'http://10.24.110.65:8080/api/getGifByAnswer?message=${widget.message}&selectedAnswer=${widget.selectedAnswerContent}&questionId=${widget.questionId}'),
    );

    if (response.statusCode == 200) {
      setState(() {
        imageUrl = response.body; // 画像URLを設定
        print("GIF URL: $imageUrl"); // デバッグ用にURLを表示 // JSON形式で返ってきた画像URLを設定
      });
    } else {
      throw Exception('Failed to load Gif');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 戻るボタンを非表示
        backgroundColor: const Color.fromARGB(255, 222, 94, 94),
        elevation: 0,
        title: const Text(
          'おしい！',
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
      body: Stack(
        children: [
          // 上部のソフトな装飾
          Positioned(
            top: -0.1 * screenSize.height,
            left: -0.1 * screenSize.width,
            child: Container(
              width: 0.3 * screenSize.width,
              height: 0.3 * screenSize.width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(50, 255, 182, 193), // 薄いピンク
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
                color: Color.fromARGB(50, 173, 216, 230), // 薄い水色
                shape: BoxShape.circle,
              ),
            ),
          ),
          // 中央のコンテンツ
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // アイコンのサイズを画面の高さに基づいて調整
                Icon(
                  Icons.cancel_outlined,
                  size: 0.2 * screenSize.height, // 画面高さに基づいてアイコンのサイズを決定
                  color: Colors.red,
                ),
                SizedBox(height: 0.05 * screenSize.height), // 高さに基づいて余白を調整
                // GIFの画像を表示（URLが取得できていれば）
                // GIFを表示
                Expanded(
                  child: imageUrl != null
                      ? Image.network(
                          imageUrl!, // 取得したGIF URLを使用
                          width: 0.5 * screenSize.width,
                          height: 0.3 * screenSize.height,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child; // 完全に読み込まれたら表示
                            }
                            return Center(
                              child:
                                  CircularProgressIndicator(), // 読み込み中にインジケーターを表示
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.error,
                                      color: Colors.red, size: 50), // エラーアイコン
                                  Text("画像を読み込めませんでした",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 18)),
                                  Text("URL: $imageUrl",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black)),
                                ],
                              ),
                            );
                          },
                        )
                      : const SizedBox.shrink(), // 画像URLがない場合、空のウィジェットを表示
                ),
                SizedBox(height: 0.08 * screenSize.height), // 高さに基づいて余白を調整
                // 解説部分
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(
                      horizontal: 0.1 * screenSize.width), // ここを修正
                  decoration: BoxDecoration(
                    color: Colors.transparent, // 背景色を透明に設定
                    border: Border.all(
                      color: const Color.fromARGB(255, 205, 205, 205), // 枠の色
                      width: 2, // 枠の太さ
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 182, 182, 182)
                            .withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    widget.correctAnswer != null
                        ? '解説: このもんだいの答えは「${widget.correctAnswer}」だよ。次回はもっとがんばろう！'
                        : '次回もがんばろう！', //correctAnswerがない場合
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Comic Sans MS',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 0.08 * screenSize.height), // 高さに基づいて余白を調整
                RectangularButton(
                    text: 'つぎのもんだい',
                    width: 0.6 * screenSize.width, // 幅を画面幅に基づいて調整
                    height: 0.1 * screenSize.height, // 高さを画面高さに基づいて調整
                    buttonColor: const Color.fromARGB(255, 250, 240, 230),
                    textColor: Colors.black,
                    onPressed: () {
                      // 遷移前にデバッグ出力
                      print("遷移先画面: ${widget.message}");
                      print(
                          "遷移前: questionCount: ${widget.questionCount}, correctCount: ${widget.correctCount}");
                      // メッセージに基づいて遷移先を変更
                      if (widget.message == "ベッド") {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HelpBedScreen(
                              questionCount: widget.questionCount,
                              correctCount: widget.correctCount,
                            ),
                          ),
                        );
                      } else if (widget.message == "おふろ") {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HelpBathScreen(
                              questionCount: widget.questionCount,
                              correctCount: widget.correctCount,
                            ),
                          ),
                        );
                      } else if (widget.message == "つくえ") {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HelpBedScreen(
                              questionCount: widget.questionCount,
                              correctCount: widget.correctCount,
                            ),
                          ),
                        );
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
