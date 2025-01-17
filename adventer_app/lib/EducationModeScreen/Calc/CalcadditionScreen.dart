import 'CalcStartScreen.dart';
import 'package:flutter/material.dart';
import 'dart:convert'; // JSONデータを扱うため
import 'package:http/http.dart' as http;
import 'package:adventer_app/MenuScreen/HomeScreen.dart';
import '../EducationCorrectScreen.dart'; //正解画面
import '../EducationIncorrectScreen.dart'; //不正解画面
import '../EdcationResultScreen.dart';//結果画面
import '../EducationModeScreen.dart';
import 'dart:math'; // ランダム生成のため

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

  // ランダムに足し算問題を生成
  factory Question.generateRandomQuestion() {
    final random = Random();
    final int num1 = random.nextInt(10);
    final int num2 = random.nextInt(10);
    
    //足し算問題を生成
    final String questionContent = '$num1 + $num2';
    final String questionAnswer = (num1 + num2).toString();


    // Setを使って一意な不正解を生成（正解を除いた3つ）
  Set<String> incorrectAnswers = {};
  while (incorrectAnswers.length < 3) {
    final randomIncorrect = random.nextInt(16).toString();  // ランダムな誤答
    if (randomIncorrect != questionAnswer) {
      incorrectAnswers.add(randomIncorrect);
    }
  }
  // 不正解の選択肢と正解をマップに追加
  Map<String, String> options = {questionAnswer: 'correct'};
    incorrectAnswers.forEach((answer) {
      options[answer] = 'incorrect';
  });



  // 選択肢の順番をランダムにするため、選択肢のリストをシャッフル
  List<String> optionKeys = options.keys.toList()..shuffle();

    

    return Question(
      question_id: DateTime.now().millisecondsSinceEpoch.toString(),
      questiontype_id: 'basic_math',
      question_theme: 'addition',//足し算問題のテーマ
      question_answer: questionAnswer,
      question_content: questionContent,
      options: Map.fromIterable(optionKeys, key: (e) => e, value: (e) => options[e]!),
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

// 計算問題出題画面
class CalcadditionScreen extends StatefulWidget {
  final int questionCount;
  final int correctCount;
  const CalcadditionScreen({required this.questionCount,required this.correctCount});

  @override
  _CalcadditionScreenState createState() => _CalcadditionScreenState();
}

class _CalcadditionScreenState extends State<CalcadditionScreen> {
  late int questionCount;
  late int correctCount;
  late Question currentQuestion; // 現在の問題

  // コンストラクタで初期値を設定
  _CalcadditionScreenState();

  @override
  void initState() {
    super.initState();
    questionCount = widget.questionCount;
    correctCount = widget.correctCount;
    currentQuestion = Question.generateRandomQuestion(); // ランダムな問題を生成

    debugPrint('生成された問題: ${currentQuestion.question_content}, 正解: ${currentQuestion.question_answer}');
  
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
                        builder: (context) => const HomeScreen(initialIndex: 1)));
              },
              child: const Text('やめる'),
            ),
          ],
        );
      },
    );
  }

  // ユーザーが答えを選んだときに呼び出すメソッド
  void _handleAnswerSubmission(String selectedAnswerId) {
  String? result = currentQuestion.options[selectedAnswerId];

  // 現在の正解を一時保存
  final correctAnswer = currentQuestion.question_answer;
  debugPrint('画面遷移前の正解: $correctAnswer');

  setState(() {
    questionCount++;
    if (result == "correct") {
      correctCount++;
    }
    });
    debugPrint('問題数を増やした後: $questionCount');
    debugPrint('正解数: $correctCount');

    
      if (questionCount >= 10) {
        // 10問目を間違えた場合
        if(result == "correct"){
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EducationCorrectScreen(
              correctAnswer: '${currentQuestion.question_content}＝${correctAnswer}',
              questionCount: questionCount,
              correctCount: correctCount,
              nextScreenFlag: 'result'// 結果画面へのフラグを設定
            )),
        ).then((_){
           Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                 builder: (context) => 
                  EdcationResultScreen(correctCount: correctCount),
                ),
           );
        });
        }else{
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EducationIncorrectScreen(
              correctAnswer: '${currentQuestion.question_content}＝${correctAnswer}',
              questionCount: questionCount,
              correctCount: correctCount,
              nextScreenFlag: 'result', // 結果画面へのフラグを設定
            ),
          ),
        );
        }
      }else{
        if(result == "correct"){
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EducationCorrectScreen(
              correctAnswer: correctAnswer,
              questionCount: questionCount,
              correctCount: correctCount,
              nextScreenFlag: 'addition')),
          );

        
      } else {
        // 不正解画面に遷移
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EducationIncorrectScreen(
              correctAnswer: '${currentQuestion.question_content}＝${correctAnswer}',
              questionCount: questionCount,
              correctCount: correctCount,
              nextScreenFlag: 'addition')),
        );
      }
      }
  debugPrint('correctAnswer: $correctAnswer');
  debugPrint('currentQuestion.questionContent: ${currentQuestion.question_content}');
        

  debugPrint('correctAnswer: $correctAnswer');
  debugPrint('currentQuestion.questionContent: ${currentQuestion.question_content}');

/*
  // 次の問題を生成
  if (questionCount < 10) {
    //currentQuestion = Question.generateRandomQuestion();
    debugPrint('次の問題を生成: ${currentQuestion.questionContent}');
  }*/
}

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pink.shade200,
        elevation: 0,
        title: const Text(
          'たしざんもんだい',
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
                backgroundColor: Colors.pink.shade200,
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
                const SizedBox(height: 60),
                Text(
                  currentQuestion.question_content,
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Arial Black',
                  ),
                ),
                SizedBox(
                  width: screenSize.width * 0.6,
                  height: screenSize.height * 0.15,
                  child: CustomPaint(
                    //painter: ShapePainter(question.questionTheme),
                  ),
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
                for (int i = 0; i < currentQuestion.options.length; i += 2)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (i < currentQuestion.options.length)
                        SizedBox(height: 90),
                      RectangularButton(
                        text: currentQuestion.options.keys.toList()[i], // 選択肢のテキスト
                        buttonColor: const Color.fromARGB(255, 250, 240, 230),
                        textColor: Colors.black,
                        width: screenSize.width * 0.4,
                        height: 70,
                        onPressed: () {
                          final selectedAnswerId =
                              currentQuestion.options.keys.toList()[i];
                          _handleAnswerSubmission(selectedAnswerId);
                        },
                      ),
                      if (i + 1 < currentQuestion.options.length)
                        RectangularButton(
                          text: currentQuestion.options.keys.toList()[i + 1],
                          buttonColor: const Color.fromARGB(255, 250, 240, 230),
                          textColor: Colors.black,
                          width: screenSize.width * 0.4,
                          height: 70,
                          onPressed: () {
                            final selectedAnswerId =
                                currentQuestion.options.keys.toList()[i + 1];
                            _handleAnswerSubmission(selectedAnswerId);
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
