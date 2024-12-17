import 'package:flutter/material.dart';
import 'dart:convert'; // JSONデータを扱うため
import 'package:http/http.dart' as http;
//import 'EducationCorrectScreen.dart';
//import 'EducationIncorrectScreen.dart';

//unodosuEntityのデータモデル
class UnodosuEntity {
  final String question_id;
  final String questiontype_id;
  final String question_theme;
  final String question_answer;
  //final List<String> options;

  UnodosuEntity({
    required this.question_id,
    required this.questiontype_id,
    required this.question_theme,
    required this.question_answer,
    // required this.options,
  });

  // JSONをUnodosuEntityオブジェクトに変換
  factory UnodosuEntity.fromJson(Map<String, dynamic> json) {
    return UnodosuEntity(
      question_id: json['question_id'],
      questiontype_id: json['questiontype_id'],
      question_theme: json['question_theme'],
      question_answer: json['question_answer'],
      //options: List<String>.from(json['options']),
    );
  }
}

// APIリクエストを送信して、問題を取得するメソッド
Future<UnodosuEntity?> fetchQuestion(String questiontype_id) async {
  final response = await http.get(
    Uri.parse(
        'http://10.24.110.65:8080/random-text-question?questiontype_id=$questiontype_id'),
  );

  /*if (response.statusCode == 200) {
    // レスポンスをUTF-8としてデコード
    final decodedBody = utf8.decode(response.bodyBytes);
    print('Decoded API Response: $decodedBody');

    return UnodosuEntity.fromJson(jsonDecode(decodedBody));
  } else {
    throw Exception('Failed to load question');
  }*/

  if (response.statusCode == 200) {
    // JSONレスポンスをパースしてUnodosuEntityに変換
    return UnodosuEntity.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load question');
  }
}

class wordsEducationModeScreen extends StatefulWidget {
  const wordsEducationModeScreen({super.key});

  @override
  _wordsEducationModeScreenState createState() =>
      _wordsEducationModeScreenState();
}

class _wordsEducationModeScreenState extends State<wordsEducationModeScreen> {
  late Future<UnodosuEntity?> questionFuture; // 問題を保持する変数

  @override
  void initState() {
    super.initState();
    //最初に問題を取得する
    questionFuture = fetchQuestion("KMS003"); // 適切なquestionTypeidを指定
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Words Education Mode')),
      body: FutureBuilder<UnodosuEntity?>(
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
                    'Question: ${question.question_theme}',
                    style: TextStyle(fontSize: 40),
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
