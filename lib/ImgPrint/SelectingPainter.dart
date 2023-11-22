import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_ar_example/ImgPrint/ImgDownload.dart';
import '../mainpage/MainPage.dart';
import 'package:http/http.dart' as http;

class SelectingPainter extends StatefulWidget {
  File selectImg;
  String type;
  SelectingPainter({super.key, required this.selectImg, required this.type});

  @override
  State<SelectingPainter> createState() => _SelectingPainterState();
}

class _SelectingPainterState extends State<SelectingPainter> {//갤러리 다운로드 관련

  File ? imgURL ;
  String StyleType="";
  String model="";

  @override
  void initState() {
    super.initState();
    imgURL = widget.selectImg;
    StyleType=widget.type;
  }

  final Dio dio = Dio();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, // 디버그 리본 없애기
        home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage('images/img_22.png'))),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark,
                  statusBarBrightness: Brightness.light,
                ),
                leadingWidth: 113,
                toolbarHeight: 66,
                leading: gotoMainBtn(),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.all(17),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                        '변환하고 싶은 화가의\n화풍을 선택해주세요.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: 'SUIT',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 46,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            model="gogh";
                          });
                        },
                        child: Container(
                          width: 328,
                          height: 96,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              border: Border.all(
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                width: 2,
                              )),
                          child: Row(
                            children: [
                              Container(
                                width: 114,
                                height: 96,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                        AssetImage('images/img_23.png'))),
                              ),
                              SizedBox(
                                width: 35,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    '빈센트 반고흐',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'SUIT',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Vincent van Gogh 1853-1890 ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF828282),
                                      fontSize: 10,
                                      fontFamily: 'SUIT',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 19,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            model="cezanne";
                          });
                          print('폴 세잔느');
                        },
                        child: Container(
                          width: 328,
                          height: 96,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              border: Border.all(
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                width: 2,
                              )),
                          child: Row(
                            children: [
                              Container(
                                width: 114,
                                height: 96,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                        AssetImage('images/img_24.png'))),
                              ),
                              SizedBox(
                                width: 35,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    '폴 세잔느',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'SUIT',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Paul Cézanne, 1839-1906 ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF828282),
                                      fontSize: 10,
                                      fontFamily: 'SUIT',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 19,
                      ),
                      InkWell(

                          onTap: () {
                            setState(() {
                              model="monet";
                            });
                          },
                        child: Container(
                          width: 328,
                          height: 96,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              border: Border.all(
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                width: 2,
                              )),
                          child: Row(
                            children: [
                              Container(
                                width: 114,
                                height: 96,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                        AssetImage('images/img_25.png'))),
                              ),
                              SizedBox(
                                width: 35,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    '클로드 모네',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'SUIT',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Claude Monet, 1840-1926 ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF828282),
                                      fontSize: 10,
                                      fontFamily: 'SUIT',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 19,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            model="edgar";
                          });
                        },
                        child: Container(
                          width: 328,
                          height: 96,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              border: Border.all(
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                                width: 2,
                              )),
                          child: Row(
                            children: [
                              Container(
                                width: 114,
                                height: 96,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage('images/ed.png'))),
                              ),
                              SizedBox(
                                width: 35,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    '에드가 드가',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'SUIT',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Edgar Degas 1834-1917 ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF828282),
                                      fontSize: 10,
                                      fontFamily: 'SUIT',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),

                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 38,),

                      Container(
                          height: 56, width: 356,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32.5),
                            color: Color(0xff363636), // 배경 색상
                          ),
                          child: FilledButton(
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(
                                  Colors.transparent),
                            ),
                            onPressed: () async {
                                String serverUrl="";
                                if(StyleType=="east") {
                                  serverUrl = 'http://54.180.79.174:8080/api/v1/image?modelname=east';
                                }
                                else if(model=="monet"){
                                  serverUrl = 'http://54.180.79.174:8080/api/v1/image?modelname=monet';
                                }
                                else if(model=="edgar"){
                                   serverUrl = 'http://54.180.79.174:8080/api/v1/image?modelname=edgar';
                                    }
                                else if(model=="cezanne"){
                                     serverUrl = 'http://54.180.79.174:8080/api/v1/image?modelname=cezanne';
                                    }
                                else if(model=="gogh"){
                                  serverUrl = 'http://54.180.79.174:8080/api/v1/image?modelname=gogh';
                                }
    // Replace 'imgPath' with the actual file path of the image from the gallery.
                                final imgPath = imgURL; // Replace with the actual image path
                                String files = imgPath!.path.split('/').last;
                                print(imgPath);
                                print(files);
                                try {
                                  FormData formData = FormData.fromMap({
                                    'file': await MultipartFile.fromFile(imgPath!.path, filename: files),
                                  });
                                  ;

                                  final response = await dio.post(
                                    serverUrl,
                                    data: formData,
                                    options: Options(
                                      headers: {
                                        'Content-Type': 'multipart/form-data',
                                      },
                                    ),
                                  );
                                  if (response.statusCode == 200) {
                                    // Successful response from the server
                                    print('Image sent successfully');
                                    print(response.data);
                                    print(response.data['url']);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ImgDownload(selectImg:imgURL,imageUrl:response.data['url']
                                      )),
                                    );
                                  } else {
                                    // Handle errors
                                    print('Error sending image: ${response.statusCode}');
                                    print('Error response: ${response.data}');
                                  }
                                } catch (e) {
                                  // Handle network errors
                                  print('Network error: $e');
                                }
                              },

                            child: Text('다음',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'SUIT',
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center),
                          )

                      )

                    ],
                  ),
                ),
              )),
        ));
  }
}

class gotoMainBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MainPage()),
              );
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
          ),
          width: 25,
          height: 40,
        ),
        Container(
          child: Text('Art Transfer',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'SUIT',
                fontWeight: FontWeight.w600,
              )),
          width: 87,
          height: 18,
          decoration: ShapeDecoration(
            color: Color(0xFF4065DE),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ],
    );
  }
}
