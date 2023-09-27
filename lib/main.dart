import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';


void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _sketchState();
}


class EraseModeToggle extends StatelessWidget {
  final bool eraseMode;
  final VoidCallback onPressed;

  EraseModeToggle({required this.eraseMode, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(eraseMode ? '그리기 모드' : '지우개 모드'),
    );
  }
}

enum BrushShape {
  Point, // 점
  Line,   // 선
  Surface, //
}



class _sketchState extends State<MyApp> {
  List<List<Offset>> strokes = []; // 각 획을 저장할 리스트
  bool eraseMode = false;
  List<Color> strokeColors = [];
  Color selectedColor = Colors.black; // Default color
  double touchRadius = 10.0;
  List<Offset> currentPath = []; // 현재 경로를 저장할 리스트
  double progress = 5.0;
  // Store the paths for each brush shape
  double initialPositionX = 100.0; // Initial left position of the circle
  double circleWidth = 15.0;
  List<BrushShape> strokeBrushShapes=[];
  BrushShape previousBrushShape = BrushShape.Line; // Initialize with a default brush shape

  // 브러쉬 모양 결정
  BrushShape selectedBrushShape = BrushShape.Point; // Initial brush shape
  Map<BrushShape, List<Offset>> strokePaths = {
    BrushShape.Point: [],
    BrushShape.Line: [],
    BrushShape.Surface: [],
  };

  Map<Color, Map<BrushShape, List<Offset>>> colorPoints = {
    Colors.black: {
      BrushShape.Point: [],
      BrushShape.Line: [],
      BrushShape.Surface: [],
    },
  };
  void updateProgress(double newValue) {
    setState(() {
      progress = newValue;
    });
  }



  void _toggleEraseMode(bool value) {
    setState(() {
      eraseMode = value;
      if (eraseMode) {
        currentPath.clear(); // 지우개 모드일 때 현재 경로 비우기
      }
    });
  }

  void _changeColor(Color newColor) {
    setState(() {
      selectedColor = newColor;
    });
  }

