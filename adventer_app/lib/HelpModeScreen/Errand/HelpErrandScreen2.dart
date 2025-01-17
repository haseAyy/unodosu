import 'package:flutter/material.dart';
import 'dart:convert'; // JSONデータを扱うため
import 'package:http/http.dart' as http;
import 'HelpErrandCorrectScreen2.dart';
import 'HelpErrandIncrrectScreen2.dart';
import 'HelpErrandResult.dart';
import '../../MeneScreen/HomeScreen.dart';
import 'dart:developer';


// questionのデータモデル
class Question {
  final String question_id;
  final String questiontype_id;
  final String question_theme;
  final String question_answer;
  final String question_content;
  final String question_image;
  final Map<String, String> options;

  Question({
    required this.question_id,
    required this.questiontype_id,
    required this.question_theme,
    required this.question_answer,
    required this.question_content,
    required this.question_image,
    required this.options,
  });

  // JSONをQuestionオブジェクトに変換
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question_id: json['question_id'],
      questiontype_id: json['questiontype_id'],
      question_theme: json['question_theme'],
      question_answer: json['question_answer'],
      question_content: json['question_content'],
      question_image: json['question_image'],
      options: json['options'] != null && json['options'].isNotEmpty
          ? Map<String, String>.from(json['options'])
          : {'No options available': ''}, // デフォルト値
    );
  }
}

// APIリクエストを送信して、問題を取得するメソッド
Future<Question?> fetchQuestion(String questiontypeId) async {
  final response = await http.get(
    Uri.parse(
        'http://10.24.110.66:8080/random-text-question?questiontype_id=$questiontypeId'),
  );

  if (response.statusCode == 200) {
    return Question.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('問題の取得に失敗しました');
  }
}

Future<String> submitAnswer(String questionId, String selectedAnswer) async {
  final response = await http.post(
    Uri.parse('http://10.24.110.66:8080/submit-answer'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'questionId': questionId,
      'answer': selectedAnswer,
    }),
  );

  if (response.statusCode == 200) {
    return response.body; // "correct" または "incorrect"
  } else {
    throw Exception('Failed to submit answer');
  }
}

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

// 色問題出題画面
class HelpErrandScreen extends StatefulWidget {
  final int questionCount;
  final int correctCount;
  const HelpErrandScreen(
      {required this.questionCount, required this.correctCount});

  @override
  _HelpErrandScreenState createState() =>
      _HelpErrandScreenState(questionCount, correctCount);
}

class HintIcon extends StatelessWidget {
  final VoidCallback onPressed;

  const HintIcon({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.lightbulb, color: Colors.orangeAccent, size: 30),
      onPressed: onPressed,
    );
  }
}

class _HelpErrandScreenState extends State<HelpErrandScreen> {
  late Future<Question?> questionFuture;
  late int questionCount; // このクラス内で管理する変数
  late int correctCount; // 正解数を追跡する変数

  // コンストラクタで初期値を設定
  _HelpErrandScreenState(this.questionCount, this.correctCount);

  //gpt
  //List<String> solvedQuestions = []; // 解いた問題を保存するリスト

