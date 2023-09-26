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

class _sketchState extends State<sketch> {
  void _handleMenuClick(String value) {
    switch (value) {
      case '메뉴 항목 1':
        print('메뉴 항목 1을 선택했습니다.');
        break;
      case '메뉴 항목 2':
        print('메뉴 항목 2를 선택했습니다.');
        break;
      case '메뉴 항목 3':
        print('메뉴 항목 3을 선택했습니다.');
        break;
      default:
        print('알 수 없는 항목이 선택되었습니다: $value');
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
                            value: '메뉴 항목 1',
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
                            value: '메뉴 항목 2',
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
                            value: '메뉴 항목 3',
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

                color: Colors.grey,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Container(
                        width: 390,
                        height: 390,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "https://c8.alamy.com/comp/2G5R0FX/cartoon-vector-illustration-of-tree-black-outlined-and-white-colored-2G5R0FX.jpg",
                                ))),
                      ),
                    ],
                  ),
                )
              ))),
    );
  }
}
