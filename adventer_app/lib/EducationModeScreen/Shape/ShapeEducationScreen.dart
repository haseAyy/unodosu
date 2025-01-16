import 'package:flutter/material.dart';
import 'dart:convert'; // JSONデータを扱うため
import 'package:http/http.dart' as http;
import '../EducationCorrectScreen.dart'; //正解画面
import '../EducationIncorrectScreen.dart'; //不正解画面
import '../EdcationResultScreen.dart';//結果画面
import '../EducationModeScreen.dart';
import 'ShapePainter.dart'; // ShapePainter.dartをインポート
import 'dart:math';  // cos, sinを使うためにインポート


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
Future<Question?> fetchQuestion(String questionTypeId) async {
  final response = await http.get(
    Uri.parse(
        'http://10.24.108.170:8080/random-text-question?questiontype_id=$questionTypeId'),
  );

  if (response.statusCode == 200) {
    return Question.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('問題の取得に失敗しました');
  }
}

Future<String> submitAnswer(String questionId, String selectedAnswer) async {
  final response = await http.post(
    Uri.parse('http://10.24.108.170:8080/submit-answer'),
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

// 形問題出題画面
class ShapeEducationScreen extends StatefulWidget {
  final int questionCount;
  final int correctCount;
  const ShapeEducationScreen({required this.questionCount,required this.correctCount});


  @override
  _ShapeEducationScreenState createState() => _ShapeEducationScreenState(questionCount,correctCount);

}

class _ShapeEducationScreenState extends State<ShapeEducationScreen> {
  late Future<Question?> questionFuture;
  late int questionCount; // このクラス内で管理する変数
  late int correctCount; // 正解数を追跡する変数 
  late Question currentQuestion;


  // コンストラクタで初期値を設定
  _ShapeEducationScreenState(this.questionCount,this.correctCount);

  //gpt
  //List<String> solvedQuestions = []; // 解いた問題を保存するリスト
  

  @override
  void initState() {
    super.initState();
    questionFuture = fetchQuestion("KMS001"); // questiontypeIdを指定
  }

  // やめるダイアログを表示
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
      // 10問目を解いた場合
      if (result == "correct") {
        // 正解の場合は正解画面に遷移
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  EducationCorrectScreen(
                  correctAnswer: " \n「${question.question_answer}」",
                  questionImage: question.question_image,
                  questionCount: questionCount,
                  correctCount: correctCount,
                  nextScreenFlag: 'result')),
        ).then((_){
          // 正解画面が閉じられた後に結果画面へ遷移
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              EdcationResultScreen(correctCount: correctCount),
        ),
      );
    });
      } else {
        // 間違えた場合は不正解画面を経由して結果画面へ遷移
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => EducationIncorrectScreen(
                  correctAnswer: "「${question.question_answer}」",
                  questionCount: questionCount,
                  correctCount: correctCount,
                  nextScreenFlag: 'result')), // 'result' フラグを渡す
        );
      }
    } else {
      // 10問未満の場合
      if (result == "correct") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => EducationCorrectScreen(
                  correctAnswer: " \n「${question.question_answer}」",
                  questionImage: question.question_image,
                  questionCount: questionCount,
                  correctCount: correctCount,
                  nextScreenFlag: 'shape')),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => EducationIncorrectScreen(
                  correctAnswer: "このかたちは \n「${question.question_answer}」だよ",
                  questionImage: question.question_image,
                  questionCount: questionCount,
                  correctCount: correctCount,
                  nextScreenFlag: 'shape')), // 'shape' フラグを渡す
        );
      }
      // 次の問題を取得する処理を呼び出す
      if (questionCount < 10) {
        setState(() {
          questionFuture = fetchQuestion("KMS001"); // 次の問題を取得
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
        backgroundColor: Colors.blue.shade100,
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

                //背景(ノート風の罫線デザイン)
                Positioned.fill(
            child: CustomPaint(
              painter: SchoolBackgroundPainter(),
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
                      backgroundColor: Colors.blue.shade100,
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
                  top: screenSize.height * 0.10,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      Text(
                        question.question_content,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Comic Sans MS',
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width * 0.9,
                        height: screenSize.height * 0.20,
                        child: Center(
                          child: Image.network(
                            question.question_image),
                        )
                      ),
                    ],
                  ),
                ),
                // 選択肢ボタンエリア
                Positioned(
                  bottom: screenSize.height * 0.18,
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
                              text: question.options.keys.toList()[i], // 選択肢のテキスト
                              buttonColor:
                                  const Color.fromARGB(255, 250, 240, 230),
                              textColor: Colors.black,
                              width: screenSize.width * 0.4,
                              height: 70,
                              onPressed: () {
                                final selectedAnswerId =
                                    question.options.values.toList()[i];
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
            return const Center(child: Text('データがありません。'));
          }
        },
      ),
    );
  }
}

class SchoolBackgroundPainter extends CustomPainter {
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
}

