import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar_example/ImgPrint/ImgDownload.dart';

import '../mainpage/MainPage.dart';

void main() {
  runApp(MaterialApp(
    home: LoadingMotion(),
    debugShowCheckedModeBanner: false,
  ));
}

class LoadingMotion extends StatefulWidget {
  const LoadingMotion({Key? key}) : super(key: key);

  @override
  State<LoadingMotion> createState() => _LoadingMotionState();
}

class _LoadingMotionState extends State<LoadingMotion> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, // 디버그 리본 없애기
        home: Container(
          decoration: BoxDecoration(color: Colors.white,
              // image: DecorationImage(
              //     fit: BoxFit.cover, image: AssetImage('images/ver1.gif'))
          ),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark,
                  statusBarBrightness: Brightness.light,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leadingWidth: 113,
                toolbarHeight: 66,
                leading: gotoMainBtn(),
              ),
              body: Center(
                child: Column(
                  children: [
                    Container(height: 40,
                      color: Colors.transparent,),
                    Text(
                      '변환된 그림이 출력되고 있습니다.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontFamily: 'SUIT',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),


                    Container(
                      height: 600,
                      child:Stack(
                        children: <Widget>[
                          Positioned(
                            top: -150,
                            left: 60,

                            child: Image(
                              image: AssetImage('images/ver1.gif'),
                              height: 600,
                              fit: BoxFit.cover,
                            ),
                          ),

                          Positioned(
                            bottom: 165,
                              left:45,
                              child: ProgressBar())
                        ],
                      ) ,
                    ),


                  ],
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

class ProgressBar extends StatefulWidget {
  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();

    // ex) milliseconds: 30 => 3초 진행, 50 => 5초 진행
    Timer.periodic(Duration(milliseconds: 30), (Timer timer) {
      setState(() {
        _progressValue += 0.01; // 3초에 걸쳐서 100%에 도달하기 위해 0.01씩 증가
      });

      if (_progressValue >= 1.0) {
        timer.cancel(); // 타이머 중지

        // 100%에 도달했을 때 화면 전환
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ImgDownload()),
        );

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 300,
                height: 13,
                child: Semantics(
                  label: 'Loading...',
                  child: LinearProgressIndicator(
                    value: _progressValue,
                    backgroundColor: Color(0xffEFEFEF), // 프로그래스바 배경색
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xff4065DE)), // 프로그래스 바 색상


                  ),
                )
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5,),
        Container(
          width: 300,
          child:Row(
            children: [
              SizedBox(width: 40,),
              Text('변환된 그림이 출력되고 있습니다!',
                style: TextStyle(
                  color: Colors.grey,
                ),),
              SizedBox(width: 5,),
              Text('${(_progressValue * 100).toInt()}%',
                style: TextStyle(
                  color: Colors.grey,
                ),),
            ],
          ) ,
        ),


      ],
    );
  }
}





