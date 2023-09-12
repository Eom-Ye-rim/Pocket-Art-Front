import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../mainpage/MainPage.dart';



void main() {
  runApp(MaterialApp(
    home: SelectingPainter(),
    debugShowCheckedModeBanner: false,
  ));
}

class SelectingPainter extends StatefulWidget {
  const SelectingPainter({Key? key}) : super(key: key);

  @override
  State<SelectingPainter> createState() => _SelectingPainterState();
}

class _SelectingPainterState extends State<SelectingPainter> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, // 디버그 리본 없애기
        home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage('images/img_22.png'))),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark,
                  statusBarBrightness: Brightness.light,
                ),
                leadingWidth: 113,
                toolbarHeight: 66,
                leading: gotoMainBtn(),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.all(17),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                        '변환하고 싶은 화가의\n화풍을 선택해주세요.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: 'SUIT',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 46,
                      ),
                      InkWell(
                        onTap: () {
                          print('빈센트 반고흐');
                        },
                        child: Container(
                          width: 328,
                          height: 96,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              border: Border.all(
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                width: 2,
                              )),
                          child: Row(
                            children: [
                              Container(
                                width: 114,
                                height: 96,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            AssetImage('images/img_23.png'))),
                              ),
                              SizedBox(
                                width: 35,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    '빈센트 반고흐',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'SUIT',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Vincent van Gogh 1853-1890 ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF828282),
                                      fontSize: 10,
                                      fontFamily: 'SUIT',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 19,
                      ),
                      InkWell(
                        onTap: () {
                          print('폴 세잔느');
                        },
                        child: Container(
                          width: 328,
                          height: 96,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              border: Border.all(
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                width: 2,
                              )),
                          child: Row(
                            children: [
                              Container(
                                width: 114,
                                height: 96,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            AssetImage('images/img_24.png'))),
                              ),
                              SizedBox(
                                width: 35,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    '폴 세잔느',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'SUIT',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Paul Cézanne, 1839-1906 ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF828282),
                                      fontSize: 10,
                                      fontFamily: 'SUIT',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 19,
                      ),
                      InkWell(
                        onTap: () {
                          print('클로드 모네');
                        },
                        child: Container(
                          width: 328,
                          height: 96,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              border: Border.all(
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                width: 2,
                              )),
                          child: Row(
                            children: [
                              Container(
                                width: 114,
                                height: 96,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            AssetImage('images/img_25.png'))),
                              ),
                              SizedBox(
                                width: 35,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    '클로드 모네',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'SUIT',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Claude Monet, 1840-1926 ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF828282),
                                      fontSize: 10,
                                      fontFamily: 'SUIT',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 19,
                      ),
                      InkWell(
                        onTap: () {
                          print('에드가 드가');
                        },
                        child: Container(
                          width: 328,
                          height: 96,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              border: Border.all(
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                width: 2,
                              )),
                          child: Row(
                            children: [
                              Container(
                                width: 114,
                                height: 96,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        //에드가 드가 이미지 url 추가해야 함
                                        image: AssetImage(' '))),
                              ),
                              SizedBox(
                                width: 35,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    '에드가 드가',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'SUIT',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Edgar Degas 1834-1917 ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF828282),
                                      fontSize: 10,
                                      fontFamily: 'SUIT',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),

                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 38,),

                      Container(
                          height: 56, width: 356,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32.5),
                            color: Color(0xff363636), // 배경 색상
                          ),
                          child: FilledButton(
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(
                                  Colors.transparent),
                            ),
                            onPressed: () {
                              print("다음 ");
                            },
                            child: Text('다음',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'SUIT',
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center),
                          )

                      )

                    ],
                  ),
                ),
              )),
        ));
  }
}

class gotoMainBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MainPage()),
              );
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
          ),
          width: 25,
          height: 40,
        ),
        Container(
          child: Text('Art Transfer',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'SUIT',
                fontWeight: FontWeight.w600,
              )),
          width: 87,
          height: 18,
          decoration: ShapeDecoration(
            color: Color(0xFF4065DE),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ],
    );
  }
}
