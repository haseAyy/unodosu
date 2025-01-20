import 'package:flutter/material.dart';
import 'package:adventer_app/HelpModeScreen/Cleaning/HelpCleaningListScreen.dart';
import '../HelpCleaningCorrectScreen.dart'; // 正解画面
import '../HelpCleaningIncorrectScreen.dart'; // 不正解画面
import '../HelpCleaningResultScreen.dart'; // 結果画面
import 'dart:convert'; // JSONデータを扱うため
import 'package:http/http.dart' as http;
import 'dart:developer';

// questionのデータモデル
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
      options: Map<String, String>.from(json['options']),
    );
  }
}

// APIリクエストを送信して、問題を取得するメソッド
Future<Question?> fetchQuestion(String questionTheme) async {
  final response = await http.get(
    Uri.parse(
        'http://10.24.110.65:8080/random-text-questionhelp?question_theme=$questionTheme'),
  );

//確認
  log('Response status: ${response.statusCode}');
  log('なかみ: ${response.body}');

  if (response.statusCode == 200) {
    final question = Question.fromJson(jsonDecode(response.body));
    // return questionQuestion.fromJson(jsonDecode(response.body))       // ここで選択肢の数と内容をログに出力
    log('選択肢数: ${question.options.length}');
    log('選択肢内容: ${question.options}');

    return question;
  } else {
    //throw Exception('Failed to load question');
  }
}

