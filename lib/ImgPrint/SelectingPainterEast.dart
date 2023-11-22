import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_ar_example/ImgPrint/ImgDownload.dart';
import '../mainpage/MainPage.dart';
import 'package:http/http.dart' as http;

class SelectingPainterEast extends StatefulWidget {
  File selectImg;
  String type;
  SelectingPainterEast({super.key, required this.selectImg, required this.type});

  @override
  State<SelectingPainterEast> createState() => _SelectingPainterState();
}

class _SelectingPainterState extends State<SelectingPainterEast> {//갤러리 다운로드 관련

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
                        '변환하고 싶은 동양의\n화풍을 선택해주세요.',
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
                            model="east1";
                          });
                          print('동양화');
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
                                        AssetImage('images/1.png'))),
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
                                    '동양풍',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'SUIT',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                   '동양의 전통적인 화풍',
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
                            model="east2";
                          });
                          print('수묵화');
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
                                        AssetImage('images/east2.png'))),
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
                                    '수묵화',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'SUIT',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '동양의 미를 느낄 수 있는 수묵화',
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
                              if(model=="east1") {
                                print("동양화 API 호출");
                                serverUrl = 'http://54.180.79.174:8080/api/v1/image?modelname=east1';
                              }
                              else if(model=="east2"){
                                print("수묵화 API 호출");
                                serverUrl = 'http://54.180.79.174:8080/api/v1/image?modelname=east2';
                              }
                              // Replace 'imgPath' with the actual file path of the image from the gallery.
                              final imgPath = imgURL; // Replace with the actual image path
                              String files = imgPath!.path.split('/').last;

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
                                // print(pixelData);
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
                                  //   Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => ImgDownload()),
                                  //   );
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
