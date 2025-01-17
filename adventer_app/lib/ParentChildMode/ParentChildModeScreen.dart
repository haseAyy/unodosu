import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ImageUploadScreen.dart';
import 'MissionSettingsScreen.dart';

// missionのデータモデル
/*
class Mission {
  final String? missionId;
  final String? missionName;
  final String? missionKeyword;
  final Map<String, String> options;

  Mission({
    required this.missionId,
    required this.missionName,
    required this.missionKeyword,
    required this.options,
  });

  // JSONをMissionオブジェクトに変換
  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      missionId: json['mission_id'] ?? '',  // nullの場合は空文字に設定
      missionName: json['mission_name'] ?? 'デフォルトのミッション名',  // nullの場合のデフォルト値
      missionKeyword: json['mission_keyword'] ?? 'デフォルトのキーワード',  // nullの場合のデフォルト値
      options: json['options'] != null && json['options'].isNotEmpty
          ? Map<String, String>.from(json['options'])
          : {'No options available': ''}, // デフォルト値
    );
  }
}
*/

// 親子モードのミッション設定画面
class ParentChildModeScreen extends StatefulWidget {
  const ParentChildModeScreen({super.key});

  @override
  State<ParentChildModeScreen> createState() => _ParentChildModeScreenState();
}

class _ParentChildModeScreenState extends State<ParentChildModeScreen> {
  List<String> missionList = []; // 取得したミッション情報を格納するリスト
  String displayText = "";

  @override
  void initState() {
    super.initState();
    fetchMissionData(); // APIデータを取得
  }

  Future<void> fetchMissionData() async {
    final url = Uri.parse('http://10.24.109.199:8080/random');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        setState(() {
          List<String> missionList = List<String>.from(json.decode(utf8.decode(response.bodyBytes)));
          displayText = missionList[1];
        });
      } else {
        setState(() {
          missionList = ["ミッションが見つかりません"]; // データが見つからない場合
        });
      }
    } catch (e) {
      setState(() {
        print("エラーが発生しました: $e");
        missionList = ["エラーが発生しました。"];
      });
    }
  }

  
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    return Scaffold(
      body: Stack(
        children: [
          // 背景（茶色基調にアクセントカラーを追加）
          Positioned.fill(
            child: Container(
              color: const Color.fromARGB(174, 250, 231, 213),
            ),
          ),
          // 上部デコレーション（旗と星）
          Align(
            alignment: Alignment.topCenter, // 横方向に中心、縦方向は上からの距離を調整
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.1),
              child: Row(
                mainAxisSize: MainAxisSize.min, // Row の幅を内容の幅に合わせる
                children: [
                  const Icon(Icons.flag, color: Colors.blue, size: 40),
                  const SizedBox(width: 8),
                  Text(
                    'ミッションにチャレンジしよう！',
                    style: TextStyle(
                      fontSize: screenHeight * 0.025,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // ミッション設定ボタン
          Align(
            alignment: const Alignment(0.0, 0.8),
            child: CategoryButton(
              categoryName: 'ミッション設定',
              backgroundColor: const Color.fromARGB(255, 166, 232, 237),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MissionSettingsScreen()),
                );
              },
            ),
          ),
          // アップロードボタン
          Align(
            alignment: const Alignment(0.0, 0.5),
            child: CategoryButton(
              categoryName: 'アップロード',
              backgroundColor: Colors.orange.shade200,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ImageUploadScreen()),
                );
              },
            ),
          ),
          // クエスト受付場風の木製看板
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: screenHeight * 0.3),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFEDCFA9), // 木製風の明るい色
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: const Color(0xFF9B7642), // 濃い木の色
                  width: 4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(4, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.map,
                    color: Colors.brown[700],
                    size: screenWidth * 0.08,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    displayText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DotGothic16',
                      color: Colors.black87,
                    ),
                    maxLines: 2,  // 最大2行まで表示
                    overflow: TextOverflow.ellipsis,  // はみ出た部分は「…」で省略
                  ),
                ],
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

    final double dashWidth = 10.0;
    final double dashSpace = 6.0;

    // ボタンの内側に収まるように調整
    final double padding = 5.0; // 内側の余白を設定

    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(
          padding, padding, // 余白を考慮して内側に合わせる
          buttonWidth - padding * 2, // 内側に合わせて幅を調整
          buttonHeight - padding * 2, // 内側に合わせて高さを調整
        ),
        Radius.circular(20), // 角丸の半径を調整
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