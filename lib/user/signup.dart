import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar_example/ai/aiText.dart';
import 'package:http/http.dart' as http;

class SignupRoute extends StatelessWidget {
  final String? enteredEmail;
  const SignupRoute({Key? key,required this.enteredEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: ManipulationPage(enteredEmail:enteredEmail),
    );
  }
}

class ManipulationPage extends StatefulWidget {
  final String? enteredEmail;


  const ManipulationPage({Key? key, this.enteredEmail}) : super(key: key);
  @override
  _ManipulationPageState createState() => _ManipulationPageState();
}

class _ManipulationPageState extends State<ManipulationPage> {
  String password = '';

  String name = '';
  String passwordConfirm = '';

  String? email = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false, // 디버그 리본 없애기

      home: Container(

        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle( //status bar 색 변경 -black
              statusBarIconBrightness: Brightness.dark, //<-- 안드로이드 설정
              statusBarBrightness: Brightness.light, //<-- ios설정
            ),
            automaticallyImplyLeading: true,
            // 하위페이지 생기면 뒤로가기 버튼 생성

            title: Text(
              '회원가입',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'SUIT',
                fontWeight: FontWeight.w500,
              ),),
            bottom: PreferredSize( // appbar 하단 progressBar
              preferredSize: Size.fromHeight(6.0),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey.withOpacity(0.3),
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Color(0xff3C62DD)),
                value: 0.75,), // value값 조정
            ),

            backgroundColor: Colors.transparent,
            // 투명으로 해도 appBar 자체 그림자 생김
            elevation: 0.0, // appBar 그림자 0.0 해주면 완전 투명됨
          ),

          body: SingleChildScrollView(
            padding: EdgeInsets.all(29),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40,),
                Text(
                  '회원정보를 입력해주세요.',
                  style: TextStyle(
                    color: Color(0xFF3E3E3E),
                    fontSize: 30,
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '메일함을 확인해 인증번호를 입력해주세요.',
                  style: TextStyle(
                    color: Color(0xFF9D9D9D),
                    fontSize: 12,
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 12,),
                Text(
                  '아이디',
                  style: TextStyle(
                    color: Color(0xFF1C1C1C),
                    fontSize: 15,
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextFormField(
                    onChanged: (value) {
                      setState(() {
                        name =
                            value; // Update the 'name' variable when the text changes
                      });
                    },

                    decoration: InputDecoration(
                      hintText: '아이디를 입력해주세요',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    )

                ),
                SizedBox(height: 12,),
                Text(
                  '이름',
                  style: TextStyle(
                    color: Color(0xFF1C1C1C),
                    fontSize: 15,
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextFormField(
                    onChanged: (value) {
                      setState(() {
                        name =
                            value; // Update the 'name' variable when the text changes
                      });
                    },

                    decoration: InputDecoration(
                      hintText: '이름을 입력해주세요',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    )

                ),

                SizedBox(height: 22,),

                Text(
                  '이메일',
                  style: TextStyle(
                    color: Color(0xFF1C1C1C),
                    fontSize: 15,
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextFormField(

                    enabled: false,
                    decoration: InputDecoration(
                      hintText: widget.enteredEmail,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    )
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 22),
                    Text(
                      '비밀번호 입력',
                      style: TextStyle(
                        color: Color(0xFF1C1C1C),
                        fontSize: 15,
                        fontFamily: 'SUIT',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          password = value; // Update the 'password' variable when the text changes
                        });
                      },
                      obscureText: true, // This property makes the entered text obscure
                      decoration: InputDecoration(
                        hintText: '비밀번호 입력',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    SizedBox(height: 22),
                    Text(
                      '비밀번호 확인',
                      style: TextStyle(
                        color: Color(0xFF1C1C1C),
                        fontSize: 15,
                        fontFamily: 'SUIT',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          passwordConfirm = value; // Update the 'passwordConfirm' variable when the text changes
                        });
                      },
                      obscureText: true, // This property makes the entered text obscure
                      decoration: InputDecoration(
                        hintText: '비밀번호를 한 번 더 입력해주세요',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 22,),
                SizedBox(height: 0),
                Container(
                  child: FilledButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFF363636),),
                    ),
                    onPressed: () async {
                      bool isSuccess =await signup(name,password,passwordConfirm);
                      if (isSuccess){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TextRoute(),
                          ),
                        );
                      }


                    },
                    child: Center(
                      child: Text(
                        '다음',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'SUIT',
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.right,

                      ),
                    ),

                  ),

                  width: 356,
                  height: 56,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.50),
                    ),

                  ),
                ),
              ],
            ),

          ),
        ),
      ),
    );
  }