  //색상 선택
  void openColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('색깔 선택'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (Color color) {
                setState(() {
                  selectedColor = color;
                });
              },
            ),
          ),
        );
      },
    );
  }

  void _handleMenuClick(String value) {
    switch (value) {
      case '비우기':
        setState(() {
          strokes.clear();
        });
        print('비우기 선택');
        break;
      case '다운로드':
        print('다운로드 선택');
        break;
      case '공유하기':
        print('공유하기 선택');
        break;
      default:
        print('알 수 없는 항목 선택: $value');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
            leadingWidth: 140,
            leading: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  '색칠하기',
                  style: TextStyle(
                    color: Color(0xFF505050),
                    fontSize: 20,
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ],
            ),
            actions: [
              PopupMenuButton<String>(
                icon: Icon(Icons.menu, color: Colors.black),
                onSelected: _handleMenuClick,
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: '비우기',
                      child: Container(
                        height: 23,
                        child: Row(
                          children: [
                            Image.asset(
                              'images/img_26.png',
                              width: 21.73,
                              height: 21.73,
                            ),
                            SizedBox(
                              width: 8.27,
                            ),
                            Text("비우기"),
                          ],
                        ),
                      ),
                    ),
                    PopupMenuDivider(),
                    PopupMenuItem<String>(
                      value: '다운로드',
                      child: Container(
                        height: 23,
                        child: Row(
                          children: [
                            Image.asset(
                              'images/img_27.png',
                              width: 24,
                              height: 24,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text("다운로드"),
                          ],
                        ),
                      ),
                    ),
                    PopupMenuDivider(),
                    PopupMenuItem<String>(
                      value: '공유하기',
                      child: Container(
                        height: 23,
                        child: Row(
                          children: [
                            Image.asset(
                              'images/img_28.png',
                              width: 24,
                              height: 24,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text("공유하기"),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
              ),
            ],
          ),
          body: Container(
            color: Colors.white,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 390,
                    height: 390,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          "https://c8.alamy.com/comp/2G5R0FX/cartoon-vector-illustration-of-tree-black-outlined-and-white-colored-2G5R0FX.jpg",
                        ),
                      ),
                    ),
                    child: GestureDetector(
                      onPanDown: (details) {
                        if (eraseMode) {
                          setState(() {
                            currentPath = [];
                            currentPath.add(details.localPosition);
                          });
                        } else {
                          if (details.localPosition.dx >= 0 &&
                              details.localPosition.dx <= 390 &&
                              details.localPosition.dy >= 0 &&
                              details.localPosition.dy <= 390) {
                            setState(() {
                              strokes.add([details.localPosition]);
                              strokeColors.add(selectedColor);
                            });
                          }
                        }
                      },
                      onPanUpdate: (details) {
                        if (strokes.isNotEmpty && !eraseMode) {
                          if (details.localPosition.dx >= 0 &&
                              details.localPosition.dx <= 390 &&
                              details.localPosition.dy >= 0 &&
                              details.localPosition.dy <= 390) {
                            setState(() {
                              strokes.last.add(details.localPosition);
                            });
                          }
                        } else if (eraseMode) {
                          setState(() {
                            currentPath.add(details.localPosition);
                          });
                        }
                      },
                      onPanEnd: (details) {},
                      child:
                      CustomPaint(
                        painter: MyPainter(
                          strokes, // Pass the strokePaths map here
                          strokeBrushShapes,
                          strokeColors,
                          currentPath,
                          eraseMode,
                          selectedColor,
                          progress,
                          selectedBrushShape,
                        ),
                      ),

                    ),
                  ),
                  Divider(
                    color: Color(0xff878787),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(9, 0, 9, 0),
                    child: Column(
                      children: [
                        Container(
                          height: 64,
                        ),
                        Divider(
                          color: Color(0xff878787),
                        ),
                        Container(
                          height: 43,
                          child: Row(
                            children: [
                              Text(
                                '지우개 모드',
                                style: TextStyle(
                                  color: Color(0xFF3C3C3C),
                                  fontSize: 13,
                                  fontFamily: 'SUIT',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                              Switch(
                                value: eraseMode,
                                onChanged: _toggleEraseMode,
                              ),
                            ],
                          ),
                        ),
                        //펜 선택
                        Divider(
                          color: Color(0xff878787),
                        ),
                        Container(
                          width: 434,
                          height: 207,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 106,
                                child: Container(
                                  width: 434,
                                  height: 81,
                                  decoration: BoxDecoration(color: Color(0xFFEAEAEA)),
                                ),
                              ),
                              Positioned(
                                left: 86,
                                top: 0,
                                child: Container(
                                  width: 43,
                                  height: 43,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFEFEFEF),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 5,
                                top: 112,
                                child: Container(
                                  width: 70,
                                  height: 70,

                                  child: TextButton(
                                       onPressed: () {
                                    openColorPicker();},

                            child: Container(

                            decoration: ShapeDecoration(
                              color: selectedColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                                ),
                                ),
                               ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 81,
                                top: 151,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: ShapeDecoration(
                                    color: Colors.black,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 81,
                                top: 112,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFD9D9D9),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 120,
                                top: 151,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF738A9C),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 120,
                                top: 112,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF737D96),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 158,
                                top: 151,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF838184),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 158,
                                top: 112,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF6B696C),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 197,
                                top: 151,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFC4C2C5),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 197,
                                top: 112,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFACAAAD),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 236,
                                top: 151,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFDFDFDF),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 236,
                                top: 112,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFD7D2D6),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 275,
                                top: 151,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFF88185),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 275,
                                top: 112,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFCE5D59),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 313,
                                top: 151,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFF0967B),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 313,
                                top: 112,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFFF8173),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 352,
                                top: 151,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFDE0F39),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 352,
                                top: 112,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFFFA17B),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 5,
                                top: 15,
                                child: SizedBox(
                                  width: 91,
                                  height: 14,
                                  child: Text(
                                    '펜 선택',
                                    style: TextStyle(
                                      color: Color(0xFF3C3C3C),
                                      fontSize: 13,
                                      fontFamily: 'Apple SD Gothic Neo',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 85,
                                top: 5,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedBrushShape = BrushShape.Point;

                                    });
                                  },
                                  child: SizedBox(
                                    width: 34,
                                    height: 34,
                                    child:  Image.asset(
                                      'images/pen1.png',
                                      width: 34,
                                      height: 34,
                                    ),
                                  ),
                                ),
                              ),

                              Positioned(
                                left: 138,
                                top: 5,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedBrushShape = BrushShape.Surface;

                                    });
                                  },
                                  child: SizedBox(
                                    width: 34,
                                    height: 34,
                                    child:  Image.asset(
                                      'images/pen2.png',
                                      width: 34,
                                      height: 34,
                                    ),
                                  ),
                                ),
                              ),

                              Positioned(
                                left: 185,
                                top: 5,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedBrushShape = BrushShape.Line;

                                    });
                                  },
                                  child: SizedBox(
                                    width: 34,
                                    height: 34,
                                    child:  Image.asset(
                                      'images/pen3.png',
                                      width: 34,
                                      height: 34,
                                    ),
                                  ),
                                ),
                              ),

                              Positioned(
                                left: 225,
                                top: 5,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                    //  selectedBrushShape = BrushShape.Point;
                                    });
                                  },
                                  child: SizedBox(
                                    width: 34,
                                    height: 34,
                                    child:  Image.asset(
                                      'images/pen4.png',
                                      width: 34,
                                      height: 34,
                                    ),
                                  ),
                                ),
                              ),

                              Positioned(
                                left: 5,
                                top: 59,
                                child: SizedBox(
                                  width: 91,
                                  height: 14,
                                  child: Text(
                                    '펜 두께(1px)',
                                    style: TextStyle(
                                      color: Color(0xFF3C3C3C),
                                      fontSize: 13,
                                      fontFamily: 'Apple SD Gothic Neo',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 48,
                                child: Container(
                                  width: 375,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 0.20,
                                        strokeAlign: BorderSide.strokeAlignCenter,
                                        color: Color(0xFF868686),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 84,
                                child: Container(
                                  width: 375,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 0.20,
                                        strokeAlign: BorderSide.strokeAlignCenter,
                                        color: Color(0xFF868686),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Positioned(
                                left: 87,
                                top: 67,
                                child: Container(
                                  width: 10,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        strokeAlign: BorderSide.strokeAlignCenter,
                                        color: Color(0xFF4A4A4A),
                                      ),
                                    ),
                                  ),
                                ),
                              ),


                              Positioned(
                                left:  initialPositionX, // Adjust the left position as needed
                                top: 40, // Adjust the top position as needed
                                width: 200,
                                child: Slider(
                                  value: progress,
                                  min: 1.0,
                                  max: 70.0,
                                  onChanged: (value) {
                                    setState(() {
                                      progress = value; // Update brush size
                                    });
                                  },
                                  activeColor: Color(0xFF001438), // Change the active color
                                  inactiveColor: Colors.grey, // Change the inactive color
                                ),
                              ),

                              Positioned(
                                left: 350,
                                top: 58,
                                child: Container(
                                  width: 19,
                                  height: 19,
                                  padding: const EdgeInsets.all(3.96),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                    ],
                                  ),
                                ),
                              ),
                              // Positioned(
                              //   left: 87,
                              //   top: 100,
                              //   child: Container(
                              //     width: 10,
                              //     decoration: ShapeDecoration(
                              //       shape: RoundedRectangleBorder(
                              //         side: BorderSide(
                              //           width: 1,
                              //           strokeAlign: BorderSide.strokeAlignCenter,
                              //           color: Color(0xFF4A4A4A),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // Positioned(
                              //   left: 121,
                              //   top: 100,
                              //   child: Container(
                              //     width: 49,
                              //     decoration: ShapeDecoration(
                              //       shape: RoundedRectangleBorder(
                              //         side: BorderSide(
                              //           width: 3,
                              //           strokeAlign: BorderSide.strokeAlignCenter,
                              //           color: Color(0xFF3D4ABE),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // Positioned(
                              //   left: 165,
                              //   top: 92,
                              //   child: Container(
                              //     width: 15,
                              //     height: 15,
                              //     decoration: ShapeDecoration(
                              //       color: Color(0xFF5363FA),
                              //       shape: OvalBorder(),
                              //       shadows: [
                              //         BoxShadow(
                              //           color: Color(0x3F000000),
                              //           blurRadius: 2,
                              //           offset: Offset(0, 0),
                              //           spreadRadius: 0,
                              //         )
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              Positioned(
                                left: 350,
                                top: 91,
                                child: Container(
                                  width: 19,
                                  height: 19,
                                  padding: const EdgeInsets.all(3.96),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                    ],
                                  ),
                                ),
                              ),
                               ],
                          ),
                        ),
            ]),
            ),
          ]),
        )))));
  }
}





