import 'package:adventer_app/EducationModeScreen/Color/ColorEducationScreen.dart';
import '../EducationModeScreen.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:adventer_app/MenuScreen/HomeScreen.dart';
import '../EducationCorrectScreen.dart'; // 正解画面
import '../EducationIncorrectScreen.dart'; // 不正解画面
import '../EdcationResultScreen.dart'; // 結果画面

class Question {
  final String question_content; // 問題の内容（例：ひらがな）
  final String correct_answer;
  final List<String> options; // 選択肢

  Question({
    required this.question_content,
    required this.correct_answer,
    required this.options,
  });

  factory Question.generateHiraganaQuestion() {
    final random = Random();
    final hiraganaList = [
      'あ', 'い', 'う', 'え', 'お',
      'か', 'き', 'く', 'け', 'こ',
      'さ', 'し', 'す', 'せ', 'そ',
      'た', 'ち', 'つ', 'て', 'と',
      'な', 'に', 'ぬ', 'ね', 'の',
      'は', 'ひ', 'ふ', 'へ', 'ほ',
      'ま', 'み', 'む', 'め', 'も',
      'や', 'ゆ', 'よ',
      'ら', 'り', 'る', 'れ', 'ろ',
      'わ', 'を', 'ん'
    ];

    // 問題と正解を生成
    final questionAnswer = hiraganaList[random.nextInt(hiraganaList.length)];
    final incorrectAnswers = <String>{};

    while (incorrectAnswers.length < 3) {
      final choice = hiraganaList[random.nextInt(hiraganaList.length)];
      if (choice != questionAnswer) {
        incorrectAnswers.add(choice);
      }
    }

    final options = [questionAnswer, ...incorrectAnswers.toList()];
    options.shuffle();

    return Question(
      question_content: 'このひらがなは何？',
      correct_answer: questionAnswer,
      options: options,
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

class LetterEducationScreen extends StatefulWidget {
  final int questionCount;
  final int correctCount;

  const LetterEducationScreen({required this.questionCount, required this.correctCount});

  @override
  _LetterEducationScreenState createState() => _LetterEducationScreenState();
}

class _LetterEducationScreenState extends State<LetterEducationScreen> {
  late int questionCount;
  late int correctCount;
  late Question currentQuestion;

  @override
  void initState() {
    super.initState();
    questionCount = widget.questionCount;
    correctCount = widget.correctCount;
    currentQuestion = Question.generateHiraganaQuestion();
  }

  void _handleAnswerSubmission(String selectedAnswer) {
    final correctAnswer = currentQuestion.correct_answer;

  debugPrint('問題数を増やす前: $questionCount');
    setState(() {
      questionCount++;
      if (selectedAnswer == correctAnswer) {
        correctCount++;
      }
    });
    debugPrint('問題数を増やした後: $questionCount');
    debugPrint('正解数: $correctCount');
    
    

        if (questionCount >= 10) {
          //１０問目を解いた場合
          if (selectedAnswer == correctAnswer) {
            //正解の場合は正解画面に遷移
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                  EducationCorrectScreen(
                  correctAnswer: correctAnswer,
                  questionCount: questionCount,
                  correctCount: correctCount,
                  nextScreenFlag: 'result')),
          ).then((_){
            //正解画面が閉じられた後に結果画面へ遷移
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
                correctAnswer: correctAnswer,
                questionCount: questionCount,
                correctCount: correctCount,
                nextScreenFlag: 'result',
              ),
            ),
          );
        }
      } else {
        //10問未満の場合
        if(selectedAnswer == correctAnswer){
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EducationCorrectScreen(
              correctAnswer: correctAnswer,
              questionCount: questionCount,
              correctCount: correctCount,
              nextScreenFlag: 'letter')),
          );
        }else{
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => EducationIncorrectScreen(
                  correctAnswer: correctAnswer,
                  questionCount: questionCount,
                  correctCount: correctCount,
                  nextScreenFlag: 'letter')), // 'shape' フラグを渡す
        );
        }
        
        

    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.shade200,
        elevation: 0,
        title: const Text(
          'ひらがなもんだい',
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
          Positioned.fill(
            child: CustomPaint(
              painter: SchoolBackgroundPainter(),
            ),
          ),

          Positioned(
            bottom: 30,
            left: 10,
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('ほんとうにやめる？'),
                    content: const Text('もんだいをおわってもいいですか？'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('キャンセル'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(initialIndex: 1),
                          ),
                        ),
                        child: const Text('やめる'),
                      ),
                    ],
                  ),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              ),
              child: const Text(
                'やめる',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Comic Sans MS',
                ),
              ),
            ),
          ),

          //問題テキスト
          Positioned(
            top: screenSize.height * 0.10,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  currentQuestion.question_content,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Comic Sans MS',
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          Positioned(
            top: screenSize.height * 0.25,
            left: 0,
            right: 0,
            child: Center(
            child: Text(
              currentQuestion.correct_answer,
              style: const TextStyle(
                fontSize: 80, // 大きく表示
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Comic Sans MS',
              ),
            ),
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
                    text: currentQuestion.options[i], // 選択肢のテキスト
                    buttonColor: const Color.fromARGB(255, 250, 240, 230),
                    textColor: Colors.black,
                    width: screenSize.width * 0.4,
                    height: 70,
                    onPressed: () {
                         // currentQuestion.options.keys.toList()[i];
                      _handleAnswerSubmission(currentQuestion.options[i]);
                    },
                  ),
                   if (i + 1 < currentQuestion.options.length)
                        RectangularButton(
                          text: currentQuestion.options[i + 1],
                          buttonColor: const Color.fromARGB(255, 250, 240, 230),
                          textColor: Colors.black,
                          width: screenSize.width * 0.4,
                          height: 70,
                          onPressed: () {
                            final selectedAnswerId =
                                currentQuestion.options[i + 1];
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