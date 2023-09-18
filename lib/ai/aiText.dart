import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar_example/mainpage/MainPage.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../ImgPrint/ImgDownload.dart';
import '../style/Chocie.dart';

class TextRoute extends StatelessWidget {
  const TextRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: TextToImg(),
    );
  }
}

class TextToImg extends StatefulWidget {
  const TextToImg({Key? key}) : super(key: key);

  @override
  State<TextToImg> createState() => _TextToImgState();
}

class _TextToImgState extends State<TextToImg> {
  bool _showProgressBar = false; // 추가: 프로그래스 바를 처음에는 숨깁니다.
  double _progressValue = 0.0; // 추가: 프로그래스 바의 값을 초기화합니다.

  String prompt = '';
  List<dynamic> res = [];
  TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/background2.png'),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            leadingWidth: 113,
            toolbarHeight: 66,
            leading:gotoMainBtn() ,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(17),
            child: Center(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      child: Text(
                        'AI 이미지 변환',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontFamily: 'SUIT',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Text('만들고 싶은 이미지의 키워드를 입력하세요.',
                                style: TextStyle(
                                  color: Color(0xFF757575),
                                  fontSize: 15,
                                  fontFamily: 'SUIT',
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          Container(
                            child: IconButton(
                              onPressed: () {
                                print('주의사항 팝업창 test');
                              },
                              icon: Icon(Icons.warning_amber_outlined),
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Container(
                        height: 119,
                        width: 356,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('images/img_2.png'),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: TextStyle(fontSize: 17),
                            maxLength: 100,
                            onChanged: (value) {
                              setState(() {
                                prompt = value;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: '텍스트 입력...',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                Container(
                  child: Container(
                    width: 356,
                    height: 56,
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    // padding: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('images/img_3.png')
                        )
                    ),
                    child:FilledButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                      ),
                          onPressed: () async {
                            setState(() {
                              _showProgressBar = true; // 프로그래스 바를 표시하기 위해 _showProgressBar를 true로 설정
                              _progressValue = 0.0; // 프로그래스 바의 값을 초기화합니다.
                            });

                            final url = Uri.parse(
                                'http://13.209.160.87:8080/api/image/generate?prompt=$prompt');
                            final response = await http.post(url);
                            List<dynamic> responseBody =
                            jsonDecode(response.body);
                            setState(() {
                              res = responseBody;
                            });

                            Timer.periodic(Duration(milliseconds: 500),
                                    (Timer timer) {
                                  setState(() {
                                    _progressValue += 0.01;
                                  });

                                  if (_progressValue >= 1.0) {
                                    timer.cancel();
                                    setState(() {
                                      _showProgressBar = false; // 작업이 완료되면 프로그래스 바를 숨깁니다.
                                    });
                                  }
                                });
                          },
                          child: Text(
                            '만들기',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'SUIT',
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 354,
                      height: 360,
                      child: _showProgressBar
                          ? ProgressBar(value: _progressValue)
                          : Container(
                        width: 354,
                        height: 360,
                        child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          shrinkWrap: true,
                          children: createGallery2(context,4, res),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
List<Widget> createGallery2(BuildContext context,int numImg, List<dynamic> res) {
  List<Widget> images = [];
  print(res);
  String selectedImageUrl="";
  File  file;
  Widget image;
  int i = 0;
  while (i < numImg && i < res.length) {
    final imageUrl = res[i]; // Get the image URL.

    image = GestureDetector( // Use GestureDetector to make the image tappable.
      onTap: () async {
        // Set the selected image URL when the user taps on an image.
        selectedImageUrl = imageUrl;

        // Convert the selected image URL to a file using the urlToFile function.
        file = await urlToFile(selectedImageUrl);

        if (file != null) {
          // Navigate to the ChoicePage and pass the selected image file.
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Choice(selectImg: file),
            ),
          );
        }
      },
      child: Image.network(imageUrl),
    );

    images.add(image);
    i++;
  }
  return images;
}
Future<File> urlToFile(String imageUrl) async {
  final Dio dio = Dio();
  try {
    Response response = await dio.get(imageUrl, options: Options(responseType: ResponseType.bytes));
    final List<int> bytes = response.data;
    final String tempPath = (await getTemporaryDirectory()).path;
    final String fileName = imageUrl.split('/').last;
    final String filePath = '$tempPath/$fileName';
    final File file = File(filePath);
    await file.writeAsBytes(bytes);
    return file;
  } catch (e) {
    throw Exception('Failed to load image: $imageUrl');
  }
}













// Future<File> imageUrlToFile(String imageUrl) async {
//   final response = await http.get(Uri.parse(imageUrl));
//   if (response.statusCode == 200) {
//     final bytes = response.bodyBytes;
//     final fileName = imageUrl.split('/').last; // 이미지 URL에서 파일 이름 추출
//     final file = File(fileName);
//
//     await file.writeAsBytes(bytes); // 파일로 저장
//
//     return file;
//   } else {
//     throw Exception('이미지 다운로드 실패: $imageUrl');
//   }
// }
// 나머지 코드는 동일하게 유지됩니다.
class gotoMainBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MainPage()),
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
class ProgressBar extends StatelessWidget {
  final double value;

  ProgressBar({required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 300,
                height: 13,
                child: Semantics(
                  label: 'Loading...',
                  child: LinearProgressIndicator(
                    value: value,
                    backgroundColor: Color(0xffEFEFEF),
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Color(0xff4065DE)),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          width: 300,
          child: Row(
            children: [
              SizedBox(
                width: 40,
              ),
              Text(
                '변환된 그림이 출력되고 있습니다!',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '${(value * 100).toInt()}%',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
