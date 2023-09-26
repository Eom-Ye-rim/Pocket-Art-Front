import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(const textToImg());
}

class textToImg extends StatefulWidget {
  const textToImg({Key? key}) : super(key: key);

  @override
  State<textToImg> createState() => _textToImgState();
}

class _textToImgState extends State<textToImg> {
  bool _showProgressBar = true;

  @override
  void initState() {
    super.initState();
    // 50초 후에 프로그래스바 숨기기
    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showProgressBar = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, // 디버그 리본 없애기
        home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/background2.png'))),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                // 상단 Status Bar 추가
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark,
                  statusBarBrightness: Brightness.light,
                ),
                leadingWidth: 113,
                toolbarHeight: 66,
                leading: gotoMainBtn(),

                backgroundColor: Colors.transparent,
                // 투명으로 해도 appBar 자체 그림자 생김
                elevation: 0.0, // appBar 그림자 0.0 해주면 완전 투명됨
              ),
              body: SingleChildScrollView(
                child: Center(
                  // 아이폰 11 화면 대응
                  child: Container(
                    width: 356, // 아이폰 11 화면 대응
                    // padding: EdgeInsets.all(17),
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
                          child: inputTextBox(),
                        ),
                        Container(
                          child: btn1(),
                        ),
                        Container(
                            width: 354,
                            height: 360,
                            child: Center(
                              child: _showProgressBar
                                  ? ProgressBar()
                                  : DallE_img(),
                            )),

                        // Container(
                        //   child: DallE_img(),
                        // ),
                      ],
                    ),
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
              print('추후에 메인 페이지 화면 전환 함수 추가할것');
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

class inputTextBox extends StatelessWidget {
  const inputTextBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 119,
        width: 356,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('images/img_2.png'))),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(fontSize: 17),
              maxLength: 100,
              decoration: InputDecoration(
                hintText: '텍스트 입력...',
                border: InputBorder.none, // 밑줄 제거
              ),
            )));
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

class DallE_img extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 354,
      height: 360,
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        shrinkWrap: true,
        children: createGallery2(4),
      ),
    );
  }
}

List<Widget> createGallery2(int numImg) {
  List<Widget> images = [];
  List<String> urls = [
    'https://upload.wikimedia.org/wikipedia/commons/f/fe/Vincent_van_Gogh_-_Sunflowers_%281888%2C_National_Gallery_London%29.jpg',
    'https://www.qrart.kr:491/wys2/file_attach/2017/08/04/1501830205-47.jpg',
    'https://seoartgallery.com/wp-content/uploads/2016/07/%EB%B0%98%EA%B3%A0%ED%9D%90-%EC%B4%88%EC%83%81%ED%99%94-633x767.jpg',
    'https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/201503/10/htm_201503101403340104011.jpg'
  ];

  for (String url in urls) {
    Widget image = InkWell(
      onTap: (){
        print('만들기 버튼 ');
      },
      child: Container(
        width: 186,
        height: 186,
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),

      ),
    );

    images.add(image);
  }

  return images;
}





// List<Widget> createGallery(int numImg) {
//   List<Widget> images = [];
//   List<String> urls = [];
//   urls.add(
//       'https://upload.wikimedia.org/wikipedia/commons/f/fe/Vincent_van_Gogh_-_Sunflowers_%281888%2C_National_Gallery_London%29.jpg');
//   urls.add(
//       'https://www.qrart.kr:491/wys2/file_attach/2017/08/04/1501830205-47.jpg');
//   urls.add(
//       'https://seoartgallery.com/wp-content/uploads/2016/07/%EB%B0%98%EA%B3%A0%ED%9D%90-%EC%B4%88%EC%83%81%ED%99%94-633x767.jpg');
//   urls.add(
//       'https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/201503/10/htm_201503101403340104011.jpg');
//
//   Widget image;
//   int i = 0;
//   while (i < numImg) {
//     image = IconButton(
//       onPressed: () {
//         print("이미지 터치 test ");
//       },
//       iconSize: 186,
//       icon: Image.network(
//         urls[i],
//         fit: BoxFit.cover,
//       ),
//     );
//     images.add(image);
//     i++;
//   }
//   return images;
// }

class ProgressBar extends StatefulWidget {
  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();

    // ex) milliseconds: 30 => 3초 진행, 50 => 5초 진행
    Timer.periodic(Duration(milliseconds: 500), (Timer timer) {
      setState(() {
        _progressValue += 0.01; // 3초에 걸쳐서 100%에 도달하기 위해 0.01씩 증가
      });

      if (_progressValue >= 1.0) {
        timer.cancel(); // 타이머 중지
      }
    });
  }

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
                      value: _progressValue,
                      backgroundColor: Color(0xffEFEFEF), // 프로그래스바 배경색
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xff4065DE)), // 프로그래스 바 색상
                    ),
                  )),
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
                '${(_progressValue * 100).toInt()}%',
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