Future<String> submitAnswer(
    String questionId, String selectedAnswerId, selectedAnswerContent) async {
  final response = await http.post(
    Uri.parse('http://10.24.110.65:8080/submit-answer'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'questionId': questionId,
      'answer': selectedAnswerId,
      'answerContent': selectedAnswerContent,
    }),
  );

  log('Response body: ${response.body}'); // レスポンスボディを確認

  if (response.statusCode == 200) {
    // レスポンスが単なる文字列であれば、そのまま扱う
    // ここで選択肢の数と内容をログに出力
    if (response.body == 'incorrect') {
      return 'incorrect'; // 不正解
    } else if (response.body == 'correct') {
      return 'correct'; // 正解
    } else {
      log('Unexpected response body: ${response.body}');
      return 'Unexpected response';
    }
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

// ベッド問題出題画面
class HelpBedScreen extends StatefulWidget {
  final int questionCount; //問題カウント
  final int correctCount; //正解数カウント

  const HelpBedScreen(
      {required this.questionCount, required this.correctCount});

  @override
  _HelpBedScreenState createState() =>
      _HelpBedScreenState(questionCount, correctCount);
}

class _HelpBedScreenState extends State<HelpBedScreen> {
  late Future<Question?> questionFuture;
  late int questionCount; //このクラス内で管理する変数
  late int correctCount; //正解数を追跡する変数

  //コンストラクタで初期値を設定
  _HelpBedScreenState(this.questionCount, this.correctCount);

  @override
  void initState() {
    super.initState();
    questionFuture = fetchQuestion("ベッド"); // questiontypeTemeを指定
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const HelpCleaningListScreen()));
              },
              child: const Text('やめる'),
            ),
          ],
        );
      },
    );
  }

  //ユーザが答えを選んだ時に呼び出すメソッド
  void _handleAnswerSubmission(String selectedAnswerId, selectedAnswerContent,
      Question question, BuildContext context) async {
    try {
      final result = await submitAnswer(
          question.questionId, selectedAnswerId, selectedAnswerContent); // 修正

      setState(() {
        questionCount++; // 問題数をカウント
        if (result == "correct") {
          correctCount++; // 正解数をカウント
        }
      });

      if (result == "correct") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HelpCleaningCorrectScreen(
                    message: 'ベッド',
                    questionCount: questionCount,
                    correctCount: correctCount,
                    correctAnswer: question.questionAnswer,
                    selectedAnswerContent: selectedAnswerContent,
                    questionId: question.questionId, // questionIdを渡す
                  )),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HelpCleaningIncorrectScreen(
                    message: 'ベッド',
                    questionCount: questionCount,
                    correctCount: correctCount,
                    correctAnswer: question.questionAnswer,
                    selectedAnswerContent: selectedAnswerContent,
                    questionId: question.questionId, // questionIdを渡す
                  )),
        );
      }
      // 次の問題を取得する処理を呼び出す
      if (questionCount < 5) {
        setState(() {
          questionFuture = fetchQuestion("KMS003"); // 次の問題を取得
        });
      }
    } catch (e) {
      log("エラー: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('エラーが発生しました')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 戻るボタンを非表示にする
        backgroundColor: const Color.fromARGB(255, 20, 154, 127),
        elevation: 0,
        title: const Text(
          'ベッドもんだい',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Comic Sans MS',
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white, // 背景を白に統一
      body: FutureBuilder<Question?>(
          future: questionFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data != null) {
              final question = snapshot.data!;
              return Stack(
                children: [
                  // 背景色（温かみのある色調）
                  Container(color: Colors.teal[50]),
                  // 上部デコレーション（円形の装飾）
                  Positioned(
                    top: -screenHeight * 0.05, // 画面サイズに基づく位置調整
                    left: -screenWidth * 0.1,
                    child: Container(
                      width: screenWidth * 0.4, // 画面サイズに基づくサイズ調整
                      height: screenWidth * 0.4,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent[100],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.2, // 画面サイズに基づく位置調整
                    right: -screenWidth * 0.1,
                    child: Container(
                      width: screenWidth * 0.3,
                      height: screenWidth * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.lightGreen[200],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  // 問題中断ボタン（左下）
                  Positioned(
                    bottom: screenSize.height * 0.05, // 位置調整
                    left: 10,
                    child: TextButton(
                      onPressed: () {
                        _showQuitDialog(context); // ダイアログを表示
                      },
                      style: TextButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 20, 154, 127),
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
                  // 問題テキスト
                  Positioned(
                    top: screenSize.height * 0.1,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Text(
                          question.questionContent,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Comic Sans MS',
                          ),
                        ),
                        const SizedBox(height: 50),
                        // 問題の丸
                        Container(
                          width: screenSize.width * 0.9, // 比率調整
                          height: screenSize.width * 0.57, // 比率調整
                          decoration: const BoxDecoration(
                              //color: Color.fromARGB(255, 154, 208, 255),
                              //shape: BoxShape.circle,
                              ),
                          child: ClipRect(
                            //alignment: const Alignment(0.0, 0.0), // 画像の中央配置
                            child: Container(
                              //width:screenSize.width * 2.0, // 画像の幅（画面サイズに基づく比率）
                              //height: screenSize.width * 0.5, // 画像の高さ（同上）
                              child: Image.network(
                                question.questionImage, //画像表示
                                fit: BoxFit.cover, // 画像のフィット方法を指定
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 選択肢ボタンエリア
                  Positioned(
                    bottom: screenSize.height * 0.14, // 位置調整
                    left: 0,
                    right: 0,
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween, // 真ん中の隙間を狭める
                      children: [
                        SizedBox(height: 20), // 上の選択肢との間隔
                        for (int i = 0; i < question.options.length; i += 2)
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisAlignment:
                                MainAxisAlignment.center, // ここは中央に配置
                            children: [
                              if (i < question.options.length)
                                RectangularButton(
                                  text:
                                      question.options.keys.toList()[i], //選択肢表示
                                  buttonColor:
                                      const Color.fromARGB(255, 250, 240, 230),
                                  textColor: Colors.black,
                                  width: screenSize.width * 0.4, // 横幅調整
                                  height: 70, // 高さ調整
                                  onPressed: () {
                                    final selectedAnswerId = question
                                        .options.values
                                        .toList()[i]; //question.idを送信
                                    final selectedAnswerContent = question
                                        .options.keys
                                        .toList()[i]; //question.idを送信
                                    _handleAnswerSubmission(
                                        selectedAnswerId,
                                        selectedAnswerContent,
                                        question,
                                        context); //選択したIdを送信して回答判定メソッドへ
                                  },
                                ),
                              SizedBox(width: 15), // 少し隙間を開ける
                              SizedBox(height: 80),
                              //SizedBox(width: 0.1), // 上の選択肢との間隔
                              if (i + 1 < question.options.length)
                                //SizedBox(height: 20),
                                RectangularButton(
                                  text: question.options.keys.toList()[i + 1],
                                  buttonColor:
                                      const Color.fromARGB(255, 250, 240, 230),
                                  textColor: Colors.black,
                                  width: screenSize.width * 0.4, // 横幅調整
                                  height: 70, // 高さ調整

                                  onPressed: () {
                                    final selectedAnswerId =
                                        question.options.values.toList()[i + 1];
                                    final selectedAnswerContent = question
                                        .options.keys
                                        .toList()[i + 1]; //question.idを送信
                                    _handleAnswerSubmission(
                                        selectedAnswerId,
                                        selectedAnswerContent,
                                        question,
                                        context); //回答判定メソッドへ
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
              return const Center(child: Text(' No data available'));
            }
          }),
    );
  }
}
