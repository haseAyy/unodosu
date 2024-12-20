import 'package:flutter/material.dart';
import 'dart:convert'; // JSONデータを扱うため
import 'package:http/http.dart' as http;
import 'EducationCorrectScreen.dart'; //正解画面
import 'EducationIncorrectScreen.dart'; //不正解画面
import 'EducationModeScreen.dart';

// questionのデータモデル
class Question {
  final String question_id;
  final String questiontype_id;
  final String question_theme;
  final String question_answer;
  final String question_content;
  final Map<String, String> options;

  Question({
    required this.question_id,
    required this.questiontype_id,
    required this.question_theme,
    required this.question_answer,
    required this.question_content,
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
        'http://10.24.110.65:8080/random-text-question?questiontype_id=$questiontypeId'),
  );

  if (response.statusCode == 200) {
    return Question.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load question');
  }
}

Future<String> submitAnswer(String questionId, String selectedAnswer) async {
  final response = await http.post(
    Uri.parse('http://10.24.110.65:8080/submit-answer'),
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

// 文字問題出題画面
class LetterEducationScreen extends StatefulWidget {
  const LetterEducationScreen({super.key});

  @override
  _LetterEducationScreenState createState() => _LetterEducationScreenState();
}

class _LetterEducationScreenState extends State<LetterEducationScreen> {
  late Future<Question?> questionFuture;

  @override
  void initState() {
    super.initState();
    questionFuture = fetchQuestion("KMS003"); // questiontypeIdを指定
  }

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
                        builder: (_) => const EducationModeScreen()));
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
      String selectedAnswer, Question question, BuildContext context) async {
    final result = await submitAnswer(question.question_id, selectedAnswer);
    if (result == "correct") {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const EducationCorrectScreen()));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const EducationIncorrectScreen()));
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
          'もじもんだい',
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
                          child: Text(
                            question.question_theme, // question_theme（問題内容)を表示
                            style: const TextStyle(fontSize: 40),
                          ),
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
                                  final selectedAnswer =
                                      question.options.keys.toList()[i];
                                  _handleAnswerSubmission(selectedAnswer,
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
                                  final selectedAnswer =
                                      question.options.keys.toList()[i + 1];
                                  _handleAnswerSubmission(selectedAnswer,
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
