import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'Mypage.dart';

void main() {
  runApp(MaterialApp(
    home: ProfileSetting(),
    debugShowCheckedModeBanner: false,
  ));
}


class ProfileSetting extends StatefulWidget {
  const ProfileSetting({Key? key}) : super(key: key);

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  XFile? _pickedFile;

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
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 150,

          leading: Row(
            children: [
              SizedBox(width: 10,),
              IconButton(
                icon: Icon(Icons.arrow_back_ios,
                color: Colors.black,),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Text(
                '프로필 설정',
                style: TextStyle(
                  color: Color(0xFF696969),
                  fontSize: 18,
                  fontFamily: 'SUIT',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ],
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
            child: Container(
              color: Colors.white,
              child:
              Container(
                width: 390,
                padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            print("프로필 이미지 터치");
                            var picker = ImagePicker();
                            var image = await picker.pickImage(source: ImageSource.gallery);
                            if (image != null) {
                              setState(() {
                                _pickedFile = image;
                              });
                            }
                          },
                          child: Container(
                            width: 92,
                            height: 92,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: _pickedFile != null && _pickedFile!.path != null
                                    ? FileImage(File(_pickedFile!.path)) as ImageProvider<Object>
                                    : NetworkImage(
                                  //사용자 변경 전 기존 유저 프로필 이미지 url
                                  'https://www.qrart.kr:491/wys2/file_attach/2017/08/04/1501830205-47.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 1,
                          right: 1,
                          child: GestureDetector(
                            onTap: () {
                              // 작은 프로필 이미지를 터치할 때의 동작 추가
                            },
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage('images/img_34.png'), // 유저 프로필 이미지
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 53,),

                    Row(
                      children: [
                        Text(
                          '이름',
                          style: TextStyle(
                            color: Color(0xFF1C1C1C),
                            fontSize: 15,
                            fontFamily: 'SUIT',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(13, 0, 13, 0),
                      width: 356,
                      height: 66,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 0.50, color: Colors.grey),
                        ),
                      ),
                      child: TextFormField(
                          keyboardType: TextInputType.name,
                          maxLines: 1,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: InputDecoration(
                            hintText: '이름을 입력하세요',
                            border: InputBorder.none,
                          )),
                    ),
                    SizedBox(height: 20,),

                    Row(
                      children: [
                        Text(
                          '이메일',
                          style: TextStyle(
                            color: Color(0xFF1C1C1C),
                            fontSize: 15,
                            fontFamily: 'SUIT',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(13, 0, 13, 0),
                      width: 356,
                      height: 66,
                      decoration: ShapeDecoration(
                        color: Color(0xffF2F2F2),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 0.50, color: Colors.grey),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'user1@test.com',
                            style: TextStyle(
                              color: Color(0xFF363636),
                              fontSize: 18,
                              fontFamily: 'Apple SD Gothic Neo',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),

                          ),
                        ],
                      )
                    ),
                    SizedBox(height: 20,),

                    Row(
                      children: [
                        Text(
                          '비밂번호',
                          style: TextStyle(
                            color: Color(0xFF1C1C1C),
                            fontSize: 15,
                            fontFamily: 'SUIT',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(13, 0, 13, 0),
                      width: 356,
                      height: 66,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 0.50, color: Colors.grey),
                        ),
                      ),
                      child: TextFormField(
                          keyboardType: TextInputType.name,
                          maxLines: 1,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: InputDecoration(
                            hintText: '비밀번호를 입력하세요',
                            border: InputBorder.none,
                          )),
                    ),
                    SizedBox(height: 20,),

                    Row(
                      children: [
                        Text(
                          '비밀번호 확인',
                          style: TextStyle(
                            color: Color(0xFF1C1C1C),
                            fontSize: 15,
                            fontFamily: 'SUIT',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(13, 0, 13, 0),
                      width: 356,
                      height: 66,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 0.50, color: Colors.grey),
                        ),
                      ),
                      child: TextFormField(
                          keyboardType: TextInputType.name,
                          maxLines: 1,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: InputDecoration(
                            hintText: '비밀번호 확인을 입력하세요',
                            border: InputBorder.none,
                          )),
                    ),

                    SizedBox(height: 40,),
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
                            '수정',
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
            )
          ),
        ),
      ),
    );
  }
}
