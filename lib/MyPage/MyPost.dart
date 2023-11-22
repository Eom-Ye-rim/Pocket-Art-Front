import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../board/ViewPost.dart';
import 'MyPage.dart';
import 'package:dio/dio.dart';



class MyPost extends StatefulWidget {
  final dynamic responseData;
  const MyPost({Key? key, required this.responseData}) : super(key: key);

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
          MaterialPageRoute(builder: (context) => MyPage(responseData: widget.responseData)),
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
                child: GridViewPhotos(num: 1),
              ),
            ],
          ),
        ),

      ),
    );
  }
}

class GridViewPhotos extends StatefulWidget {
  final int num;
  const GridViewPhotos({Key? key, required this.num}) : super(key: key);

  @override
  State<GridViewPhotos> createState() => _GridViewPhotosState(num);
}

class _GridViewPhotosState extends State<GridViewPhotos> {
  List<Widget> _images = [];
  int num;
  _GridViewPhotosState(this.num);

  @override
  void initState() {
    super.initState();
    // Schedule the asynchronous task to run after the initial build
    Future.delayed(Duration(milliseconds: 0), () async {
      List<Widget> images = await createPhotos(context,num);

      setState(() {
        // Update the state with the list of images
        _images = images;
      });
    });
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
        children: _images,
      ),
    );
  }
}

Future<List<Widget>> createPhotos(BuildContext context,int num) async{
  List<ContestPageData> urls=[];
  urls = await getBoard();
  List<String> PostImage=[];
  List<String> PostTitle = [];
  List<int> PostView = [];
  List<int> PostId=[];
  List<int> PostComment = [];
  List<int> PostLike = [];
  List<String> PostWriter = [];
  List<Widget> images = [];
  List<String> UserProfileImg = [];
  for (ContestPageData pagedata in urls) {


    PostTitle.add(pagedata.getTitle());
    PostView.add(pagedata.getViewCount());
    PostWriter.add(pagedata.getAuthor());
    PostComment.add(pagedata.getCommentCnt());
    PostLike.add(pagedata.getLikecnt());
    PostImage.add(pagedata.getPhoto());
    UserProfileImg.add(pagedata.getUserImg());

  }


  for (int i = 0; i < urls.length; i++) {
    Widget image = Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey, width: 0.5)),
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
                      child: GestureDetector(
                        onTap: () {
                          _uploadPost(context, urls[i].id);
                        },
                        child: Image(
                          image: NetworkImage(PostImage[i]),
                          fit: BoxFit.cover,
                        ),
                      )
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 5,),
                      Container(
                        width: 31,
                        height: 31,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            //사용자 프로필 사진 url
                            image: NetworkImage(UserProfileImg[i]),
                            fit: BoxFit.fill,
                          ),
                          shape: OvalBorder(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      width: 100,
                      padding: EdgeInsets.fromLTRB(6, 7, 9, 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
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

                          Row(
                            children: [
                              Icon(
                                Icons.remove_red_eye_outlined,
                                size: 15,
                                color: Color(0xffBDBDBD),
                              ),
                              Text(
                                PostView[i].toString(),
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
                                PostComment[i].toString(),
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
                                PostLike[i].toString(),
                                style: TextStyle(
                                  color: Color(0xffBDBDBD),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                            ],
                          ),
                        ],
                      )
                  ),

                  Expanded(child: IconButton(
                    onPressed: () {
                      print("게시글 버튼 ");
                    },
                    icon: Icon(Icons.more_vert),
                  ),)

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

class ContestPageData {
  final BigInt id;

  final String author;
  final String title;
  final int viewCount;
  final int likecnt;
  final int commentCnt;
  final String photo;
  final String userImg;


  ContestPageData({
    required this.id,
    required this.author,
    required this.title,
    required this.viewCount,
    required this.likecnt,
    required this.photo,
    required this.commentCnt,
    required this.userImg,
  });

  BigInt getId(){
    return id;
  }
  String getTitle(){
    return title;
    //return utf8.decode(base64.decode(title));
  }
  String getAuthor(){
    return author;
    // return utf8.decode(base64.decode(author));
  }
  String getPhoto(){
    return photo;
  }
  String getUserImg(){
    return userImg;
  }
  int getViewCount(){
    return viewCount;
  }
  int getLikecnt(){
    return likecnt;
  }
  int getCommentCnt(){
    return commentCnt;
  }

}

Future<List<ContestPageData>> getBoard() async {
  final dio = Dio();
  final url = 'http://54.180.79.174:8080/api/v1/my';
  try {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    // 인증 헤더 설정
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>; // API 응답을 명시적으로 List<dynamic> 형식으로 변환
      final List<ContestPageData> contestPageDataList = data.map((item) {
        return ContestPageData(
          id: BigInt.from(item['id']),
          author: item['author'],
          title: item['title'],
          userImg: item['user_img'],
          viewCount: item['view_count'],
          photo: item['first_photo'],
          likecnt: item['likecnt'],
          commentCnt: item['comment_cnt'],
        );
      }).toList();
      return contestPageDataList;
    } else {
      throw Exception('Failed to load contest data');
    }
  } catch (e) {
    print('오류: $e');
    throw e; // 여기에서 예외를 다시 throw하여 호출자에게 전달합니다.
  }
}


Future<void> _uploadPost(BuildContext context,BigInt postId) async {
  print("get post");
  final dio = Dio();
  final url = 'http://54.180.79.174:8080/api/v1/contest/$postId';
  try {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    // 인증 헤더 설정
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      // 응답이 성공적으로 돌아왔을 때 응답 데이터를 출력합니다.
      print('The request was sent successfully.');
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewPost(
                responseData: response.data), // responseData는 응답 데이터입니다.
          ));
    } else {
      // 서버가 200 OK 응답을 반환하지 않았을 때 예외를 throw합니다.
      throw Exception('데이터를 불러오지 못했습니다. 상태 코드: ${response.statusCode}');
    }
  } catch (e) {
    print('오류: $e');
  }

}