class MyPainter extends CustomPainter {
  final List<List<Offset>> strokes;
  final List<BrushShape> strokeBrushShapes;
  final List<Color> strokeColors;
  final List<Offset> currentPath;
  final bool eraseMode;
  Color selectedColor;
  BrushShape selectedBrushShape;
  BrushShape previousBrushShape = BrushShape.Line; // 처음엔 기본 선으로 초기화


  double progress;
  double maxStrokeWidth = 10.0;
  double minStrokeWidth = 1.0;

  MyPainter(this.strokes, this.strokeBrushShapes, this.strokeColors, this.currentPath, this.eraseMode, this.selectedColor, this.progress, this.selectedBrushShape) {
    previousBrushShape = selectedBrushShape;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 프로그레스 계산
    double? currentStrokeWidth = lerpDouble(minStrokeWidth, maxStrokeWidth, progress / 100);


    for (int i = 0; i < strokes.length; i++) {
      var paint = Paint()
        ..strokeCap = StrokeCap.round
        ..strokeWidth = currentStrokeWidth!
        ..color = strokeColors[i];

      //브러쉬 타입 확인
      if (i < strokeBrushShapes.length && strokeBrushShapes[i] == previousBrushShape) {
        for (int j = 0; j < strokes[i].length - 1; j++) {
          if (strokes[i][j] != null && strokes[i][j + 1] != null) {
           //브러쉬 모양이랑 선 그림 -> 같이 그려져서 수정
            if (previousBrushShape == BrushShape.Point) {
              canvas.drawCircle(strokes[i][j], currentStrokeWidth / 2, paint);
            } else if (previousBrushShape == BrushShape.Line) {
              canvas.drawLine(strokes[i][j], strokes[i][j + 1], paint);
            } else if (previousBrushShape == BrushShape.Surface) {
              final rect = Rect.fromPoints(strokes[i][j], strokes[i][j + 1]);
              canvas.drawRect(rect, paint);
            }
          }
        }
      } else {
        for (int j = 0; j < strokes[i].length - 1; j++) {
          if (strokes[i][j] != null && strokes[i][j + 1] != null) {
            if (selectedBrushShape == BrushShape.Point) {
              canvas.drawCircle(strokes[i][j], currentStrokeWidth / 2, paint);
            } else if (selectedBrushShape == BrushShape.Line) {
              canvas.drawLine(strokes[i][j], strokes[i][j + 1], paint);
            } else if (selectedBrushShape == BrushShape.Surface) {
              final rect = Rect.fromPoints(strokes[i][j], strokes[i][j + 1]);
              canvas.drawRect(rect, paint);
            }
          }
        }
      }
    }
  }


  void changeBrushType(BrushShape newBrushType) {
    selectedBrushShape = newBrushType; // 새로운 브러쉬 모양 설정

    // To do -> 이전 펜 획에는 영향을 미치지 않도록 -> 근데 영향 미침
    if (currentPath.isNotEmpty && strokes.isNotEmpty) {
      int currentIndex = strokes.length - 1;
      strokeBrushShapes[currentIndex] = selectedBrushShape;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
