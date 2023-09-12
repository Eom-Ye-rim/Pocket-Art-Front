

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const ChangeStyle());
}

class ChangeStyle extends StatelessWidget {
  const ChangeStyle({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        body:
          Frame427320730(),
      ),
    );
  }
}

class Frame427320730 extends StatelessWidget {
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
                left: 110,
                top: 161,
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
                      Positioned(
                        left: 17,
                        top: 66,
                        child: Container(
                          width: 113,
                          height: 26,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 26,
                                top: 4,
                                child: Container(
                                  width: 87,
                                  height: 18,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF4065DE),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 34,
                                top: 5,
                                child: SizedBox(
                                  width: 79,
                                  height: 15,
                                  child: Text(
                                    'Art Transfer',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Apple SD Gothic Neo',
                                      fontWeight: FontWeight.w600,
                                    ),
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
                top: 285,
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
                top: 285,
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
                top: 285,
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
                top: 285,
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
                top: 506,
                child: GestureDetector(
                  onTap: () {
                    // Handle the click event here
                    _sendImageForTransformation('east');
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
                top: 532,
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
                top: 532,
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
                top: 506,
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
              Positioned(
                left: 26,
                top: 622,
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
                top: 637,
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
            ],
          ),
        ),
      ],
    );
  }
  // Function to send an image for transformation to the server
}
Future<void> _sendImageForTransformation(String modelname) async {
  try {
    final dio = Dio();
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile('/path/to/your/image/file.jpg'),
      'modelname': modelname,
    });

    final response = await dio.post(
      'http://13.209.160.87:8080/api/v1/image',
      data: formData,
    );

    if (response.statusCode == 200) {
      // Request was successful
      final responseData = response.data;

      // Handle the response data as needed
      print('Response Data: $responseData');
    } else {
      // Request failed
      print('Request failed with status code: ${response.statusCode}');
    }
  } catch (e) {
    // Handle errors
    print('Error sending image: $e');
  }
}
