

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar_example/ImgPrint/SelectingPainter.dart';
import 'package:flutter_ar_example/style/Chocie.dart';

import '../mainpage/MainPage.dart';


class ChangeStyle extends StatefulWidget {
   File selectImg;

  ChangeStyle({Key? key, required this.selectImg}) : super(key: key);

  @override
  _ChangeStyle createState() => _ChangeStyle();
}

class _ChangeStyle extends State<ChangeStyle> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          automaticallyImplyLeading: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,

          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,
              color: Colors.black,),
            onPressed: () {
              //뒤로가기
              Navigator.pop(context);
            },
          ),
        ),
        body:
          Frame427320730(selectImg: widget.selectImg),
      ),
    );
  }

}





class Frame427320730 extends StatefulWidget {
  final File selectImg; // Declare selectImg as a member variable

  Frame427320730({Key? key, required this.selectImg}) : super(key: key);

  @override
  _Frame427320730State createState() => _Frame427320730State(selectImg: selectImg);

}


class _Frame427320730State extends State<Frame427320730> {
  final File selectImg; // Declare selectImg as a member variable
  String type="";

  _Frame427320730State({required this.selectImg}) ;
  Color boxColor = Colors.white; // 초기 색상 설정
  @override
  Widget build(BuildContext context) {
    File file=selectImg;
    print("File test + $file");
    return Column(
      children: [
        Container(
          width:  MediaQuery.of(context).size.width,
          height:792,
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
                left: 110,
                top: 57,
                child: Text(
                  '변환하고 싶은 스타일의\n화풍을 선택해주세요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
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
                  height: 92,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 390,
                          height: 46,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 308.67,
                                top: 17.33,
                                child: Container(
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
                                      // Positioned(
                                      //   left: 22.03,
                                      //   top: 0,
                                      //   child: Container(
                                      //     width: 15.27,
                                      //     height: 10.97,
                                      //     decoration: BoxDecoration(
                                      //       image: DecorationImage(
                                      //         image: NetworkImage("https://via.placeholder.com/15x11"),
                                      //         fit: BoxFit.fill,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      // Positioned(
                                      //   left: 0,
                                      //   top: 0.34,
                                      //   child: Container(
                                      //     width: 17,
                                      //     height: 10.67,
                                      //     decoration: BoxDecoration(
                                      //       image: DecorationImage(
                                      //         image: NetworkImage("images/1.png"),
                                      //         fit: BoxFit.fill,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
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
                left: 27,
                top: 181,
                child: Container(
                  width: 168,
                  height: 276,
                  decoration: ShapeDecoration(
                    color: Colors.white.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.black.withOpacity(0.30000001192092896),
                      ),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 10,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 215,
                top: 181,
                child: Container(
                  width: 168,
                  height: 276,
                  decoration: ShapeDecoration(
                    color: Colors.white.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Colors.black.withOpacity(0.30000001192092896),
                      ),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 10,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 215,
                top: 181,
                child: Container(
                  width: 168,
                  height: 204,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/5.png'), // Replace with your image path
                      fit: BoxFit.cover, // Adjust the fit as needed
                    ),
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      width: 1,
                      color: Color(0xB26F6F6F),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 10,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),
              // Positioned(
              //   left: 205,
              //   top: 285,
              //   child: Container(
              //     width: 168,
              //     height: 204,
              //     child: Stack(
              //       children: [
              //         Positioned(
              //           left: 0,
              //           top: 0,
              //           child: Container(
              //             width: 168,
              //             height: 204,
              //             decoration: ShapeDecoration(
              //               color: Colors.white,
              //               shape: RoundedRectangleBorder(
              //                 side: BorderSide(
              //                   width: 1,
              //                   color: Colors.black.withOpacity(0.30000001192092896),
              //                 ),
              //               ),
              //               shadows: [
              //                 BoxShadow(
              //                   color: Color(0x3F000000),
              //                   blurRadius: 10,
              //                   offset: Offset(0, 0),
              //                   spreadRadius: 0,
              //                 )
              //               ],
              //             ),
              //           ),
              //         ),
                      // Positioned(
                      //   left: -77,
                      //   top: 0,
                      //   child: Container(
                      //     width: 244,
                      //     height: 213,
                      //     decoration: BoxDecoration(
                      //       image: DecorationImage(
                      //         image: NetworkImage("images/1.png"),
                      //         fit: BoxFit.fill,
                      //       ),
                      //       border: Border.all(width: 0.50),
                      //     ),
                      //   ),
                      // ),
              //       ],
              //     ),
              //   ),
              // ),
              // Positioned(
              //   left: 205,
              //   top: 285,
              //   child: Container(
              //     width: 168,
              //     height: 276,
              //     decoration: ShapeDecoration(
              //       color: Colors.white.withOpacity(0),
              //       shape: RoundedRectangleBorder(
              //         side: BorderSide(width: 1, color: Color(0xB26F6F6F)),
              //       ),
              //       shadows: [
              //         BoxShadow(
              //           color: Color(0x3F000000),
              //           blurRadius: 10,
              //           offset: Offset(0, 0),
              //           spreadRadius: 0,
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // Positioned(
              //   left: 17,
              //   top: 285,
              //   child: Container(
              //     width: 168,
              //     height: 204,
              //     child: Stack(
              //       children: [
              //         Positioned(
              //           left: 0,
              //           top: 0,
              //           child: Container(
              //             width: 168,
              //             height: 204,
              //             decoration: ShapeDecoration(
              //               color: Colors.white,
              //               shape: RoundedRectangleBorder(
              //                 side: BorderSide(
              //                   width: 1,
              //                   color: Colors.black.withOpacity(0.30000001192092896),
              //                 ),
              //               ),
              //               shadows: [
              //                 BoxShadow(
              //                   color: Color(0x3F000000),
              //                   blurRadius: 10,
              //                   offset: Offset(0, 0),
              //                   spreadRadius: 0,
              //                 )
              //               ],
              //             ),
              //           ),
              //         ),
              //         Positioned(
              //           left: -43,
              //           top: 1,
              //           child: Container(
              //             width: 211,
              //             height: 210.96,
              //             decoration: BoxDecoration(
              //               image: DecorationImage(
              //                 image: NetworkImage("images/1.png"),
              //                 fit: BoxFit.fill,
              //               ),
              //               border: Border.all(width: 0.50),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Positioned(
                left: 27,
                top: 181,
                child: Container(
                  width: 168,
                  height: 204,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/1.png'), // Replace with your image path
                      fit: BoxFit.cover, // Adjust the fit as needed
                    ),
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      width: 1,
                      color: Color(0xB26F6F6F),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 10,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 85,
                top: 402,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      type="east";
                    });
                    // Handle the click event here
                    // _sendImageForTransformation('east');
                  },
                child: Text(
                  '동양풍',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Apple SD Gothic Neo',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ),
              Positioned(
                left: 64,
                top: 428,
                child: Text(
                  '동양풍 변환하러 가기 ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF828282),
                    fontSize: 10,
                    fontFamily: 'Apple SD Gothic Neo',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 252,
                top: 428,
                child: Text(
                  '서양풍 변환하러 가기 ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF828282),
                    fontSize: 10,
                    fontFamily: 'Apple SD Gothic Neo',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 273,
                top: 402,
                child: GestureDetector(
                  onTap: () {
                    // "서양풍" 클릭 시 박스 색상 변경
                    setState(() {
                      type="east";
                      boxColor = Color(0xAFFC634);
                    });
                  },
                child: Text(
                  '서양풍',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Apple SD Gothic Neo',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
    ),
              Positioned(
                left: 26,
                top: 518,
                child: Container(
                  width: 358,
                  height: 56,
                  decoration: ShapeDecoration(
                    color: Color(0xFF363636),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.50),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 9,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 188,
                top: 533,
                child: GestureDetector(
                  onTap: () {
                    // "다음" 버튼 클릭 시 페이지 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SelectingPainter(selectImg: file,type:type)),
                    );
                  },
                child: Text(
                  '다음',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Apple SD Gothic Neo',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              )],
          ),
        ),
      ],
    );

  }


// Function to send an image for transformation to the server
}

// Future<void> _sendImageForTransformation(String modelname) async {
//   try {
//     final dio = Dio();
//     final formData = FormData.fromMap({
//       'file': await MultipartFile.fromFile('/path/to/your/image/file.jpg'),
//       'modelname': modelname,
//     });
//
//     final response = await dio.post(
//       'http://13.209.160.87:8080/api/v1/image',
//       data: formData,
//     );
//
//     if (response.statusCode == 200) {
//       // Request was successful
//       final responseData = response.data;
//
//       // Handle the response data as needed
//       print('Response Data: $responseData');
//     } else {
//       // Request failed
//       print('Request failed with status code: ${response.statusCode}');
//     }
//   } catch (e) {
//     // Handle errors
//     print('Error sending image: $e');
//   }
// }