  @override
  void initState() {
    super.initState();
    questionFuture = fetchQuestion("KMS006"); // questiontypeIdを指定
  }

/*
// 答えによって色変えるよんカスタム関数の追加
  Color _getColorFromAnswer(String answer) {
    switch (answer.toLowerCase()) {
      case "あか":
        return Colors.red;
      case "あお":
        return Colors.blue;
      case "みどり":
        return Colors.green;
      case "きいろ":
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }
*/
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
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // ダイアログを閉じて、問題一覧画面に戻る
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const HomeScreen()));
              },
              child: const Text('やめる'),
            ),
          ],
        );
      },
    );
  }

  // ユーザーが答えを選んだときに呼び出すメソッド
  void _handleAnswerSubmission(
      String selectedAnswerId, Question question, BuildContext context) async {
    try {
      final result =
          await submitAnswer(question.question_id, selectedAnswerId); // 修正
      debugPrint('問題数を増やす前: $questionCount');
      // 問題数をカウント
      setState(() {
        questionCount++; // 問題数をカウント
        if (result == "correct") {
          correctCount++; // 正解数をカウント
        }
      });
      debugPrint('問題数を増やした後: $questionCount');
      debugPrint('正解数: $correctCount');
      if (questionCount >= 10) {
        // 10問解いたあとは結果画面に遷移
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HelpErrandResultScreen(correctCount: correctCount)),
        );
      } else {
        if (result == "correct") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => EducationCorrectScreen(            
                    correctAnswer: "\n「${question.question_answer}」",
                    questionImage:  question.question_image,
                    questionCount: questionCount,
                    correctCount: correctCount,
                    nextScreenFlag: 'color')),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => EducationIncorrectScreen(
                    correctAnswer: "このおかねは \n 「${question.question_answer}」えん",
                    questionImage: question.question_image,
                    questionCount: questionCount,
                    correctCount: correctCount,
                    nextScreenFlag: 'color',)),
          );
        }
        // 次の問題を取得する処理を呼び出す
        if (questionCount < 5) {
          setState(() {
            questionFuture = fetchQuestion("KMS006"); // 次の問題を取得
          });
        }
      }
    } catch (e) {
      print("エラー: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('エラーが発生しました')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(141, 57, 154, 0),
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
      backgroundColor: Colors.white,
      body: FutureBuilder<Question?>(
        future: questionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final question = snapshot.data!;
            return Stack(
              children: [
                //背景(ノート風の罫線デザイン)
                /*Positioned.fill(
            child: CustomPaint(
              painter: SchoolBackgroundPainter(),
                 ),
                ),*/
                // 問題中断ボタン（左下）
                Positioned(
                  bottom: 30,
                  left: 10,
                  child: TextButton(
                    onPressed: () {
                      _showQuitDialog(context); // ダイアログを表示
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(141, 57, 154, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // 角丸
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 25),
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


                // 問題テキストと選択肢
                Positioned(
                  top: screenSize.height * 0.10,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      Text(
                        question.question_content,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Comic Sans MS',
                        ),
                      ),
                      
                SizedBox(
                  
                        width: screenSize.width * 7.0,
                        height: screenSize.height * 0.35,
                        child: Center(
                          child: Image.network(
                            question.question_image,
                             width: screenSize.width * 0.5, // 実際の画像の幅を指定
                             height: screenSize.height * 0.2, // 実際の画像の高さを指定
                                fit: BoxFit.contain, // アスペクト比を保持しつつ表示
                            ),
                        ),
                   
                       // )
                      
                      ),
                    ],
                  ),
                ),
                
                // 選択肢ボタンエリア
                Positioned(
                  bottom: screenSize.height * 0.15,
                  left: 0,
                  right: 20,
                  child: Column(
                    children: [
                      for (int i = 0; i < question.options.length; i += 2)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (i < question.options.length)
                              SizedBox(height: 90),
                            RectangularButton(
                              text:
                                  question.options.keys.toList()[i], // 選択肢のテキスト
                              buttonColor:
                                  const Color.fromARGB(255, 250, 240, 230),
                              textColor: Colors.black,
                              width: screenSize.width * 0.4,
                              height: 70,
                              onPressed: () {
                                final selectedAnswerId = question.options.values
                                    .toList()[i]; // question_idを送信
                                _handleAnswerSubmission(
                                    selectedAnswerId, question, context);
                              },
                            ),
                            if (i + 1 < question.options.length)
                              RectangularButton(
                                text: question.options.keys.toList()[i + 1],
                                buttonColor:
                                    const Color.fromARGB(255, 250, 240, 230),
                                textColor: Colors.black,
                                width: screenSize.width * 0.4,
                                height: 70,
                                onPressed: () {
                                  final selectedAnswerId =
                                      question.options.values.toList()[i + 1];
                                  _handleAnswerSubmission(
                                      selectedAnswerId, question, context);
                                },
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}

/*class SchoolBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final double lineSpacing = 40.0;

    // ノート風の横罫線を描画
    for (double y = 0; y < size.height; y += lineSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    // 左側の赤い縦線を描画
    final Paint marginPaint = Paint()
      ..color = Colors.red.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawLine(const Offset(50, 0), Offset(50, size.height), marginPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // 再描画は不要
  }
}*/