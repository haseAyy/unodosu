import 'package:flutter/material.dart';
import '../MeneScreen/HomeScreen.dart';
import 'dart:ui';

// ユーザミッション設定画面(親子モード)
class MissionSettingsScreen extends StatefulWidget  {
  const MissionSettingsScreen({super.key});
@override
  State<MissionSettingsScreen> createState() => _MissionSettingsScreenState();
}

class _MissionSettingsScreenState extends State<MissionSettingsScreen> {
  final TextEditingController _missionNameController = TextEditingController();
  final TextEditingController _missionKeywordController = TextEditingController();

  String? missionNameError; // ミッション名のエラーメッセージ
  String? missionKeywordError; // キーワードのエラーメッセージ

  String? missionName;
  String? missionKeyword;
  String? missionId;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // 背景
          Positioned.fill(
            child: Container(
              color: const Color.fromARGB(174, 250, 231, 213),
            ),
          ),
          // 左下に戻るボタン
          Positioned(
            bottom: 10,
            left: 10,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(initialIndex: 3),
                  ),
                );
              },
              backgroundColor: Colors.grey[100],
              child: const Icon(Icons.arrow_back),
            ),
          ),
          // ミッション設定ボタン
          Align(
            alignment: const Alignment(0.0, 0.5),
            child: CategoryButton(
              categoryName: '設定完了',
              backgroundColor: const Color.fromARGB(255, 255, 176, 169),
              onPressed: () {
                setState(() {
                  // 入力内容をチェック
                  missionNameError = _missionNameController.text.isEmpty ? '入力してください' : null;
                  missionKeywordError = _missionKeywordController.text.isEmpty ? '入力してください' : null;

                  if (missionNameError == null && missionKeywordError == null) {
                    // 入力が有効な場合、ローカルデータを更新
                    missionName = _missionNameController.text;
                    missionKeyword = _missionKeywordController.text;
                    missionId = null; // missionIdをnullに設定

                    // ここで適切な処理を実行（例：データの保存や画面遷移）
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(initialIndex: 3),
                      ),
                    );
                  }
                });
              },
            ),
          ),
          // ラベル
          Positioned(
            top: screenSize.height * 0.25,
            left: 0,
            right: 0,
            child: const Text(
              'ミッション内容',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          // テキストボックス(ミッション名用)
          Positioned(
            top: screenSize.height * 0.35,
            left: 20,
            right: 20,
            child: TextField(
              controller: _missionNameController,
              decoration: InputDecoration(
                labelText: 'ミッション内容を入力してください',
                errorText: missionNameError, // エラーメッセージを表示
                filled: true,
                fillColor: Colors.lightBlue[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // テキストボックス(キーワード用)
          Positioned(
            top: screenSize.height * 0.45,
            left: 20,
            right: 20,
            child: TextField(
              controller: _missionKeywordController,
              decoration: InputDecoration(
                labelText: 'ミッションのキーワードを入力してください',
                errorText: missionKeywordError, // エラーメッセージを表示
                filled: true,
                fillColor: Colors.lightBlue[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String categoryName;
  //final String description;
  final Color backgroundColor;
  //final IconData icon;
  final VoidCallback onPressed;

  const CategoryButton({
    super.key,
    required this.categoryName,
    //required this.description,
    required this.backgroundColor,
    //required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final buttonHeight = screenSize.height * 0.1; // ボタンの高さを調整
    final buttonWidth = screenSize.width * 0.8; // ボタンの幅を調整

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: buttonHeight,
        width: buttonWidth,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(4, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            // 縫い目を描画する CustomPaint
            CustomPaint(
              painter: StitchPainter(buttonWidth, buttonHeight),
              child: Container(),
            ),
            // ボタンのコンテンツ（テキストを中央に配置）
            Center(
              child: Text(
                categoryName,
                style: TextStyle(
                  fontSize: screenSize.width * 0.06, // テキストサイズ調整
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StitchPainter extends CustomPainter {
  final double buttonWidth;
  final double buttonHeight;

  StitchPainter(this.buttonWidth, this.buttonHeight);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint stitchPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0; // 縫い目の太さ

    const double dashWidth = 10.0;
    const double dashSpace = 6.0;

    // ボタンの内側に収まるように調整
    const double padding = 5.0; // 内側の余白を設定

    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(
          padding, padding, // 余白を考慮して内側に合わせる
          buttonWidth - padding * 2, // 内側に合わせて幅を調整
          buttonHeight - padding * 2, // 内側に合わせて高さを調整
        ),
        const Radius.circular(20), // 角丸の半径を調整
      ));

    // 破線を描画
    for (PathMetric pathMetric in path.computeMetrics()) {
      double distance = 0;
      while (distance < pathMetric.length) {
        final Path segment = pathMetric.extractPath(
          distance,
          distance + dashWidth,
        );
        canvas.drawPath(segment, stitchPaint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // 再描画は不要
  }
}