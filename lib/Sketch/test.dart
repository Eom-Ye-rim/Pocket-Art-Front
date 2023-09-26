import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: sketch(),
    debugShowCheckedModeBanner: false,
  ));
}

class sketch extends StatefulWidget {
  const sketch({Key? key}) : super(key: key);

  @override
  State<sketch> createState() => _sketchState();
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


class _sketchState extends State<sketch> {
  List<List<Offset>> strokes = []; // 각 획을 저장할 리스트
  bool eraseMode = false;
  double touchRadius = 10.0;
  List<Offset> currentPath = []; // 현재 경로를 저장할 리스트


  void _toggleEraseMode(bool value) {
    setState(() {
      eraseMode = value;
      if (eraseMode) {
        currentPath.clear(); // 지우개 모드일 때 현재 경로 비우기
      }
    });
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
                    // SizedBox(width: 4),
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
                                  Text("비우기")
                                ],
                              ),
                            )),
                        PopupMenuDivider(), // 구분선 추가
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
                                  Text("다운로드")
                                ],
                              ),
                            )),
                        PopupMenuDivider(), // 구분선 추가
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
                                  Text("공유하기")
                                ],
                              ),
                            )),
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
                              image: NetworkImage( // 선화 이미지 url
                                "https://c8.alamy.com/comp/2G5R0FX/cartoon-vector-illustration-of-tree-black-outlined-and-white-colored-2G5R0FX.jpg",
                              ),
                            ),
                          ),
                          child: GestureDetector(
                            onPanDown: (details) {
                              if (eraseMode) {
                                setState(() {
                                  currentPath = []; // 새로운 경로 시작
                                  currentPath.add(details.localPosition);
                                });
                              } else {
                                if (details.localPosition.dx >= 0 &&
                                    details.localPosition.dx <= 390 &&
                                    details.localPosition.dy >= 0 &&
                                    details.localPosition.dy <= 390) {
                                  setState(() {
                                    strokes.add([details.localPosition]);
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
                            onPanEnd: (details) {

                            },
                            child: CustomPaint(
                              painter: MyPainter(strokes, currentPath, eraseMode),
                            ),
                          ),
                        ),


                                Divider(  //그림판과 툴바 영역 임시 구분선
                                  color: Color(0xff878787),
                                ),


                        Container(
                          padding: EdgeInsets.fromLTRB(9, 0, 9, 0),
                          child: Column(
                            children: [
                              Container(
                                height: 74,
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
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )))),
    );
  }
}

class MyPainter extends CustomPainter {
  final List<List<Offset>> strokes;
  final List<Offset> currentPath;
  final bool eraseMode;

  MyPainter(this.strokes, this.currentPath, this.eraseMode);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (var stroke in strokes) {
      for (int i = 0; i < stroke.length - 1; i++) {
        if (stroke[i] != null && stroke[i + 1] != null) {
          canvas.drawLine(stroke[i], stroke[i + 1], paint);
        }
      }
    }

    if (eraseMode) {
      paint.blendMode = BlendMode.clear; // 지우개 모드일 때 blend mode를 clear로 설정
      for (int i = 0; i < currentPath.length - 1; i++) {
        if (currentPath[i] != null && currentPath[i + 1] != null) {
          canvas.drawLine(currentPath[i], currentPath[i + 1], paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}