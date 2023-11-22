
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar_example/mainpage/MainPage.dart';
import 'package:flutter_ar_example/user/signupcode.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Chatbot.dart';

void main() {
  KakaoSdk.init(nativeAppKey:'077a09d06719ae6dd518a8049399d4a0');
  runApp(const LoginMain());
}

class LoginMain extends StatelessWidget {
  const LoginMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const FirstRoute(),
    );
  }
}

class FirstRoute extends StatefulWidget {
  const FirstRoute({Key? key}) : super(key: key);

  @override
  _FirstRouteState createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  String email='';
  String password='';

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.topLeft,
                child: Opacity(
                  opacity: 1,
                  child: Container(
                    width: 536,
                    height: 1050,
                    child: Stack(
                      children: [],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 44,
              top: 332,
              child: Container(
                width: 320,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 57,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffb3b3b3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 309,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 309,
                                        child: TextField(
                                          onChanged: (value) {
                                            setState(() {
                                              email = value;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            hintText: "이메일 주소 입력",
                                            hintStyle: TextStyle(
                                              color: Color(0xffb3b3b3),
                                              fontSize: 14,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                          style: TextStyle(
                                            color: Color(0xff121319),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
              left: 44,
              top: 405,
              child: Container(
                width: 320,
                height: 57,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffb3b3b3),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 309,
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        password = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: "비밀번호 입력",
                                      hintStyle: TextStyle(
                                        color: Color(0xffb3b3b3),
                                        fontSize: 14,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      color: Color(0xffb3b3b3),
                                      fontSize: 14,
                                    ),
                                    obscureText: true,
                                  ),
                                ),
                              ],
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
              left: 30,
              top: 455,
              child: Container(
                width: 320,
                height: 57,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Checkbox(
                            value: _isChecked,
                            onChanged: (value) {
                              setState(() {
                                _isChecked = value!;
                              });
                            },
                          ),
                          Text(
                            "로그인 상태 유지",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 11,
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
              left: 47,
              top: 520,

              child: Container(
                width: 320,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xEA1567F6),
                ),
                child: TextButton(
                  onPressed: () async {
                    print("click");
                    final url = Uri.parse(
                        'http://54.180.79.174:8080/login');
                    Map<String, dynamic> data = {
                      'email': email,
                      'password': password,
                    };
                    String jsonData = json.encode(data);
                    print(jsonData);
                    try {
                      final response = await http.post(
                        url,
                        headers: {'Content-Type': 'application/json'},
                        // Set the request header
                        body: jsonData, // Set the JSON data as the request body
                      );
                      print(response);
                      print(response.statusCode);

                      if (response.statusCode == 200) {
                        print(response);
                        var responseData = json.decode(response.body);
                        var accessToken = responseData['data']['accessToken'];
                        print(accessToken);

                       // shared_preferences를 사용하여 accessToken 안전하게 저장
                        SharedPreferences prefs = await SharedPreferences
                            .getInstance();
                        await prefs.setString('accessToken', accessToken);
                        Navigator.push(
                          context,
                          //PhotoBoard
                          MaterialPageRoute(builder: (context) => MainPage()),
                        );

                        // Request successful
                        print('Data sent successfully.');
                      } else {
                        // Request failed
                        print('Failed to send data. Status code: ${response
                            .statusCode}');
                      }
                    } catch (e) {
                      // Handle any exceptions that might occur during the API call
                      print('Error: $e');
                    }
                  },

                  child: Text(
                    "로그인",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              left: 88,
              top: 575,
              child: Container(
                width: 320,
                height: 57,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Text(
                            "이메일 찾기",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 11,
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
              left: 156,
              top: 575,
              child: Container(
                width: 320,
                height: 57,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Text(
                            "|",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 11,
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
              left: 171,
              top: 575,
              child: Container(
                width: 320,
                height: 57,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Text(
                            "비밀번호 찾기",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 11,
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
              left: 88,
              top: 575,
              child: Container(
                width: 320,
                height: 57,

                child: Column(

                  children: [
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Text(
                            "이메일 찾기",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 11,
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
              left: 251,
              top: 575,
              child: Container(
                width: 320,
                height: 57,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Text(
                            "|",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 11,
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
              left: 270,
              top: 575,
              child: GestureDetector(
                onTap: () {
                  // Handle the sign-up button tap
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ThirdRoute()),
                  );
                },
                child: Container(
                  width: 320,
                  height: 57,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Text(
                              "회원가입",
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Positioned(
            //   left: 94,
            //   top: 709,
            //   child: Container(
            //     width: 320,
            //     height: 57,
            //
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Container(
            //           width: double.infinity,
            //           child: Row(
            //             children: [
            //               Text(
            //                 "SNS 계정으로 간편하게 로그인하세요.",
            //                 style: TextStyle(
            //                   color: Color(0xff000000),
            //                   fontSize: 14,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            //
            //
            // Positioned(
            //   left: 110,
            //   top: 740,
            //   child: Container(
            //     width: 400,
            //     height: 57,
            //     child: Column(
            //
            //       children: [
            //         Container(
            //           width: 400,
            //           child: Row(
            //             children: [
            //               ElevatedButton(
            //                 onPressed: () {
            //                 },
            //                 style: ElevatedButton.styleFrom(
            //                   elevation: 0,
            //                   padding: EdgeInsets.zero,
            //                 ),
            //                 child: ClipRRect(
            //                   borderRadius: BorderRadius.circular(2), // 모서리 굴곡 설정
            //                   child: Image.asset(
            //                     'images/kakao_login_medium_narrow.png', // 이미지 경로 및 파일명으로 수정하세요.
            //                   ),
            //                 ),
            //               ),
            //
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),


            Positioned(
              left: 56,
              top: 202,
              child: Container(
                width: 284,
                height: 67,
                child: Image.asset('images/logos.png', width: 67),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 414,
                  height: 49,
                  padding: const EdgeInsets.only(
                    left: 33,
                    right: 15,
                    bottom: 20,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 28.43,
                        height: 11.09,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xff121319),
                        ),
                      ),
                      SizedBox(width: 25.89),
                      Container(
                        width: 66.66,
                        height: 11.34,
                        child: Stack(
                          children: [
                            Container(
                              width: 24.33,
                              height: 11.33,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: FlutterLogo(
                                size: 11.333333015441895,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 37,
              top: 510,
              child: Container(
                width: 333,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> signIn() async {

  // 고유한 redirect uri
  const APP_REDIRECT_URI = "http://ec2-15-164-7-100.ap-northeast-2.compute.amazonaws.com:8080/oauth2/authorization/google";

  // 백엔드에서 미리 작성된 API 호출
  final url = Uri.parse('http://ec2-15-164-7-100.ap-northeast-2.compute.amazonaws.com:8080/oauth2/authorization/googl');

  // 백엔드가 제공한 로그인 페이지에서 로그인 후 callback 데이터 반환
  final result = await FlutterWebAuth.authenticate(
      url: url.toString(), callbackUrlScheme: APP_REDIRECT_URI);

  // 백엔드에서 redirect한 callback 데이터 파싱
  // final accessToken = Uri.parse(result).queryParameters['access-token'];
  // final refreshToken = Uri.parse(result).queryParameters['refresh-token'];

  // . . .
  // FlutterSecureStorage 또는 SharedPreferences 를 통한
  // Token 저장 및 관리
  // . . .

}