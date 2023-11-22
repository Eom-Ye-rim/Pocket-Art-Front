import 'package:flutter/material.dart';
import 'package:flutter_ar_example/splash/FirstSplash.dart';
import 'package:flutter_ar_example/splash/SecondSplash.dart';
import 'package:flutter_ar_example/splash/ThirdSplash.dart';

import '../user/LoginMain.dart';

void main() {
  runApp(const FirstSplash());
}

class FirstSplash extends StatelessWidget {
  const FirstSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        body:
        Frame427320775(),
      ),
    );
  }
}


class Frame427320775 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width:  MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/test.png'),
              fit: BoxFit.cover,
            ),
          ),

          child: Stack(
            children: [
              Positioned(
                left: 65,
                top: 181,
                child: Text(
                  '내가 원하는 그림으로 화풍을 변환하고!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Apple SD Gothic Neo',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 390,
                  height: 46,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 66.66,
                        height: 11.34,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 42.33,
                              top: 0,
                              child: Container(
                                width: 24.33,
                                height: 11.33,
                                child: Stack(children: [

                                ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                left: 17,
                top: 30,
                child: Container(
                  width: 400,
                  height: 800,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/fs1.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 291.10,
                top: 559.03,
                child: Container(
                  width: 98,
                  height: 138.97,
                  child: Stack(children: [

                  ]),
                ),
              ),
              Positioned(
                left: 258,
                top: 643.41,
                child: Container(
                  width: 50.79,
                  height: 35.59,
                  child: Stack(children: [

                  ]),
                ),
              ),
              Positioned(
                left: 363.45,
                top: 573.59,
                child: Container(
                  width: 33.29,
                  height: 35.82,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 6.20,
                        child: Container(
                          width: 26.94,
                          height: 29.61,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 18.19,
                                top: 0,
                                child: Container(
                                  width: 8.75,
                                  height: 9.21,
                                  child: Stack(children: [

                                  ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                left: 170,
                top: 80,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: ShapeDecoration(
                    color: Color(0xFF406BF6),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 200,
                top: 80,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: ShapeDecoration(
                    color: Color(0xFFD9D9D9),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 230,
                top: 80,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: ShapeDecoration(
                    color: Color(0xFFD9D9D9),
                    shape: OvalBorder(),
                  ),
                ),
              ),

              Positioned(
                left: 285,
                top: 600,
                child: Container(
                  width: 60,
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/character.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 320,
                top: 777,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondSplash()),
                    );
                  }
                  ,child:Icon(Icons.arrow_forward),

                ),
              )],
          ),
        ),
      ],
    );
  }
}