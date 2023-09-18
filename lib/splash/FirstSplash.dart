//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_ar_example/mainpage/MainPage.dart';
// import 'package:flutter_ar_example/user/signupcode.dart';
// import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   KakaoSdk.init(nativeAppKey:'077a09d06719ae6dd518a8049399d4a0');
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: const FirstRoute(),
//     );
//   }
// }
//
// class FirstRoute extends StatefulWidget {
//   const FirstRoute({Key? key}) : super(key: key);
//
//   @override
//   _FirstRouteState createState() => _FirstRouteState();
// }
//
// class _FirstRouteState extends State<FirstRoute> {
//   String email='';
//   String password='';
//
//   bool _isChecked = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Container(
//         child: Stack(
//           children: [
//             Positioned.fill(
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 child: Opacity(
//                   opacity: 1,
//                   child: Container(
//                     width: 536,
//                     height: 1050,
//                     child: Stack(
//                       children: [],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               left: 44,
//               top: 332,
//               child: Container(
//                 width: 320,
//                 child: Column(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       height: 57,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Color(0xffb3b3b3),
//                           width: 1,
//                         ),
//                       ),
//                       child: Column(
//                         children: [
//                           Container(
//                             width: 309,
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Column(
//                                     children: [
//                                       SizedBox(
//                                         width: 309,
//                                         child: TextField(
//                                           onChanged: (value) {
//                                             setState(() {
//                                               email = value;
//                                             });
//                                           },
//                                           decoration: InputDecoration(
//                                             hintText: "이메일 주소 입력",
//                                             hintStyle: TextStyle(
//                                               color: Color(0xffb3b3b3),
//                                               fontSize: 14,
//                                             ),
//                                             border: InputBorder.none,
//                                           ),
//                                           style: TextStyle(
//                                             color: Color(0xff121319),
//                                             fontSize: 14,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//               left: 44,
//               top: 405,
//               child: Container(
//                 width: 320,
//                 height: 57,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Color(0xffb3b3b3),
//                     width: 1,
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               children: [
//                                 SizedBox(
//                                   width: 309,
//                                   child: TextField(
//                                     onChanged: (value) {
//                                       setState(() {
//                                         password = value;
//                                       });
//                                     },
//                                     decoration: InputDecoration(
//                                       hintText: "비밀번호 입력",
//                                       hintStyle: TextStyle(
//                                         color: Color(0xffb3b3b3),
//                                         fontSize: 14,
//                                       ),
//                                       border: InputBorder.none,
//                                     ),
//                                     style: TextStyle(
//                                       color: Color(0xffb3b3b3),
//                                       fontSize: 14,
//                                     ),
//                                     obscureText: true,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//               left: 30,
//               top: 455,
//               child: Container(
//                 width: 320,
//                 height: 57,
//
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       child: Row(
//                         children: [
//                           Checkbox(
//                             value: _isChecked,
//                             onChanged: (value) {
//                               setState(() {
//                                 _isChecked = value!;
//                               });
//                             },
//                           ),
//                           Text(
//                             "로그인 상태 유지",
//                             style: TextStyle(
//                               color: Color(0xff000000),
//                               fontSize: 11,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//               left: 47,
//               top: 520,
//
//               child: Container(
//                 width: 320,
//                 height: 50,
//                 decoration: BoxDecoration(
//
//                   color: Colors.black,
//                 ),
//                 // padding: const EdgeInsets.only(
//                 //   left: 32,
//                 //   right: 39,
//                 //   top: 15,
//                 //   bottom: 20,
//                 // ),
//                 child: TextButton(
//                   //
//
//                   onPressed: () async {
//                     print("click");
//                     final url = Uri.parse(
//                         'http://13.209.160.87:8080/login');
//                     Map<String, dynamic> data = {
//                       'email': email,
//                       'password': password,
//                     };
//                     String jsonData = json.encode(data);
//                     print(jsonData);
//                     try {
//                       final response = await http.post(
//                         url,
//                         headers: {'Content-Type': 'application/json'},
//                         // Set the request header
//                         body: jsonData, // Set the JSON data as the request body
//                       );
//                       print(response);
//                       print(response.statusCode);
//
//                       if (response.statusCode == 200) {
//                         var responseData = json.decode(response.body);
//                         var accessToken = responseData['data']['accessToken'];
//                         print(accessToken);
//
//                         // shared_preferences를 사용하여 accessToken 안전하게 저장
//                         SharedPreferences prefs = await SharedPreferences
//                             .getInstance();
//                         await prefs.setString('accessToken', accessToken);
//                         Navigator.push(
//                           context,
//                           //PhotoBoard
//                           MaterialPageRoute(builder: (context) => MainPage()),
//                         );
//
//                         // Request successful
//                         print('Data sent successfully.');
//                       } else {
//                         // Request failed
//                         print('Failed to send data. Status code: ${response
//                             .statusCode}');
//                       }
//                     } catch (e) {
//                       // Handle any exceptions that might occur during the API call
//                       print('Error: $e');
//                     }
//                   },
//
//
//
//                   //     if (await isKakaoTalkInstalled()) {
//                   //       try {
//                   //         await UserApi.instance.loginWithKakaoTalk();
//                   //         print('카카오톡으로 로그인 성공');
//                   //       } catch (error) {
//                   //         print('카카오톡으로 로그인 실패 $error');
//                   //
//                   //         // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
//                   //         // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
//                   //         if (error is PlatformException && error.code == 'CANCELED') {
//                   //           return;
//                   //         }
//                   //         // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
//                   //         try {
//                   //           await UserApi.instance.loginWithKakaoAccount();
//                   //           print('카카오계정으로 로그인 성공');
//                   //         } catch (error) {
//                   //           print('카카오계정으로 로그인 실패 $error');
//                   //         }
//                   //       }
//                   //     } else {
//                   //       try {
//                   //         await UserApi.instance.loginWithKakaoAccount();
//                   //         print('카카오계정으로 로그인 성공');
//                   //       } catch (error) {
//                   //         print('카카오계정으로 로그인 실패 $error');
//                   //       }
//                   //     }
//                   //
//                   // },
//                   // onPressed: () async {
//                   //   final url =
//                   //       'https://kauth.kakao.com/oauth/authorize?client_id=179011b75542e1a21fa2207d50a4df57&redirect_uri=http://localhost:8080/auth/kakao/callback&response_type=code';
//                   //   if (await canLaunch(url)) {
//                   //     await launch(url);
//                   //   } else {
//                   //     throw 'Could not launch $url';
//                   //   }
//                   // },
//
//                   child: Text(
//                     "로그인",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//
//             Positioned(
//               left: 88,
//               top: 575,
//               child: Container(
//                 width: 320,
//                 height: 57,
//
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       child: Row(
//                         children: [
//                           Text(
//                             "이메일 찾기",
//                             style: TextStyle(
//                               color: Color(0xff000000),
//                               fontSize: 11,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             Positioned(
//               left: 156,
//               top: 575,
//               child: Container(
//                 width: 320,
//                 height: 57,
//
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       child: Row(
//                         children: [
//                           Text(
//                             "|",
//                             style: TextStyle(
//                               color: Color(0xff000000),
//                               fontSize: 11,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             Positioned(
//               left: 171,
//               top: 575,
//               child: Container(
//                 width: 320,
//                 height: 57,
//
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       child: Row(
//                         children: [
//                           Text(
//                             "비밀번호 찾기",
//                             style: TextStyle(
//                               color: Color(0xff000000),
//                               fontSize: 11,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             Positioned(
//               left: 88,
//               top: 575,
//               child: Container(
//                 width: 320,
//                 height: 57,
//
//                 child: Column(
//
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       child: Row(
//                         children: [
//                           Text(
//                             "이메일 찾기",
//                             style: TextStyle(
//                               color: Color(0xff000000),
//                               fontSize: 11,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             Positioned(
//               left: 251,
//               top: 575,
//               child: Container(
//                 width: 320,
//                 height: 57,
//
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       child: Row(
//                         children: [
//                           Text(
//                             "|",
//                             style: TextStyle(
//                               color: Color(0xff000000),
//                               fontSize: 11,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//
//
//             Positioned(
//               left: 270,
//               top: 575,
//               child: GestureDetector(
//                 onTap: () {
//                   // Handle the sign-up button tap
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => ThirdRoute()),
//                   );
//                 },
//                 child: Container(
//                   width: 320,
//                   height: 57,
//
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         width: double.infinity,
//                         child: Row(
//                           children: [
//                             Text(
//                               "회원가입",
//                               style: TextStyle(
//                                 color: Color(0xff000000),
//                                 fontSize: 11,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//
//             Positioned(
//               left: 94,
//               top: 709,
//               child: Container(
//                 width: 320,
//                 height: 57,
//
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       child: Row(
//                         children: [
//                           Text(
//                             "SNS 계정으로 간편하게 로그인하세요.",
//                             style: TextStyle(
//                               color: Color(0xff000000),
//                               fontSize: 14,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//
//             Positioned(
//               left: 110,
//               top: 740,
//               child: Container(
//                 width: 400,
//                 height: 57,
//                 child: Column(
//
//                   children: [
//                     Container(
//                       width: 400,
//                       child: Row(
//                         children: [
//                           ElevatedButton(
//                             onPressed: () {
//                             },
//                             style: ElevatedButton.styleFrom(
//                               elevation: 0,
//                               padding: EdgeInsets.zero,
//                             ),
//                             child: Image.asset(
//                               'images/kakao_login_medium_narrow.png',  // 이미지 경로 및 파일명으로 수정해야 합니다.
//                             ),
//                           ),
//
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//
//             Positioned(
//               left: 56,
//               top: 202,
//               child: Container(
//                 width: 284,
//                 height: 67,
//                 child: Image.asset('images/logos.png', width: 67),
//               ),
//             ),
//             Positioned.fill(
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 child: Container(
//                   width: 414,
//                   height: 49,
//                   padding: const EdgeInsets.only(
//                     left: 33,
//                     right: 15,
//                     bottom: 20,
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Container(
//                         width: 28.43,
//                         height: 11.09,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: Color(0xff121319),
//                         ),
//                       ),
//                       SizedBox(width: 25.89),
//                       Container(
//                         width: 66.66,
//                         height: 11.34,
//                         child: Stack(
//                           children: [
//                             Container(
//                               width: 24.33,
//                               height: 11.33,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: FlutterLogo(
//                                 size: 11.333333015441895,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               left: 37,
//               top: 510,
//               child: Container(
//                 width: 333,
//                 height: 1,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_ar_example/splash/FirstSplash.dart';
import 'package:flutter_ar_example/splash/ThirdSplash.dart';

import '../user/LoginMain.dart';

void main() {
  runApp(const FirstSplash());
}

// Generated by: https://www.figma.com/community/plugin/842128343887142055/
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
                            // Positioned(
                            //   left: 22.03,
                            //   top: 0,
                            //   child: Container(
                            //     width: 15.27,
                            //     height: 10.97,
                            //     decoration: BoxDecoration(
                            //       image: DecorationImage(
                            //       image: AssetImage('images/ss.png'),
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
                            //         image: NetworkImage("https://via.placeholder.com/17x11"),
                            //         fit: BoxFit.fill,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
              //       image: AssetImage('images/ss.png'),
              //         fit: BoxFit.fill,
              //       ),
              //     ),
              //   ),
              // ),
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
                left: 161,
                top: 69,
                child: Container(
                  width: 66,
                  height: 14,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
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
                        left: 52,
                        top: 0,
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
                        left: 26,
                        top: 0,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: ShapeDecoration(
                            color: Color(0xFFD9D9D9),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                    ],
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
                left: 309,
                top: 777,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ThirdSplash()),
                    );
                  }
                  ,child: Text(
                  'skip',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF353535),
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
}