import 'package:flutter/material.dart';
import 'dart:convert'; // JSONデータを扱うため
import 'package:http/http.dart' as http;
import 'EducationModeScreen.dart';
import 'CalcEducationScreen.dart';
import '../MeneScreen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'ShapePainter.dart'; // ShapePainter.dartをインポート
import 'dart:math';  // cos, sinを使うためにインポート



class Question {
  final String question_id;
  final String questiontype_id;
  final String question_theme;
  final String question_answer;
  final String question_content;
  final List<String> options;

  Question({
    required this.question_id,
    required this.questiontype_id,
    required this.question_theme,
    required this.question_answer,
    required this.question_content,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question_id: json['question_id'],
      questiontype_id: json['questiontype_id'],
      question_theme: json['question_theme'],
      question_answer: json['question_answer'],
      question_content: json['question_content'],
      options: json['options'] != null && json['options'].isNotEmpty
          ? List<String>.from(json['options'])
          : ['No options available'],
    );
  }
}

Future<Question?> fetchQuestion(String questiontype_id) async {
  final response = await http.get(
    Uri.parse(
        'http://10.24.108.170:8080/random-text-question?questiontype_id=$questiontype_id'),
  );

  if (response.statusCode == 200) {
    return Question.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load question');
  }
}


//形問題出題画面
class ShapeEducationScreen extends StatefulWidget {
  const ShapeEducationScreen({super.key});

  

  @override
  _ShapeEducationScreenState createState() =>
      _ShapeEducationScreenState();
}

class _ShapeEducationScreenState extends State<ShapeEducationScreen> {
  late Future<Question?> questionFuture;

  String? selectedAnswer;
  String correctShape = 'しかく'; // 正解の形を格納

  final List<String> shapes = ['ほし', 'しかく', 'まる', 'さんかく']; // 形のリスト

  @override
  void initState() {
    super.initState();
    questionFuture = fetchQuestion("KMS001");
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
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // ダイアログを閉じて、問題一覧画面に戻る
                Navigator.push(context, MaterialPageRoute(builder: (_) => const EducationModeScreen()));
              },
              child: const Text('やめる'),
            ),
          ],
        );
      },
    );
  }

  void checkAnswer(Question question) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(selectedAnswer == question.question_answer
              ? 'Correct!'
              : 'Incorrect!'),
          content: Text(
              'Your answer is ${selectedAnswer == question.question_answer ? 'correct' : 'incorrect'}!'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


// 形をランダムに選ぶ
  String getRandomShape() {
    final random = Random();
    return shapes[random.nextInt(shapes.length)];
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
          'かたちもんだい',
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
      body: Stack(
        children: [
          //上部のソフトな装飾
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
          //下部のソフトな装飾
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
          // 問題テキスト

          Positioned(
            top: screenSize.height * 0.15,
            left: 0,
            right: 0,
            child: Column(
              children: [
                /*const Text(
                  'このもんだいをといてみよう！',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comic Sans MS',
                  ),
                ),*/
                const SizedBox(height: 60),
                FutureBuilder<Question?>(
                  future: questionFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final question = snapshot.data!;

                      correctShape = getRandomShape(); // ランダムに図形を設定

                      return Column(
                        children: [
                          Text(
                            question.question_content,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Comic Sans MS',
                            ),
                          ),

                          /*const SizedBox(height: 20),
                          Text(
                            question.question_theme,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Comic Sans MS',
                            ),
                          ),*/

                          // ShapePainterを動的に変更
                          //図形を表示
                          SizedBox(
                            
                            width: screenSize.width * 0.6,
                            height: screenSize.height * 0.3,
                            child: CustomPaint(
                              painter: ShapePainter(question.question_theme), // question_themeに基づいて図形を描画
                            ),
                          ),

                        ],
                      );
                    } else {
                      return const Text('No data found.');
                    }
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: screenSize.height * 0.15,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RectangularButton(
                      text: 'A.$correctShape',
                      buttonColor: const Color.fromARGB(255, 250, 240, 230),
                      textColor: Colors.black,
                      width: screenSize.width * 0.4,
                      height: 70,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const ShapeEducationScreen()));
                        //checkAnswer(correctShape); // ユーザーが選んだものと正解を比較
                      },
                    ),
                    RectangularButton(
                      text: 'B. $correctShape',
                      buttonColor: const Color.fromARGB(255, 250, 240, 230),
                      textColor: Colors.black,
                      width: screenSize.width * 0.4,
                      height: 70,
                      onPressed: () {
                         Navigator.push(context, MaterialPageRoute(builder: (_) => const ShapeEducationScreen()));
                         //checkAnswer(correctShape); // ユーザーが選んだものと正解を比較
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RectangularButton(
                      text: 'C. $correctShape',
                      buttonColor: const Color.fromARGB(255, 250, 240, 230),
                      textColor: Colors.black,
                      width: screenSize.width * 0.4,
                      height: 70,
                      onPressed: () {
                         Navigator.push(context, MaterialPageRoute(builder: (_) => const ShapeEducationScreen()));
                         //checkAnswer(correctShape); // ユーザーが選んだものと正解を比較
                      },
                    ),
                    RectangularButton(
                      text: 'D. $correctShape',
                      buttonColor: const Color.fromARGB(255, 250, 240, 230),
                      textColor: Colors.black,
                      width: screenSize.width * 0.4,
                      height: 70,
                      onPressed: () {
                         Navigator.push(context, MaterialPageRoute(builder: (_) => const ShapeEducationScreen()));
                         //checkAnswer(correctShape); // ユーザーが選んだものと正解を比較
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

