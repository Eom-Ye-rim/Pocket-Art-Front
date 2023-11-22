import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar_example/user/email.dart';
import 'package:http/http.dart' as http;

class ThirdRoute extends StatelessWidget {
  const ThirdRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: ManipulationPage(),

    );
  }
}
class ManipulationPage extends StatefulWidget {
  @override
  _ManipulationPageState createState() => _ManipulationPageState();
}
class _ManipulationPageState extends State<ManipulationPage> {
  String enteredEmail = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 리본 없애기

      home: Container(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(//status bar 색 변경 -black
              statusBarIconBrightness: Brightness.dark, //<-- 안드로이드 설정
              statusBarBrightness: Brightness.light, //<-- ios설정
            ),
            automaticallyImplyLeading: true, // 하위페이지 생기면 뒤로가기 버튼 생성

            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,
                color: Colors.black,),
              onPressed: () {
                //뒤로가기
                Navigator.pop(context);
              },
            ),
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
                valueColor:new AlwaysStoppedAnimation<Color>(Color(0xff3C62DD)),
                value: 0.25,),// value값 조정
            ),

            backgroundColor: Colors.transparent, // 투명으로 해도 appBar 자체 그림자 생김
            elevation: 0.0, // appBar 그림자 0.0 해주면 완전 투명됨
          ),
    body: SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 80),
            Text(
              "이메일 인증을 진행해주세요.",
              style: TextStyle(
                color: Color(0xff3e3e3e),
                fontSize: 30,
                fontFamily: "SUIT",
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(),
            Text(
              "인증번호를 받을 수 있는 유효한 메일주소를 적어주세요.",
              style: TextStyle(
                color: Color(0xff9d9d9d),
                fontSize: 14,
                fontFamily: "SUIT",
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 22.50),
            Container(
              width: 220,
              height: 220,
              child: Stack(
                children: [Positioned(
                  left: 20,
                  top: 8.80,
                  child: Container(
                    width: 189.20,
                    height: 211.20,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 17.60,
                          height: 17.60,

                        ),
                        // SizedBox(height: 81.40),
                        // Container(
                        // width: 11,
                        // height: 11,
                        // decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        // color: Color(0xff546fff),
                        // ),
                        // ),
                        // SizedBox(height: 81.40),
                        // Container(
                        // width: 19.80,
                        // height: 19.80,
                        // decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        // color: Color(0xff546fff),
                        // ),
                        // ),
                      ],
                    ),
                  ),
                ),
                  Container(
                    width: 220,
                    height: 220,
                    child: Stack(

                      children: [Container(
                        width: 220,
                        height: 220,

                      ),
                        Image(
                          image: AssetImage('images/keys.jpg'),
                          width: 221.2,
                          height: 220,
                          fit: BoxFit.cover, // 이미지를 컨테이너에 맞게 조절
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 120.2,
                              height: 119.54,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 112.20,
                                    height: 119.54,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),

                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 22.50),

              Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
              width: 370,
              height: 60,
              decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFB3B3B3), width: 1),
              color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '이메일 주소 입력',
                        hintStyle: TextStyle(
                          color: Color(0xFF6A6A6A),
                          fontSize: 13,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Color(0xFF6A6A6A),
                        fontSize: 13,
                      ),
                      // Add your logic to handle the entered email address here
                      onChanged: (value) {
                        setState(() {
                          enteredEmail = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
              ),
              ),

            SizedBox(height: 5.3),
            Container(
              width: 360, height: 28,

              // child: FlutterLogo(size: 17),
              child: Stack(
                children: [
                  Positioned(
                    left: 4,
                    bottom: 12,
                    child: Image(
                      image: AssetImage('images/alert.png'),
                    ),
                  ),
                  Positioned(
                    left: 22, // 이미지 오른쪽에 텍스트를 배치하기 위해 left 속성 조정
                    child:
                    Text(
                      "인증메일은 1시간 이내에 완료해주세요.",
                      style: TextStyle(
                        color: Color(0xff454444),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Text(
            // "인증메일은 1시간 이내에 완료해주세요.",
            // style: TextStyle(
            // color: Color(0xff454444),
            // fontSize: 12,
            // ),
            // ),
            SizedBox(height: 0),
            Text(
              "다음",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: "SUIT",
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: FilledButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF363636),),
                ),
                onPressed: handleNextButton,
                child: Center(
                  child: Text(
                    '다음',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'SUIT',
                      fontWeight:FontWeight.w700,
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


        ]),
      ),
    )
    ));
  }


  void handleNextButton() async {
    if (enteredEmail.isEmpty) {
      return; // You can display an error message or handle the case where the email is not entered
    }
    else {
      // Construct the URL with the entered email value


      try {
        print(enteredEmail);
        final url = Uri.parse(
            'http://54.180.79.174:8080/emailConfirm?email=$enteredEmail');
        final response = http.post(url);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  emailRoute(
                      enteredEmail: enteredEmail),));
        // Handle the response if needed
        // if (response.body != null) {
        //   // Successful response from the server
        //   // Do something with the response data
        //
        //   // Pass the response body to the emailRoute
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) =>
        //           emailRoute(
        //               enteredEmail: enteredEmail, responseBody: response.body),
        //     ),
        //   );
        // } else {
        //   // Error response from the server
        //   // Handle the error case
        // }
      } catch (e) {
        // Error occurred during the HTTP request
        // Handle the error case
      }
    }
  }
  // void handleNextButton() async {
  //   if (enteredEmail != null) {
  //     //code값을 같이 전달해줌
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => emailRoute(enteredEmail: enteredEmail)),
  //     );
  //   } else {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => emailRoute(enteredEmail: '',)),
  //     );
  //   }
  //   if (enteredEmail.isEmpty) {
  //     return; // You can display an error message or handle the case where the email is not entered
  //   }
  //
  //   // Construct the URL with the entered email value
  //   final url = Uri.parse(
  //       'http://localhost:8080/emailConfirm?email=$enteredEmail');
  //
  //   try {
  //     // Send a POST request to the server
  //     final response = await http.post(url);
  //
  //     // Handle the response if needed
  //     if (response.body == 200) {
  //       // Successful response from the server
  //       // Do something with the response data
  //     } else {
  //       // Error response from the server
  //       // Handle the error case
  //     }
  //   } catch (e) {
  //     // Error occurred during the HTTP request
  //     // Handle the error case
  //   }
  // }
  }






//   void handleNextButton() async {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => emailRoute()),
//     );
//     // Validate if the email is entered or not
//     if (enteredEmail.isEmpty) {
//       return; // You can display an error message or handle the case where the email is not entered
//     }
//
//     // Construct the URL with the entered email value
//     final url = Uri.parse(
//         'http://localhost:8080/emailConfirm?email=$enteredEmail');
//
//     try {
//       // Send a POST request to the server
//       final response = await http.post(url);
//
//       // Handle the response if needed
//       if (response.statusCode == 200) {
//         // Successful response from the server
//         // Do something with the response data
//       } else {
//         // Error response from the server
//         // Handle the error case
//       }
//     } catch (e) {
//       // Error occurred during the HTTP request
//       // Handle the error case
//     }
//   }
// }



