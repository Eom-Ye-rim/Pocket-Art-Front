
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar_example/mainpage/MainPage.dart';
import 'package:flutter_ar_example/user/signupcode.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

                  color: Color(0xFF015EFA),
                ),
                // padding: const EdgeInsets.only(
                //   left: 32,
                //   right: 39,
                //   top: 15,
                //   bottom: 20,
                // ),
                child: TextButton(
                  //

                  onPressed: () async {
                    print("click");
                    final url = Uri.parse(
                        'http://13.209.160.87:8080/login');
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


    //
    // if (await isKakaoTalkInstalled()) {
    //                     try {
    //                       await UserApi.instance.loginWithKakaoTalk();
    //                       print('카카오톡으로 로그인 성공');
    //                     } catch (error) {
    //                       print('카카오톡으로 로그인 실패 $error');
    //
    //                       // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
    //                       // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
    //                       if (error is PlatformException && error.code == 'CANCELED') {
    //                         return;
    //                       }
    //                       // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
    //                       try {
    //                         await UserApi.instance.loginWithKakaoAccount();
    //                         print('카카오계정으로 로그인 성공');
    //                       } catch (error) {
    //                         print('카카오계정으로 로그인 실패 $error');
    //                       }
    //                     }
    //                   } else {
    //                     try {
    //                       await UserApi.instance.loginWithKakaoAccount();
    //                       print('카카오계정으로 로그인 성공');
    //                     } catch (error) {
    //                       print('카카오계정으로 로그인 실패 $error');
    //                     }
    //                   }
    //
    //               },
    //               onPressed: () async {
    //                 final url =
    //                     'https://kauth.kakao.com/oauth/authorize?client_id=179011b75542e1a21fa2207d50a4df57&redirect_uri=http://localhost:8080/auth/kakao/callback&response_type=code';
    //                 if (await canLaunch(url)) {
    //                   await launch(url);
    //                 } else {
    //                   throw 'Could not launch $url';
    //                 }
    //               },

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

            Positioned(
              left: 94,
              top: 709,
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
                            "SNS 계정으로 간편하게 로그인하세요.",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 14,
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
              left: 110,
              top: 740,
              child: Container(
                width: 400,
                height: 57,
                child: Column(

                  children: [
                    Container(
                      width: 400,
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              padding: EdgeInsets.zero,
                            ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2), // 모서리 굴곡 설정
                    child: Image.asset(
                      'images/kakao_login_medium_narrow.png', // 이미지 경로 및 파일명으로 수정하세요.
                    ),
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