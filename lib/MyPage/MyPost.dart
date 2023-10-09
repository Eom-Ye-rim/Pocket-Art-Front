import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Mypage.dart';


void main() {
  runApp(MaterialApp(
    home: MyPost(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyPost extends StatefulWidget {
  const MyPost({Key? key}) : super(key: key);

  @override
  State<MyPost> createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {

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
            leadingWidth: 200,

            leading:Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_sharp,
                    color: Colors.black,),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

                Text(
                  '내가 올린 게시물',
                  style: TextStyle(
                    color: Color(0xFF696969),
                    fontSize: 18,
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),

              ],
            )



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
            selectedItemColor: Color(0xff484848),
            unselectedItemColor: Color(0xff484848),
            showSelectedLabels: false,
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
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                // width: 390,
                decoration: BoxDecoration(
                  color: Colors.white,

                ),
                child: GridViewPhotos(),
              ),
            ],
          ),
        ),

      ),
    );
  }
}

class GridViewPhotos extends StatefulWidget {
  const GridViewPhotos({Key? key}) : super(key: key);

  @override
  State<GridViewPhotos> createState() => _GridViewPhotosState();
}

class _GridViewPhotosState extends State<GridViewPhotos> {
  List<Widget> images = [];

  @override
  void initState() {
    super.initState();
    images = createPhotos(context); // Initialize images list here
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        childAspectRatio: 1 / 1.3,
        //가로1, 세로2 비율
        crossAxisCount: 2,
        // 1개의 행애 보여줄 item 갯수
        mainAxisSpacing: 20,
        // 수평 padding
        crossAxisSpacing: 20,
        // 수직 padding
        shrinkWrap: true,
        // 뷰 크기 고정
        primary: false,
        //내부는 스크롤 없게 지정
        children: images,
      ),
    );
  }
}

List<Widget> createPhotos(BuildContext context) {
  List<Widget> images = [];
  List<String> urls = [];

  urls.add(
      'https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/201503/10/htm_201503101403340104011.jpg');
  urls.add(
      'https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/201503/10/htm_201503101403340104011.jpg');
  urls.add(
      'https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/201503/10/htm_201503101403340104011.jpg');
  urls.add(
      'https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/201503/10/htm_201503101403340104011.jpg');

  urls.add(
      'https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/201503/10/htm_201503101403340104011.jpg');
  urls.add(
      'https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/201503/10/htm_201503101403340104011.jpg');
  urls.add(
      'https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/201503/10/htm_201503101403340104011.jpg');
  urls.add(
      'https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/201503/10/htm_201503101403340104011.jpg');
  urls.add(
      'https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/201503/10/htm_201503101403340104011.jpg');

  List<String> UserProfileImg = [];
  UserProfileImg.add(
      'https://www.qrart.kr:491/wys2/file_attach/2017/08/04/1501830205-47.jpg');
  UserProfileImg.add(
      'https://www.qrart.kr:491/wys2/file_attach/2017/08/04/1501830205-47.jpg');
  UserProfileImg.add(
      'https://www.qrart.kr:491/wys2/file_attach/2017/08/04/1501830205-47.jpg');
  UserProfileImg.add(
      'https://www.qrart.kr:491/wys2/file_attach/2017/08/04/1501830205-47.jpg');
  UserProfileImg.add(
      'https://www.qrart.kr:491/wys2/file_attach/2017/08/04/1501830205-47.jpg');

  UserProfileImg.add(
      'https://www.qrart.kr:491/wys2/file_attach/2017/08/04/1501830205-47.jpg');
  UserProfileImg.add(
      'https://www.qrart.kr:491/wys2/file_attach/2017/08/04/1501830205-47.jpg');
  UserProfileImg.add(
      'https://www.qrart.kr:491/wys2/file_attach/2017/08/04/1501830205-47.jpg');
  UserProfileImg.add(
      'https://www.qrart.kr:491/wys2/file_attach/2017/08/04/1501830205-47.jpg');
  UserProfileImg.add(
      'https://www.qrart.kr:491/wys2/file_attach/2017/08/04/1501830205-47.jpg');

  List<String> PostTitle = [];
  PostTitle.add('제목1111111111111111');
  PostTitle.add('제목2');
  PostTitle.add('제목3');
  PostTitle.add('제목4');
  PostTitle.add('제목5');

  PostTitle.add('제목1111111111111111');
  PostTitle.add('제목2');
  PostTitle.add('제목3');
  PostTitle.add('제목4');
  PostTitle.add('제목5');

  for (int i = 0; i < urls.length; i++) {
    Widget image = Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey, width: 0.5)), // 테두리 굵기 조절
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1, // 사진 비율
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image(
                      image: NetworkImage(urls[i]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

              ],
            ),
            Expanded(
              child: Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      CircleAvatar(
                        radius: 15, //
                        backgroundImage: NetworkImage(UserProfileImg[i]),
                      ),
                    ],
                  ),
                  Container(
                    width: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 85,
                          padding: EdgeInsets.fromLTRB(6, 7, 9, 4),
                          child: Text(
                            PostTitle[i], // 게시글 제목
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: TextStyle(
                              color: Color(0xFF535252),
                              fontSize: 12,
                              fontFamily: 'SUIT',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.remove_red_eye_outlined,
                              size: 15,
                              color: Color(0xffBDBDBD),
                            ),
                            Text(
                              '1111',
                              style: TextStyle(
                                color: Color(0xffBDBDBD),
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Icon(
                              Icons.chat_bubble_outline,
                              size: 15,
                              color: Color(0xffBDBDBD),
                            ),
                            Text(
                              '11',
                              style: TextStyle(
                                color: Color(0xffBDBDBD),
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Icon(
                              Icons.favorite_border,
                              size: 15,
                              color: Color(0xffBDBDBD),
                            ),
                            Text(
                              '111',
                              style: TextStyle(
                                color: Color(0xffBDBDBD),
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),


                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        print("게시글 버튼 ");
                      },
                      icon: Icon(Icons.more_vert),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );

    images.add(image);
  }
  return images;
}


