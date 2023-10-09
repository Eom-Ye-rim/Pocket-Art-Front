
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar_example/MyPage/AIConversionPhoto.dart';
import 'package:flutter_ar_example/MyPage/FavoritePhoto.dart';
import 'package:flutter_ar_example/MyPage/MyPost.dart';
import 'package:flutter_ar_example/MyPage/PaintingStyleConversionPhoto.dart';
import 'package:flutter_ar_example/MyPage/ProfileSetting.dart';

void main() {
  runApp(MaterialApp(
    home: MyPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        // 첫 번째 탭을 클릭했을 때의 작업

        break;
      case 1:
        // 두 번째 탭을 클릭했을 때의 작업( 화풍 변환 )
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          elevation: 0.0,
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 480,
              // 모달 높이 크기
              margin: EdgeInsets.only(
                left: 15,
                right: 15,
                bottom: 99,
              ),
              // 모달 좌우 여백 크기

              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.8), //모달 배경색
                border: Border.all(
                  color: Color(0xff6886F2),
                  width: 1.0,
                ),
              ),
              padding: EdgeInsets.fromLTRB(21, 21, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Art Transfer',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontFamily: 'SUIT',
                          fontWeight: FontWeight.w900,
                          height: 0,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close), // 닫기 아이콘
                        onPressed: () {
                          Navigator.of(context).pop(); // 모달 닫기
                        },
                      ),
                    ],
                  ),
                  Text(
                    '내가 원하는 사진을 고전 예술 스타일로 만들고\n색칠하고 art transfer art transfer',
                    style: TextStyle(
                      color: Color(0xFF7D7D7D),
                      fontSize: 11,
                      fontFamily: 'SUIT',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: -0.77,
                    ),
                  ),
                  SizedBox(
                    height: 33,
                  ),
                  InkWell(
                    highlightColor: Color(0xffFFD600), // 눌림 효과 색상
                    splashColor: Color(0xffFFD600), // 터치 효과 색상
                    onTap: () {
                      // AI 이미지 만들기 동작 코드 작성
                      print('AI 이미지 만들기');
                    },

                    child: Container(
                      width: 321,
                      height: 145,
                      decoration: ShapeDecoration(
                        color: Colors.white.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2, color: Color(0xFF979797)),
                          borderRadius: BorderRadius.circular(23),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(21, 24, 21, 24),
                            width: 103,
                            height: 103,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: OvalBorder(),
                            ),
                            child: Image(
                              image: AssetImage('images/img_12.png'),
                              width: 62,
                              height: 56,
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 17,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 151,
                                  ),
                                  Container(
                                    width: 17,
                                    height: 17,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFA7B1BE),
                                      shape: OvalBorder(
                                        side: BorderSide(
                                            width: 1, color: Color(0xFFE8E8E8)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 21,
                              ),
                              Text(
                                'AI 이미지 만들기',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'SUIT',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                              Text(
                                'AI로 이미지를 생성해요',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF8A8A8A),
                                  fontSize: 10,
                                  fontFamily: 'SUIT',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  InkWell(
                    highlightColor: Color(0xffFFD600), // 눌림 효과 색상
                    splashColor: Color(0xffFFD600), // 터치 효과 색상
                    onTap: () {
                      // 터치 이벤트 발생 시 실행할 코드 작성
                      print('갤러리에서 가져오기');
                    },
                    child: Container(
                      width: 321,
                      height: 145,
                      decoration: ShapeDecoration(
                        color: Colors.white.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2, color: Color(0xFF979797)),
                          borderRadius: BorderRadius.circular(23),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(21, 24, 21, 24),
                            width: 103,
                            height: 103,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: OvalBorder(),
                            ),
                            child: Image(
                              image: AssetImage('images/img_12.png'),
                              width: 62,
                              height: 56,
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 17,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 151,
                                  ),
                                  Container(
                                    width: 17,
                                    height: 17,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFA7B1BE),
                                      shape: OvalBorder(
                                        side: BorderSide(
                                            width: 1, color: Color(0xFFE8E8E8)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 21,
                              ),
                              Text(
                                '갤러리에서 가져오기',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'SUIT',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                              Text(
                                '내가 원하는 그림을 가져와요',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF8A8A8A),
                                  fontSize: 10,
                                  fontFamily: 'SUIT',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );

        break;
      case 2:
        // 세 번째 탭을 클릭했을 때의 작업

        break;

      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyPage()),
        );

    break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70), // 높이 설정
    child: SafeArea(
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            backgroundColor: Colors.white,
            elevation: 1,
            leadingWidth: 140,
            shadowColor: Colors.black,
            leading: Container(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [



                  Row(
                    mainAxisAlignment: MainAxisAlignment.end, // 가로축 정렬
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://www.qrart.kr:491/wys2/file_attach/2017/08/04/1501830205-47.jpg'), // 유저 프로필 이미지
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 10), // 이미지와 텍스트 사이 간격 조절
                      Text(
                        '김땡땡',
                        style: TextStyle(
                          color: Color(0xFF363636),
                          fontSize: 18,
                          fontFamily: 'SUIT',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            actions: [
              IconButton(
                icon: Icon(Icons.arrow_forward_ios_outlined,
                color: Color(0xff9F9F9F),),
                onPressed: () {
                  Navigator.pop(context); // 뒤로가기
                },
              ),
            ],

          ),
        ),
        ),

        bottomNavigationBar: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 10,
              blurRadius: 5,
              offset: Offset(0, 3),
            )
          ]),
          child: BottomNavigationBar(
            selectedItemColor: Color(0xff0066FF),
            unselectedItemColor: Color(0xff484848),
            showSelectedLabels: true,
            //해당 탭 선택시 아이콘 밑에 라벨 유무
            showUnselectedLabels: false,
            // 라벨 유무
            onTap: onTabTapped,
            currentIndex: _currentIndex,

            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage('images/img_16.png'),
                  height: 34,
                  width: 41,
                ),
                label: '사진변환',
              ),
              BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage('images/img_17.png'),
                  width: 32,
                  height: 30,
                ),
                label: 'AR',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: '마이페이지',
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            children: [
              Container(
                width: 390,
                padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 44,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // 고객센터 버튼 동작
                              },
                              child: Container(
                                width: 54,
                                height: 54,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.transparent,
                                      spreadRadius: 0,
                                      blurRadius: 0,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                  'images/img_29.png',
                                  width: 54,
                                  height: 54,
                                ),
                              ),
                            ),
                            Text(
                              '고객센터',
                              style: TextStyle(
                                color: Color(0xFF606060),
                                fontSize: 15,
                                fontFamily: 'SUIT',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // FQA 버튼 동작
                              },
                              child: Container(
                                width: 40,
                                height: 54,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.transparent,
                                      spreadRadius: 0,
                                      blurRadius: 0,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                  'images/img_30.png',
                                  width: 38,
                                  height: 38,
                                ),
                              ),
                            ),
                            Text(
                              'FQA',
                              style: TextStyle(
                                color: Color(0xFF606060),
                                fontSize: 15,
                                fontFamily: 'SUIT',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // 공지사항 버튼 동작
                              },
                              child: Container(
                                width: 40,
                                height: 54,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.transparent,
                                      spreadRadius: 0,
                                      blurRadius: 0,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                  'images/img_31.png',
                                  width: 38,
                                  height: 38,
                                ),
                              ),
                            ),
                            Text(
                              '공지사항',
                              style: TextStyle(
                                color: Color(0xFF606060),
                                fontSize: 15,
                                fontFamily: 'SUIT',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // 설정 버튼 동작
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ProfileSetting()),
                                );
                              },
                              child: Container(
                                width: 40,
                                height: 54,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.transparent,
                                      spreadRadius: 0,
                                      blurRadius: 0,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: Image.asset(
                                  'images/img_32.png',
                                  width: 37,
                                  height: 37,
                                ),
                              ),
                            ),
                            Text(
                              '계정 설정',
                              style: TextStyle(
                                color: Color(0xFF606060),
                                fontSize: 15,
                                fontFamily: 'SUIT',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 36,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        color: Color.fromRGBO(186, 211, 241, 0.3),
                        height: 49,
                        child: Center(
                          child: Container(
                            width: 390,
                            padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                            child: Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // 내 사진 버튼
                                  },
                                  child: Text(
                                    '내 사진',
                                    style: TextStyle(
                                      color: Color(0xFF353535),
                                      fontSize: 15,
                                      fontFamily: 'SUIT',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  width: 390,
                  padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              // 버튼 동작 코드
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AIConversionPhoto()),
                              );
                            },
                            child: Text(
                              'AI 사진',
                              style: TextStyle(
                                color: Color(0xFF606060),
                                fontSize: 15,
                                fontFamily: 'SUIT',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              // 버튼 동작 코드
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PaintingStyleConversionPhoto()),
                              );
                            },
                            child: Text(
                              '화풍변환 사진',
                              style: TextStyle(
                                color: Color(0xFF606060),
                                fontSize: 15,
                                fontFamily: 'SUIT',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        color: Color.fromRGBO(186, 211, 241, 0.3),
                        height: 49,
                        child: Center(
                          child: Container(
                            width: 390,
                            padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                            child: Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // 버튼 동작 코드
                                  },
                                  child: Text(
                                    '커뮤니티',
                                    style: TextStyle(
                                      color: Color(0xFF353535),
                                      fontSize: 15,
                                      fontFamily: 'SUIT',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  width: 390,
                  padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              // 버튼 동작 코드
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MyPost()),
                              );
                            },
                            child: Text(
                              '내가 올린 사진',
                              style: TextStyle(
                                color: Color(0xFF606060),
                                fontSize: 15,
                                fontFamily: 'SUIT',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              // 버튼 동작 코드
                            },
                            child: Text(
                              '내가 단 댓글',
                              style: TextStyle(
                                color: Color(0xFF606060),
                                fontSize: 15,
                                fontFamily: 'SUIT',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              // 버튼 동작 코드
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FavoritePhoto()),
                              );
                            },
                            child: Text(
                              '내가 좋아요한 사진',
                              style: TextStyle(
                                color: Color(0xFF606060),
                                fontSize: 15,
                                fontFamily: 'SUIT',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
