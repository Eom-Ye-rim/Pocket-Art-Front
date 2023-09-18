


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../mainpage/MainPage.dart';

class ImgDownload extends StatefulWidget {
  String imageUrl;
  ImgDownload({super.key, required this.imageUrl});

  @override
  State<ImgDownload> createState() => _ImgDownloadState();
}

class _ImgDownloadState extends State<ImgDownload> {//갤러리 다운로드 관련

  String imgURL ="";

  @override
  void initState() {
    super.initState();
    imgURL = widget.imageUrl;
  }


  void downloadImage() async {
    var response = await http.get(Uri.parse(imgURL));
    var bytes = response.bodyBytes;

    var dir = await getApplicationDocumentsDirectory();
    File file = File('${dir.path}/downloaded_image.jpg');
    await file.writeAsBytes(bytes);

    // 갤러리에 이미지 저장
    await ImageGallerySaver.saveFile(file.path);
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
              color: Colors.white),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark,
                  statusBarBrightness: Brightness.light,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0.0,

                leadingWidth: 113,
                toolbarHeight: 66,
                leading: gotoMainBtn(),


              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.all(18),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        child: Text(
                          '그림이 완성됐습니다!',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 23,
                            fontFamily: 'SUIT',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      SizedBox(height: 24,),

                      Stack(
                        children: <Widget>[
                          Container(
                            width: 354,
                            height: 354,
                            padding: EdgeInsets.all(11),

                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Color(0xffC6C6C6)),
                              ),
                              shadows: [ // 그림자 설정
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.7),
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            // child: Transform.rotate(
                            //   angle: 90 * 3.141592653589793 / 180,
                            child: Container(
                              width: 332, height: 332,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(imgURL))),
                            ),
                            )
                        ],
                      ),

                      SizedBox(height: 28,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [


                          InkWell(
                            // splashColor: Colors.red, // 터치 효과 색상
                            highlightColor: Colors.grey, // 눌림 효과 색상

                            onTap: () {
                              // 다운로드 버튼 실행 동작
                              downloadImage();
                              showDialog(context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.transparent,
                                      contentPadding: EdgeInsets.all(0),
                                      content: const DownloadComplete(),
                                      elevation: 0,
                                      insetPadding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 100),



                                    );
                                  });
                            },
                            child: Container(
                              width: 91, height: 91,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage('images/img_18.png'))),
                              child: Column(
                                children: [
                                  SizedBox(height: 15,),
                                  Image.asset('images/img_19.png',
                                    height: 38, width: 38,),

                                  Text('다운로드',
                                    style: TextStyle(
                                      color: Color(0xFF393939),
                                      fontSize: 12,
                                      fontFamily: 'SUIT',
                                      fontWeight: FontWeight.w600,
                                    ),),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),

                          InkWell(
                            // splashColor: Colors.red, // 터치 효과 색상
                            highlightColor: Colors.grey, // 눌림 효과 색상

                            onTap: () {
                              //공유 버튼 실행 동작
                            },
                            child: Container(
                              width: 91, height: 91,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage('images/img_18.png'))),
                              child: Column(
                                children: [
                                  SizedBox(height: 21,),
                                  Image.asset('images/img_20.png',
                                    height: 32, width: 32,),

                                  Text('공유하기',
                                    style: TextStyle(
                                      color: Color(0xFF393939),
                                      fontSize: 12,
                                      fontFamily: 'SUIT',
                                      fontWeight: FontWeight.w600,
                                    ),),
                                ],
                              ),
                            ),
                          ),


                        ],
                      ),

                      SizedBox(height: 34,),
                      Divider(
                        color: Color(0xffB4B4B4),
                        thickness: 1,
                        height: 0,
                      ),
                      SizedBox(height: 41,),

                      Container(
                          height: 56, width: 356,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32.5),
                            // 10은 반지름 크기입니다.
                            color: Color(0xff363636), // 배경 색상
                          ),
                          child: FilledButton(
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(
                                  Colors.transparent),
                            ),
                            onPressed: () {
                              print("색칠하기 버튼 ");
                            },
                            child: Text('색칠하기',
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


class btn1 extends StatelessWidget {
  const btn1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 356,
        height: 56,
        margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
        // padding: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('images/img_3.png'))),
        child: FilledButton(
          style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all<Color>(Colors.transparent),
          ),
          onPressed: () {
            print("만들기 버튼 test ");
          },
          child: Text('만들기',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'SUIT',
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center),
        ));
  }
}

class DownloadComplete extends StatelessWidget {
  const DownloadComplete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: 300,
      height: 550,
      child: Stack(children: <Widget>[
        Positioned(
          child: Image.asset('images/img_4.png',
            width: 211, height: 228,
          ),
          top: 80,
          right: 50,
        ),
        Center(
            child:Container(
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [Colors.white, Colors.white],
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(23),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 8,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  )
                ],
              ),
              width: 278, height: 123,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(height: 31,),
                  Text(
                    'Complete!',
                    style: TextStyle(
                      color: Color(0xFF7D7D7D),
                      fontSize: 11,
                      fontFamily: 'SUIT',
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  Text(
                    '다운로드 완료!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'SUIT',
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  TextButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, child: Text('확인',
                    style: TextStyle(
                      color: Color(0xFFFEC513),
                      fontSize: 15,
                      fontFamily: 'SUIT',
                      fontWeight: FontWeight.w700,
                    ),))
                ],
              ),
            )
        ),
        Positioned(
          child: Image.asset('images/img_5.png',
            width: 178.77, height: 61.95,
          ),
          top: 181,
          right: 67,
        )


      ]),
    );

  }
}
