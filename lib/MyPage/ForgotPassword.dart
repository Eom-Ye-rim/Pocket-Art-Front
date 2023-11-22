import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: ForgotPassword(),
    debugShowCheckedModeBanner: false,
  ));
}

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            backgroundColor: Colors.white,
            elevation: 6,
            shadowColor: Color.fromRGBO(60,98,221,0.3),
            leadingWidth: 80,


            leading:IconButton(
              icon: Icon(Icons.arrow_back_ios,
                color: Colors.black,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            title: Text(
              '비밀번호 찾기',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'SUIT Variable',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),


          ),
          body:Center(
            child: Container(
              color: Colors.white,
              child: Container(
                width: 390,
                padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: Column(
                  children: [

                    SizedBox(height: 40,),

                    Row(
                      children: [
                        Container(
                          width: 256,
                          height: 66,
                          child: TextFormField(
                            // TextFormField의 속성들을 설정하세요.
                            decoration: InputDecoration(
                              hintText: '이메일을 입력하세요',
                              // 다른 필요한 데코레이션 옵션들을 추가하세요.
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: () {
                            // 인증번호 전송 버튼
                            print('인증번호 전송');
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('인증번호 전송 완료'),
                                  content: Text('인증번호가 성공적으로 전송되었습니다.'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('확인',
                                        style: TextStyle(
                                          color: Color(0xFF3C62DD),
                                          fontSize: 15,
                                          fontFamily: 'SUIT',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop(); // 팝업창을 닫습니다.
                                      },
                                    ),
                                  ],
                                );
                              },
                            );

                          },
                          child: Container(
                            width: 83,
                            height: 30,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 1, color: Color(0xFF3C62DD)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '인증번호 전송',
                                style: TextStyle(
                                  color: Color(0xFF3C62DD),
                                  fontSize: 12,
                                  fontFamily: 'SUIT',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ),



                      ],
                    ),

                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Container(
                          width: 256,
                          height: 66,
                          child: TextFormField(
                            // TextFormField의 속성들을 설정하세요.
                            decoration: InputDecoration(
                              hintText: '인증번호를 입력하세요',
                              // 다른 필요한 데코레이션 옵션들을 추가하세요.
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: () {
                            // 인증번호 확인 버튼
                            print('인증번호 확인');
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('인증번호 확인'),
                                  content: Text('(여기에 들어갈 텍스트 정해서 넣어주세요) '),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('확인',
                                        style: TextStyle(
                                          color: Color(0xFF3C62DD),
                                          fontSize: 15,
                                          fontFamily: 'SUIT',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop(); // 팝업창을 닫습니다.
                                      },
                                    ),
                                  ],
                                );
                              },
                            );

                          },
                          child: Container(
                            width: 83,
                            height: 30,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 1, color: Color(0xFF3C62DD)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '확인',
                                style: TextStyle(
                                  color: Color(0xFF3C62DD),
                                  fontSize: 12,
                                  fontFamily: 'SUIT',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ),



                      ],
                    ),

                    SizedBox(height: 45,),


                    Container(
                      child: FilledButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF363636),
                          ),
                        ),
                        onPressed: () {
                          //버틍 동작 코드
                        },
                        child: Center(
                          child: Text(
                            '버튼 이름 정해주세요',
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
          ) ,
        )

    );
  }
}
