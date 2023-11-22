import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar_example/user/signup.dart';
import 'package:http/http.dart' as http;

class emailRoute extends StatelessWidget {
  final String? enteredEmail;
  // final String? responseBody;

  const emailRoute({Key? key, required this.enteredEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ManipulationPage(enteredEmail: enteredEmail),
    );
  }
}

class ManipulationPage extends StatefulWidget {
  final String? enteredEmail;
  // final String? responseBody;

  const ManipulationPage({Key? key, this.enteredEmail}) : super(key: key);

  @override
  _ManipulationPageState createState() => _ManipulationPageState();
}

class _ManipulationPageState extends State<ManipulationPage> {
  List<String> enteredNumbers = ['', '', '', ''];

  void updateNumber(int index, String number) {
    setState(() {
      if (number.length > 1) {
        number = number.substring(0, 1); // Limit input to a single character
      }
      enteredNumbers[index] = number;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            automaticallyImplyLeading: true,

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
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(6.0),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey.withOpacity(0.3),
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff3C62DD)),
                value: 0.50,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 80),
                Text(
                  "이메일로 발송된\n인증번호를 입력해주세요.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff3e3e3e),
                    fontSize: 30,
                    fontFamily: "SUIT",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(),
                Text(
                  "메일함을 확인해 인증번호를 입력해주세요.",
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
                    children: [
                      Positioned(
                        left: 18,
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
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 220,
                        height: 220,
                        child: Stack(
                          children: [
                            Container(
                              width: 220,
                              height: 220,
                            ),
                            Image(
                              image: AssetImage('images/EmailG.png'),
                              width: 240.53,
                              height: 225.87,
                              fit: BoxFit.fill,
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 120.2,
                                  height: 119.54,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
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
                SizedBox(height: 5.3),
                Container(
                  width: 360,
                  height: 28,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 22,
                        child: FutureBuilder<bool>(
                          future: handleNextButton(),
                          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              // While the future is resolving, show a loading indicator or return a placeholder widget
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // Handle any error that occurred during the future resolution
                              return Text("Error: ${snapshot.error}");
                            } else {
                              bool isSuccess = snapshot.data ?? false;

                              return Text(

                                isSuccess
                                    ? "*인증번호가 발송되지 않았을 시 스팸메일함도 확인해주세요."
                                    :" *인증 번호를 다시 입력해주세요." ,
                                style: TextStyle(
                                  color: Color(0xff454444),
                                  fontSize: 12,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 45,
                  top: 608,
                  child: Container(
                    width: 324,
                    height: 66,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 66,
                            height: 66,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide.none,
                              ),
                            ),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  enteredNumbers[0] = value;
                                });
                              },
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 86,
                          top: 0,
                          child: Container(
                            width: 66,
                            height: 66,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide.none,
                              ),
                            ),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  enteredNumbers[1] = value;
                                });
                              },
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 172,
                          top: 0,
                          child: Container(
                            width: 66,
                            height: 66,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide.none,
                              ),
                            ),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  enteredNumbers[2] = value;
                                });
                              },
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 258,
                          top: 0,
                          child: Container(
                            width: 66,
                            height: 66,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide.none,
                              ),
                            ),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  enteredNumbers[3] = value;
                                });
                              },
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 0),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF363636),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.50),
                      ),
                    ),
                    onPressed: () async {
                      String? enteredEmail=widget.enteredEmail;
                      bool isSuccess = await handleNextButton();
                      if (isSuccess) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupRoute(enteredEmail:enteredEmail)),
                        );
                      } else {
                        // Handle the case where the validation fails
                      }
                    },
                    child: Text(
                      '다음',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'SUIT',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  width: 356,
                  height: 56,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> handleNextButton() async {
    var string = enteredNumbers.join(",");
    var enteredEmail=widget.enteredEmail;
    var number = string.replaceAll(',', '');
    bool isSuccess = false;
    // String? responseBody = widget.responseBody;

    // Validate if the number is entered or not
    if (enteredNumbers.isEmpty) {
      return isSuccess;
    }
    final url = Uri.parse(
        'http://54.180.79.174:8080/verifyCode?email=$enteredEmail&code=$number');
    print(url);
    final response = await http.post(url);
    print(response.statusCode);
    try {
      if (response.statusCode==200) {
        print("성공");
        isSuccess = true;

      } else {
      }
    } catch (e) {

    }

      return isSuccess;
    }
  }


