import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MyDrawingApp());
}

class MyDrawingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DrawingScreen(),
    );
  }
}

class DrawingScreen extends StatefulWidget {
  @override
  _DrawingScreenState createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  List<Offset?> points = [];
  List<List<Offset>> strokes = []; // 각 획을 저장할 리스트

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Drawing App'),
      ),
      body: GestureDetector(
        onPanDown: (details) {
          setState(() {
            strokes.add([details.localPosition]); // 새로운 획 시작
          });
        },
        onPanUpdate: (details) {
          setState(() {
            if (strokes.isNotEmpty) {
              strokes.last.add(details.localPosition); // 현재 획에 점 추가
            }
          });
        },
        onPanEnd: (details) {
          // strokes.add(null); // 획의 끝을 구분하기 위해 null 추가 (선택 사항)
        },
        child: Container( // Add a Container to cover the GestureDetector
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: MyPainter(strokes),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.clear),
        onPressed: () {
          setState(() {
            strokes.clear();
          });
        },
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final List<List<Offset>> strokes;
  MyPainter(this.strokes);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (var stroke in strokes) {
      for (int i = 0; i < stroke.length - 1; i++) {
        if (stroke[i] != null && stroke[i + 1] != null) {
          canvas.drawLine(stroke[i], stroke[i + 1], paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}