Future<bool> signup(String name, String password, String passwordConfirm)  async {
   print("호출");
   var email = widget.enteredEmail;
   bool isSuccess=false;
   final url = Uri.parse('http://13.209.160.87:8080/signUp');
   Map<String, dynamic> data = {
     'name': name,
     'password': password,
     'email':email,

   };

   String jsonData = json.encode(data);
   print(jsonData);

   try {
     final response =await http.post(
       url,
       headers: {'Content-Type': 'application/json'}, // Set the request header
       body: jsonData, // Set the JSON data as the request body
     );

     if (response.statusCode == 200) {
       isSuccess=true;
       return isSuccess;
       // Request successful
       print('Data sent successfully.');
       print(response.body); // Optionally, print the response body from the server
     } else {
       return isSuccess;

       // Request failed
       print('Failed to send data. Status code: ${response.statusCode}');
     }
   } catch (e) {
     return isSuccess;
     // Handle any exceptions that might occur during the API call
     print('Error: $e');
   }
 }
 }

// Future<bool> signup(String name, String password, String passwordConfirm)  async {
//    print("호출");
//    var email = widget.enteredEmail;
//    final url = Uri.parse('http://localhost:8080/signup');
//    Map<String, dynamic> data = {
//      'name': name,
//      'password': password,
//      'email':email,
//
//    };
//    String jsonData = json.encode(data);
//
//    try {
//      final response =await http.post(
//        url,
//        headers: {'Content-Type': 'application/json'}, // Set the request header
//        body: jsonData, // Set the JSON data as the request body
//      );
//
//      if (response.statusCode == 200) {
//        return true;
//        // Request successful
//        print('Data sent successfully.');
//        print(response.body); // Optionally, print the response body from the server
//      } else {
//        return false;
//        // Request failed
//        print('Failed to send data. Status code: ${response.statusCode}');
//      }
//    } catch (e) {
//      // Handle any exceptions that might occur during the API call
//      print('Error: $e');
//    }
//  }
//  }

//
// class btn1 extends StatelessWidget {
//
//   final String name;
//   final String password;
//   final String passwordConfirm;
//
//   btn1(this.name, this.password, this.passwordConfirm);
//      print("호출");
//      var email = widget.enteredEmail;
//      final url = Uri.parse('http://localhost:8080/signup');
//      Map<String, dynamic> data = {
//        'name': name,
//        'password': password,
//        'email':email,
//
//      };
//      String jsonData = json.encode(data);
//
//      try {
//        final response =await http.post(
//          url,
//          headers: {'Content-Type': 'application/json'}, // Set the request header
//          body: jsonData, // Set the JSON data as the request body
//        );
//
//        if (response.statusCode == 200) {
//          return true;
//          // Request successful
//          print('Data sent successfully.');
//          print(response.body); // Optionally, print the response body from the server
//        } else {
//          return false;
//          // Request failed
//          print('Failed to send data. Status code: ${response.statusCode}');
//        }
//      } catch (e) {
//        // Handle any exceptions that might occur during the API call
//        print('Error: $e');
//      }
//    }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           child: FilledButton(
//             style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF363636),),
//             ),
//             onPressed: (){
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       TextRoute(),
//                 ),
//               );
//
//     },
//             child: Center(
//               child: Text(
//                 '다음',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                   fontFamily: 'SUIT',
//                   fontWeight:FontWeight.w700,
//                 ),
//                 textAlign: TextAlign.right,
//
//               ),
//
//             ),
//
//           ),
//
//           width: 356,
//           height: 56,
//           decoration: ShapeDecoration(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(32.50),
//             ),
//
//           ),
//         ),
//       ],
//     );
//   }
// }


/**
 * 다음 버튼 클릭했을 때
 * 비밀번호 일치 여부 확인
 * 올바른 비밀 번호 형태인지 확인 (->서버에서 해줌)
 * 이름, 비밀번호, 이메일을 서버로 전송해서 회원가입 성공 / db에 잘 저장되는지 확인
 */