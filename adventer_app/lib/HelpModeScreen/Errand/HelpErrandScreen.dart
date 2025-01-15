import '../../MeneScreen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'HelpErrandCorrectScreen.dart';
import 'HelpErrandIncrrectScreen.dart';
import 'HelpErrandResult.dart';
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
          borderRadius: BorderRadius.circular(20),
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
              fontFamily: 'Comic Sans MS',
            ),
          ),
        ),
      ),
    );
  }
}

// おつかい問題出題画面
class HelpErrandScreen extends StatelessWidget {
  const HelpErrandScreen({super.key});

  // ポップアップダイアログを表示する関数
  void _showQuitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ほんとうにやめる？'),
          content: const Text('もんだいをおわってもいいですか？'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // ダイアログを閉じる
              },
              child: const Text('つづける'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // ダイアログを閉じて、問題一覧画面に戻る
                Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen(initialIndex: 2),));
              },
              child: const Text('やめる'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 戻るボタンを非表示にする
        backgroundColor: const Color.fromARGB(255, 255, 104, 96),
        elevation: 0,
        title: const Text(
          'おつかいもんだい',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Comic Sans MS',
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white, // 背景を白に統一
      body: Stack(
        children: [
          // 背景色（温かみのある色調）
          Container(color: Colors.teal[50]),

          // 上部デコレーション（円形の装飾）
          Positioned(
            top: -screenHeight * 0.05, // 画面サイズに基づく位置調整
            left: -screenWidth * 0.1,
            child: Container(
              width: screenWidth * 0.4, // 画面サイズに基づくサイズ調整
              height: screenWidth * 0.4,
              decoration: BoxDecoration(
                color: Colors.orangeAccent[100],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.2, // 画面サイズに基づく位置調整
            right: -screenWidth * 0.1,
            child: Container(
              width: screenWidth * 0.3,
              height: screenWidth * 0.3,
              decoration: BoxDecoration(
                color: Colors.lightGreen[200],
                shape: BoxShape.circle,
              ),
            ),
          ),
          // 問題中断ボタン（左下）
          Positioned(
            bottom: screenSize.height * 0.05, // 位置調整
            left: 10,
            child: TextButton(
              onPressed: () {
                _showQuitDialog(context); // ダイアログを表示
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 104, 96),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // 角丸
                ),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              ),
              child: const Text(
                'やめる',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // テキストカラー（白）
                  fontFamily: 'Comic Sans MS', // フォント
                ),
              ),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.45, // 適切な位置に調整
            right: screenSize.width * 0.05, // 適切な位置に調整
            child: HintIcon(
              onPressed: () {
                // ヒントのポップアップ表示
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // 角丸
                      ),
                      title: const Center(
                        child: Text(
                          'ヒント',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Comic Sans MS',
                          ),
                        ),
                      ),
                      content:const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                         SizedBox(height: 10), // 少し余白を追加
                          Row(
                            children: [
                             SizedBox(width: 10),
                             Text(
                                '①  →  １えん',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  fontFamily: 'Comic Sans MS',
                                ),
                              ),
                            ],
                          ),
                         SizedBox(height: 10), // 少し余白を追加
                          Row(
                            children: [
                              
                             SizedBox(width: 10),
                             Text(
                                '⑤  →  ５えん',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  fontFamily: 'Comic Sans MS',
                                ),
                              ),
                            ],
                          ),
                         SizedBox(height: 10), // 少し余白を追加
                          Row(
                            children: [
                              
                             SizedBox(width: 10),
                             Text(
                                '⑩  →  １０えん',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  fontFamily: 'Comic Sans MS',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      actions: [
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context); // ポップアップを閉じる
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 255, 104, 96),
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 30,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20), // ボタンの角丸
                              ),
                            ),
                            child: const Text(
                              '閉じる',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Comic Sans MS',
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          // 問題テキスト
          Positioned(
            top: screenSize.height * 0.15,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const Text(
                  'おかねはいくらでしょう？',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comic Sans MS',
                  ),
                ),
                const SizedBox(height: 60),
                // 問題の丸
                Container(
                  width: screenSize.width * 0.4, // 比率調整
                  height: screenSize.width * 0.4, // 比率調整
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 154, 208, 255),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          // ボタンエリア
          Positioned(
            bottom: screenSize.height * 0.15, // 位置調整
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RectangularButton(
                      text: 'A.５００えん',
                      buttonColor: const Color.fromARGB(255, 250, 240, 230),
                      textColor: Colors.black,
                      width: screenSize.width * 0.4, // 横幅調整
                      height: 70, // 高さ調整
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpErrandCorrectScreen()));
                      },
                    ),
                    RectangularButton(
                      text: 'B.３００えん',
                      buttonColor: const Color.fromARGB(255, 250, 240, 230),
                      textColor: Colors.black,
                      width: screenSize.width * 0.4, // 横幅調整
                      height: 70, // 高さ調整
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpErrandIncorrectScreen()));
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RectangularButton(
                      text: 'C.１２０えん',
                      buttonColor: const Color.fromARGB(255, 250, 240, 230),
                      textColor: Colors.black,
                      width: screenSize.width * 0.4, // 横幅調整
                      height: 70, // 高さ調整
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpErrandIncorrectScreen()));
                      },
                    ),
                    RectangularButton(
                      text: 'D.２０００えん',
                      buttonColor: const Color.fromARGB(255, 250, 240, 230),
                      textColor: Colors.black,
                      width: screenSize.width * 0.4, // 横幅調整
                      height: 70, // 高さ調整
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpErrandResultScreen()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HintIcon extends StatelessWidget {
  final VoidCallback onPressed;

  const HintIcon({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.yellow[100],
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 6,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            Icons.lightbulb_outline,
            size: 32,
            color: Colors.orangeAccent,
          ),
        ),
      ),
    );
  }
}