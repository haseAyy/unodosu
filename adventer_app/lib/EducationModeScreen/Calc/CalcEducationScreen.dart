import 'package:flutter/material.dart';
import 'dart:convert'; // JSONデータを扱うため
import 'package:http/http.dart' as http;
import '../EducationCorrectScreen.dart'; //正解画面
import '../EducationIncorrectScreen.dart'; //不正解画面
import '../EdcationResultScreen.dart';//結果画面
import '../EducationModeScreen.dart';
import 'dart:math'; // ランダム生成のため

// questionのデータモデル
class Question {
  final String questionId;
  final String questionTypeId;
  final String questionTheme;
  final String questionAnswer;
  final String questionContent;
  final Map<String, String> options;

  Question({
    required this.questionId,
    required this.questionTypeId,
    required this.questionTheme,
    required this.questionAnswer,
    required this.questionContent,
    required this.options,
  });

  // ランダムに計算問題を生成
  factory Question.generateRandomQuestion() {
    final random = Random();
    late int num1 = random.nextInt(10);
    late int num2 = random.nextInt(10);
    final isAddition = random.nextBool(); // 足し算か引き算かを決定

    String questionContent;
    String questionAnswer;
    Map<String, String> options = {};

    if (isAddition) {
      questionContent = '$num1 + $num2';
      questionAnswer = (num1 + num2).toString();
    } else {
      // 引き算の場合、num1がnum2より大きくなるように調整
      if (num1 < num2) {
        final temp = num1;
        num1 = num2;
        num2 = temp;
      }
      questionContent = '$num1 ー $num2';
      questionAnswer = (num1 - num2).toString();
    }

    // Setを使って一意な不正解を生成（正解を除いた3つ）
  Set<String> incorrectAnswers = {};
  while (incorrectAnswers.length < 3) {
    final randomIncorrect = random.nextInt(16).toString();  // ランダムな誤答
    if (randomIncorrect != questionAnswer) {
      incorrectAnswers.add(randomIncorrect);
    }
  }
  // 不正解の選択肢と正解をマップに追加
  options[questionAnswer] = 'correct';
  incorrectAnswers.forEach((answer) {
    options[answer] = 'incorrect';
  });



  // 選択肢の順番をランダムにするため、選択肢のリストをシャッフル
  List<String> optionKeys = options.keys.toList()..shuffle();

    

    return Question(
      questionId: DateTime.now().millisecondsSinceEpoch.toString(),
      questionTypeId: 'basic_math',
      questionTheme: 'addition_subtraction',
      questionAnswer: questionAnswer,
      questionContent: questionContent,
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
class CalcEducationScreen extends StatefulWidget {
  final int questionCount;
  final int correctCount;
  const CalcEducationScreen({required this.questionCount,required this.correctCount});

  @override
  _CalcEducationScreenState createState() => _CalcEducationScreenState();
}

class _CalcEducationScreenState extends State<CalcEducationScreen> {
  late int questionCount;
  late int correctCount;
  late Question currentQuestion; // 現在の問題

  // コンストラクタで初期値を設定
  _CalcEducationScreenState();

  @override
  void initState() {
    super.initState();
    questionCount = widget.questionCount;
    correctCount = widget.correctCount;
    currentQuestion = Question.generateRandomQuestion(); // ランダムな問題を生成

    debugPrint('生成された問題: ${currentQuestion.questionContent}, 正解: ${currentQuestion.questionAnswer}');
  
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
  void _handleAnswerSubmission(String selectedAnswerId) {
  String? result = currentQuestion.options[selectedAnswerId];

  // 現在の正解を一時保存
  final correctAnswer = currentQuestion.questionAnswer;
  debugPrint('画面遷移前の正解: $correctAnswer');

  setState(() {
    questionCount++;
    if (result == "correct") {
      correctCount++;

      if (questionCount >= 10) {
        // 結果画面へ遷移
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EdcationResultScreen(
              correctCount: correctCount
            ),
          ),
        );
      } else {
        // 正解画面に遷移
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EducationCorrectScreen(
              correctAnswer: '${currentQuestion.questionContent}＝${correctAnswer}',
              questionCount: questionCount,
              correctCount: correctCount,
              nextScreenFlag: 'calc',
            ),
          ),
        );
      }
    } else {
      if (questionCount >= 10) {
        // 10問目を間違えた場合、不正解画面を経由して結果画面へ遷移
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EducationIncorrectScreen(
              correctAnswer: '${currentQuestion.questionContent}＝${correctAnswer}',
              questionCount: questionCount,
              correctCount: correctCount,
              nextScreenFlag: 'result', // 結果画面へのフラグを設定
            ),
          ),
        );

        debugPrint('correctAnswer: $correctAnswer');
        debugPrint('currentQuestion.questionContent: ${currentQuestion.questionContent}');
        
      } else {
        // 不正解画面に遷移
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EducationIncorrectScreen(
              correctAnswer: '${currentQuestion.questionContent}＝${correctAnswer}',
              questionCount: questionCount,
              correctCount: correctCount,
              nextScreenFlag: 'calc',
            ),
          ),
        );
      }
    }
  });

  debugPrint('correctAnswer: $correctAnswer');
  debugPrint('currentQuestion.questionContent: ${currentQuestion.questionContent}');

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
        backgroundColor: const Color.fromARGB(141, 57, 154, 0),
        elevation: 0,
        title: const Text(
          'けいさんもんだい',
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
                const SizedBox(height: 60),
                Text(
                  currentQuestion.questionContent,
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
