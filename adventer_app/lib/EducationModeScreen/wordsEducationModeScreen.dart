import 'package:flutter/material.dart';
import 'dart:convert'; // JSONデータを扱うため
import 'package:http/http.dart' as http;
//import 'EducationCorrectScreen.dart';　//正解画面
//import 'EducationIncorrectScreen.dart';//不正解画面

//unodosuEntityのデータモデル
class question {
  final String question_id;
  final String questiontype_id;
  final String question_theme;
  final String question_answer;
  final String question_content;
  final List<String> options;

  question({
    required this.question_id,
    required this.questiontype_id,
    required this.question_theme,
    required this.question_answer,
    required this.question_content,
    required this.options,
  });

  // JSONをUnodosuEntityオブジェクトに変換
  factory question.fromJson(Map<String, dynamic> json) {
    return question(
      question_id: json['question_id'],
      questiontype_id: json['questiontype_id'],
      question_theme: json['question_theme'],
      question_answer: json['question_answer'],
      question_content: json['question_content'],
      options: json['options'] != null && json['options'].isNotEmpty
          ? List<String>.from(json['options'])
          : ['No options available'], // デフォルト値を設定
    );
  }
}

// APIリクエストを送信して、問題を取得するメソッド
Future<question?> fetchQuestion(String questiontype_id) async {
  final response = await http.get(
    Uri.parse(
        'http://10.24.110.65:8080/random-text-question?questiontype_id=$questiontype_id'),
  );

  if (response.statusCode == 200) {
    // JSONレスポンスをパースしてUnodosuEntityに変換
    return question.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load question');
  }
}

class wordsEducationModeScreen extends StatefulWidget {
  const wordsEducationModeScreen({super.key});

  @override
  _WordsEducationModeScreenState createState() =>
      _WordsEducationModeScreenState();
}

class _WordsEducationModeScreenState extends State<wordsEducationModeScreen> {
  late Future<question?> questionFuture; // 問題を保持する変数
  String? selectedAnswer; // ユーザーが選んだ選択肢

  @override
  void initState() {
    super.initState();
    //最初に問題を取得する
    questionFuture = fetchQuestion("KMS003"); // 適切なquestionTypeidを指定
  }

  // ユーザーが選んだ選択肢に基づいて正解か不正解かを判定する
  void checkAnswer(question question) {
    if (selectedAnswer == question.question_answer) {
      // 正解の場合
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Correct!'),
            content: Text('Your answer is correct!'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      // 不正解の場合
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Incorrect!'),
            content: Text('Your answer is incorrect!'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Words Education Mode')),
      body: FutureBuilder<question?>(
        future: questionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // 問題が取得できた場合
            final question = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 問題内容を表示
                  Text(
                    '${question.question_content}\n'
                    '\n${question.question_theme}',
                    style: TextStyle(fontSize: 40),
                  ),
                  SizedBox(height: 20),
                  // 選択肢のボタンを表示
                  ...question.options.map((option) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedAnswer = option; // 選択した選択肢を記録
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedAnswer == option
                              ? Colors.blue // 選択中の色
                              : Colors.grey, // 通常の色
                        ),
                        child: Text(
                          option,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }).toList(),
                  SizedBox(height: 20),
                  // 「選択肢を確定」ボタン（まだ正解・不正解の処理はしない）
                  ElevatedButton(
                    onPressed: selectedAnswer == null
                        ? null
                        : () {
                            // ここで正解・不正解の処理を追加可能
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('選択肢 "$selectedAnswer" を選びました'),
                              ),
                            );
                          },
                    child: Text('選択肢を確定'),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No data found.'));
          }
        },
      ),
    );
  }
}
