import '../../MeneScreen/HomeScreen.dart';
import 'dart:convert'; // JSONデータを扱うため
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'HelpErrandCorrectScreen.dart';
import 'HelpErrandIncrrectScreen.dart';
import 'HelpErrandResult.dart';
import 'dart:developer';

//  questionのデータモデル
class Question {
  final String questionId;
  final String questionTypeid;
  final String questionTheme;
  final String questionAnswer;
  final String questionContent;
  final String questionImage;
  final Map<String, String> options;

  Question({
    required this.questionId,
    required this.questionTypeid,
    required this.questionTheme,
    required this.questionAnswer,
    required this.questionContent,
    required this.questionImage,
    required this.options,
  });

  // JSONをQuestionオブジェクトに変換
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionId: json['question_id'],
      questionTypeid: json['questiontype_id'],
      questionTheme: json['question_theme'],
      questionAnswer: json['question_answer'],
      questionContent: json['question_content'],
      questionImage: json['question_image'],
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
    throw Exception('Failed to load question');
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
    throw Exception('回答の送信に失敗しました');
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


// おつかい問題出題画面
class HelpErrandScreen2 extends StatefulWidget {
  final int questionCount;
  final int correctCount;
  const HelpErrandScreen2(  {required this.questionCount, required this.correctCount});

  @override
  _HelpErrandScreen2State createState() =>
      _HelpErrandScreen2State(questionCount, correctCount);
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



class _HelpErrandScreen2State extends State<HelpErrandScreen2> {
    late Future<Question?> questionFuture;
  late int questionCount; // このクラス内で管理する変数
  late int correctCount; // 正解数を追跡する変数

  // コンストラクタで初期値を設定
  _HelpErrandScreen2State(this.questionCount, this.correctCount);

  @override
  void initState() {
    super.initState();
    questionFuture = fetchQuestion("KMS006"); // questiontypeIdを指定
  }

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
                Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen(),));
              },
              child: const Text('やめる'),
            ),
          ],
        );
      },
    );
  }
  
  // ユーザーが答えを選んだときに呼び出すメソッド
  void _handleAnswerSubmission(String selectedAnswerId, Question question, BuildContext context) async {
  try {
    final result = await submitAnswer(question.questionId, selectedAnswerId); // 非同期処理を待機

    setState(() {
      questionCount++; // 問題数をカウント
      if (result == "correct") {
        correctCount++; // 正解数をカウント
      }
    });

    if (questionCount >= 10) {
      // 10問解いたあとは結果画面に遷移
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HelpErrandResultScreen(correctCount: correctCount)),
      );
    } else {
      if (result == "correct") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HelpErrandCorrectScreen(questionCount: questionCount, correctCount: correctCount)),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HelpErrandIncorrectScreen(questionCount: questionCount, correctCount: correctCount, correctAnswer: question.questionAnswer)),
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
            return Center(child: Text('エラー: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final question = snapshot.data!;
            return Stack(
               children: [
                // 背景装飾
                Positioned(
                  top: -50,
                  left: -50,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(50, 255, 182, 193),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -50,
                  right: -50,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(50, 173, 216, 230),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
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
                // 問題テキストと選択肢
                Positioned(
                  top: screenSize.height * 0.15,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      const Text(
                        'このもじと\nおなじもじをみつけよう！',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Comic Sans MS',
                        ),
                      ),
                      const SizedBox(height: 60),
                      Container(
                        width: 160,
                        height: 160,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 154, 208, 255),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.network(
                            question.questionImage), // question_image（問題内容画像url)を表示
                          //question.question_image,
                          //style: const TextStyle(fontSize: 40),
                          //),
                        ),
                      ),
                    ],
                  ),
                ),
                // 選択肢ボタンエリア
                Positioned(
                  bottom: screenSize.height * 0.20,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      for (int i = 0; i < question.options.length; i += 2)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (i < question.options.length)
                              RectangularButton(
                                text: question.options.keys.toList()[i], //選択肢表示
                                buttonColor:
                                    const Color.fromARGB(255, 250, 240, 230),
                                textColor: Colors.black,
                                width: screenSize.width * 0.4,
                                height: 70,
                                onPressed: () {
                                  final selectedAnswerId = question
                                      .options.values
                                      .toList()[i]; //question.idを送信
                                  _handleAnswerSubmission(selectedAnswerId,
                                      question, context); // 修正箇所
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
                                  _handleAnswerSubmission(selectedAnswerId,
                                      question, context); // 修正箇所
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