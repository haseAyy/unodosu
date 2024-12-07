import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';


// 丸いボタンを定義
class CircularButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;  // ボタン色を追加

  const CircularButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.buttonColor,  // コンストラクタにcolorを追加
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // MediaQueryキャッシュ
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: screenSize.width * 0.4,
        height: screenSize.height * 0.4,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: buttonColor,  // 渡された色を使う
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

//四角のボタンを定義
class RectangularButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor; // ボタンの色
  final double width; // ボタンの幅
  final double height; // ボタンの高さ
  final Color textColor;

  const RectangularButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.buttonColor,
    this.width = 200, // デフォルト幅
    this.height = 60, // デフォルト高さ
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
          color: buttonColor, // 指定された色を使用
          borderRadius: BorderRadius.circular(10), // 角を少し丸める
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(2, 4),
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
            ),
          ),
        ),
      ),
    );
  }
}

//アップロード画面(親子モード)
class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key});

  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _image; // 選択された画像を保存する変数
  final picker = ImagePicker();

  // 画像をギャラリーから選択する
  Future<void> _pickImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  // 画像をサーバーにアップロードする
  Future<void> _uploadImage(BuildContext context) async {
    if (_image != null) {
      // サーバーのURL（ここでは仮のURLを使用）
      final Uri url = Uri.parse('https://your-server-url.com/upload');

      // 画像ファイルをMultipartRequestで送信
      var request = http.MultipartRequest('POST', url);
      var pic = await http.MultipartFile.fromPath(
        'file', 
        _image!.path,
        contentType: MediaType('image', 'jpeg'), // 画像の種類に応じて変更
      );
      request.files.add(pic);

      // サーバーにリクエストを送信
      try {
        var response = await request.send();
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('画像がアップロードされました！')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('アップロードに失敗しました。')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('アップロードエラーが発生しました。')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('画像を選択してください！')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('画像アップロード'),
      ),
      body: Stack(
        children: [
          // 背景カラー
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenSize.height * 0.9,
            child: Container(color: Colors.lightBlue[300]),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: screenSize.height * 0.1,
            child: Container(color: Colors.green),
          ),
          // 戻るボタン
          Positioned(
            bottom: 10,
            left: 10,
            child: FloatingActionButton(
              onPressed: () => Navigator.pop(context),
              backgroundColor: Colors.grey[350],
              child: const Icon(Icons.arrow_back),
            ),
          ),
          // 画像選択ボタン
          Positioned(
            top: screenSize.height * 0.3,
            left: screenSize.width * 0.25,
            child: GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: screenSize.width * 0.5,
                height: screenSize.height * 0.3,
                color: Colors.white,
                child: _image == null
                    ? const Center(child: Text('+', style: TextStyle(fontSize: 50)))
                    : Image.file(_image!, fit: BoxFit.cover),
              ),
            ),
          ),
          // 送信ボタン
          Positioned(
            bottom: screenSize.height * 0.2,
            right: screenSize.width * 0.3,
            child: ElevatedButton(
              onPressed: () => _uploadImage(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade100,
                minimumSize: Size(screenSize.width * 0.4, screenSize.height * 0.07),
              ),
              child: const Text('送信', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}