
import 'package:flutter/material.dart';
import 'package:flutter_ar_example/mainpage/MainPage.dart';
import 'package:flutter_ar_example/splash/FirstSplash.dart';
import 'package:flutter_ar_example/user/LoginMain.dart';
import 'package:video_player/video_player.dart';

import 'MyPage/ForgotPassword.dart';
import 'MyPage/MyPage.dart';
import 'Chatbot.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _MyApp(),
    );
  }
}

class _MyApp extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<_MyApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('images/updatemotion.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown and set the state when the video is initialized.
        setState(() {
          print('Video initialized successfully');
          _controller.play(); // 자동으로 영상 재생 시작
        });
      });
    // Add a listener to detect when the video playback is completed
    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>FirstSplash()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : CircularProgressIndicator(), // Show a loading indicator while the video is initializing.
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}




// import 'dart:js';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_ar_example/user/signupcode.dart';
// import 'package:flutter_web_auth/flutter_web_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:http/http.dart' as http;
// import 'package:dio/dio.dart';
//
// import 'user/email.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatelessWidget {
//   Future<void> _loginWithGoogle() async {
//     //clientId 하드 코딩 말고 다른 파일로 빼기
//     final GoogleSignIn _googleSignIn =GoogleSignIn(clientId: '254832965764-f943aleetqt0vcvndtidlj4j1d20h6h4.apps.googleusercontent.com');
//     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//
//     if (googleUser == null) {
//       // 로그인 취소한 경우 또는 오류가 발생한 경우
//       print('Google 로그인 취소 또는 오류');
//     } else {
//       // 로그인  성공
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//       // 구글 accessToken 출력
//       final String? accessToken = googleAuth.accessToken;
//
//       if (accessToken != null) {
//         final dio = Dio();
//         final response = await dio.post(
//             'http://ec2-15-164-7-100.ap-northeast-2.compute.amazonaws.com:8080/users/login?access_token=$accessToken');
//
//         if (response.statusCode == 200) {
//           // 액세스 토큰 출력
//           //이거 전역 변수로 따로 저장하는게 편함
//           print(response.headers['authorization']);
//         }
//       }
//     }
//     // final oauthUrl = "http://ec2-15-164-7-100.ap-northeast-2.compute.amazonaws.com:8080/oauth2/authorization/google?"
//     //     "client_id=969542110950-o4f05po4gpihkrrjf6vpofnoi7log0og.apps.googleusercontent.com"
//     //     "&redirect_uri=http://ec2-15-164-7-100.ap-northeast-2.compute.amazonaws.com:8080/login/oauth2/code/google"
//     //     "&response_type=code&scope=email";
//     // try {
//     //   final result = await FlutterWebAuth.authenticate(
//     //       url: oauthUrl,
//     //       callbackUrlScheme: "myapp");
//     //   debugPrint("OAuth 성공 : $result");
//     //   debugPrint(result);
//     // } catch (e) {
//     //   debugPrint("OAuth 오류: $e");
//     // }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google OAuth Login'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _loginWithGoogle,
//           child: Text('Google 로그인'),
//         ),
//       ),
//     );
//   }
// }



//
//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_ar_example/mainpage/MainPage.dart';
// import 'package:flutter_ar_example/user/signupcode.dart';
// import 'package:flutter_web_auth/flutter_web_auth.dart';
// import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../Chatbot.dart';
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
//                   color: Color(0xEA1567F6),
//                 ),
//                 child: TextButton(
//                   onPressed: () async {
//                     print("click");
//                     final url = Uri.parse(
//                         'http://52.78.214.57:8080/login');
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
//                         print(response);
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
//             // Positioned(
//             //   left: 94,
//             //   top: 709,
//             //   child: Container(
//             //     width: 320,
//             //     height: 57,
//             //
//             //     child: Column(
//             //       crossAxisAlignment: CrossAxisAlignment.start,
//             //       children: [
//             //         Container(
//             //           width: double.infinity,
//             //           child: Row(
//             //             children: [
//             //               Text(
//             //                 "SNS 계정으로 간편하게 로그인하세요.",
//             //                 style: TextStyle(
//             //                   color: Color(0xff000000),
//             //                   fontSize: 14,
//             //                 ),
//             //               ),
//             //             ],
//             //           ),
//             //         ),
//             //       ],
//             //     ),
//             //   ),
//             // ),
//             //
//             //
//             // Positioned(
//             //   left: 110,
//             //   top: 740,
//             //   child: Container(
//             //     width: 400,
//             //     height: 57,
//             //     child: Column(
//             //
//             //       children: [
//             //         Container(
//             //           width: 400,
//             //           child: Row(
//             //             children: [
//             //               ElevatedButton(
//             //                 onPressed: () {
//             //                 },
//             //                 style: ElevatedButton.styleFrom(
//             //                   elevation: 0,
//             //                   padding: EdgeInsets.zero,
//             //                 ),
//             //                 child: ClipRRect(
//             //                   borderRadius: BorderRadius.circular(2), // 모서리 굴곡 설정
//             //                   child: Image.asset(
//             //                     'images/kakao_login_medium_narrow.png', // 이미지 경로 및 파일명으로 수정하세요.
//             //                   ),
//             //                 ),
//             //               ),
//             //
//             //             ],
//             //           ),
//             //         ),
//             //       ],
//             //     ),
//             //   ),
//             // ),
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
//
// Future<void> signIn() async {
//
//   // 고유한 redirect uri
//   const APP_REDIRECT_URI = "http://ec2-15-164-7-100.ap-northeast-2.compute.amazonaws.com:8080/oauth2/authorization/google";
//
//   // 백엔드에서 미리 작성된 API 호출
//   final url = Uri.parse('http://ec2-15-164-7-100.ap-northeast-2.compute.amazonaws.com:8080/oauth2/authorization/googl');
//
//   // 백엔드가 제공한 로그인 페이지에서 로그인 후 callback 데이터 반환
//   final result = await FlutterWebAuth.authenticate(
//       url: url.toString(), callbackUrlScheme: APP_REDIRECT_URI);
//
//   // 백엔드에서 redirect한 callback 데이터 파싱
//   // final accessToken = Uri.parse(result).queryParameters['access-token'];
//   // final refreshToken = Uri.parse(result).queryParameters['refresh-token'];
//
//   // . . .
//   // FlutterSecureStorage 또는 SharedPreferences 를 통한
//   // Token 저장 및 관리
//   // . . .
//
// }

