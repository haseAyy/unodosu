import 'package:flutter/material.dart';
import 'dart:math';

class ShapePainter extends CustomPainter {
  final String shapeType;

  ShapePainter(this.shapeType);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    // 形に応じて描画を変更
    if (shapeType == 'ほし') {
      _drawStar(canvas, size, paint);
    } else if (shapeType == 'まる') {
      _drawCircle(canvas, size, paint);
    } else if (shapeType == 'さんかく') {
      _drawTriangle(canvas, size, paint);
    } else if (shapeType == 'しかく') {
      _drawSquare(canvas, size, paint);
    }
  }

   // 星形を描画
  void _drawStar(Canvas canvas, Size size, Paint paint) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 3;  // 外側の半径
    final innerRadius = outerRadius / 3.5; // 内側の半径

    Path path = Path();

    // 最初の角度を -pi / 2 に設定（上方向）
    double angle = -pi / 2;


    // 外側の頂点
    for (int i = 0; i < 5; i++) {
      double angle = (i * 144) * (pi / 180); // 144度ごとに頂点を配置
      double x = center.dx + outerRadius * cos(angle);
      double y = center.dy + outerRadius * sin(angle);
      if (i == 0) {
        path.moveTo(x, y); // 最初の頂点に移動
      } else {
        path.lineTo(x, y);
      }

      // 内側の頂点
      angle += pi / 5; // 72度分進めて内側の頂点を描く
      x = center.dx + innerRadius * cos(angle);
      y = center.dy + innerRadius * sin(angle);
      path.lineTo(x, y);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  // 丸形を描画
  void _drawCircle(Canvas canvas, Size size, Paint paint) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 3; // 丸の半径
    canvas.drawCircle(center, radius, paint);
  }

  // 三角形を描画
  void _drawTriangle(Canvas canvas, Size size, Paint paint) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 3; // 三角形の大きさ

    Path path = Path();
    path.moveTo(center.dx, center.dy - radius); // 上の頂点
    path.lineTo(center.dx - radius, center.dy + radius); // 左下の頂点
    path.lineTo(center.dx + radius, center.dy + radius); // 右下の頂点
    path.close(); // 三角形を閉じる

    canvas.drawPath(path, paint);
  }

  // 四角形を描画
  void _drawSquare(Canvas canvas, Size size, Paint paint) {
    final offset = Offset(size.width / 4, size.height / 4);
    final squareSize = size.width / 2; // 四角形のサイズ

    Rect rect = Rect.fromLTWH(offset.dx, offset.dy, squareSize, squareSize);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
