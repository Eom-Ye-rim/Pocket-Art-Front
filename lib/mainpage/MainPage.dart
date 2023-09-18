
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar_example/board/PhotoBoard.dart';
import 'package:flutter_ar_example/ARScreen.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../ai/aiText.dart';
import '../style/Chocie.dart';




void main() {
  runApp(MaterialApp(
    home: MainPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _currentIndex = 0;
  File ? _selectedImage;
  String fileName = "";
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
      // 첫 번째 탭을 클릭했을 때의 작업

        break;
      case 1:
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

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>TextToImg()),
                    );
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
              SizedBox(width: 151,),
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
              SizedBox(height: 21,),

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
                      SizedBox(height: 22,),

                      InkWell(
                        highlightColor: Color(0xffFFD600), // 눌림 효과 색상
                        splashColor: Color(0xffFFD600), // 터치 효과 색상
                        onTap: () async {
                          final picker = ImagePicker();
                          final pickedImage = await picker.pickImage(source: ImageSource.gallery);

                          if (pickedImage != null) {
                            setState(() {
                              _selectedImage = File(pickedImage.path);

                              fileName = _selectedImage!.path.split('/').last;
                              print(fileName);

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Choice(selectImg:_selectedImage)),
                              );
                            });
                          }
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
                                      SizedBox(width: 151,),
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
                                  SizedBox(height: 21,),

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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ARScreen()),
        );
      // 세 번째 탭을 클릭했을 때의 작업
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => const textToImg()),
      //   );
        break;
    }

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 리본 없애기
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('images/img_11.png'))),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(46),
            child: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
              ),
              automaticallyImplyLeading: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 185,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(26, 0, 0, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [


                          Container(
                            height: 64,
                            width: 156,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(51, 255, 255, 255),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Color.fromARGB(179, 116, 116, 116),
                                // Border color
                                width: 1, // Border width
                              ),
                            ),
                            child: TextButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<
                                    EdgeInsetsGeometry>(
                                  EdgeInsets.all(0), // 여백 제거
                                ),
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    Colors.transparent),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  //PhotoBoard
                                  MaterialPageRoute(builder: (context) => PhotoBoard()),
                                );
                                print('사진 게시');
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Image.asset(
                                    'images/img_12.png',
                                    width: 51,
                                    height: 51,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '사진게시판',
                                    style: TextStyle(
                                      color: Color(0xFF484848),
                                      fontSize: 15,
                                      fontFamily: 'SUIT',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),



                          SizedBox(
                            width: 26,
                          ),



                          Container(
                            height: 64,
                            width: 156,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(51, 255, 255, 255),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Color.fromARGB(179, 116, 116, 116),
                                // Border color
                                width: 1, // Border width
                              ),
                            ),
                            child: TextButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<
                                    EdgeInsetsGeometry>(
                                  EdgeInsets.all(0), // 여백 제거
                                ),
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    Colors.transparent),
                              ),
                              onPressed: () {
                                print('AR전시장가기');
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Image.asset(
                                    'images/img_13.png',
                                    width: 51,
                                    height: 51,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    'AR전시장가기',
                                    style: TextStyle(
                                      color: Color(0xFF484848),
                                      fontSize: 15,
                                      fontFamily: 'SUIT',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 27,),

                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '#우와.. AI가 만든 사진이야 🥳',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'SUIT',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'AI로 변환된 사진 보기!',
                                style: TextStyle(
                                  color: Color(0xFFB3B3B3),
                                  fontSize: 12,
                                  fontFamily: 'SUIT',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(width:110 ,),


                          IconButton(onPressed: (){
                            print('AI로 변환한 사진 보기');
                          }, icon:Icon(Icons.navigate_next) )

                        ],
                      ),
                      SizedBox(height: 10,),
                      RowScrollPhotos_1(),

                      SizedBox(height: 19,),





                    ],
                  ),
                ),
                Container(height: 5,width: 390,color: Color(0xffE6E6E6),
                ),
                SizedBox(height: 15,),
                Container(
                  padding: EdgeInsets.only(left: 26),
                  child:Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '#이게 내가 찍은 사진이라고? 👀',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'SUIT',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                '내가 찍은 사진 바꿔보기!',
                                style: TextStyle(
                                  color: Color(0xFFB3B3B3),
                                  fontSize: 12,
                                  fontFamily: 'SUIT',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(width:101 ,),


                          IconButton(onPressed: (){
                            print('내가 찍은 사진 바꿔보기');
                          }, icon:Icon(Icons.navigate_next) )

                        ],
                      ),

                      SizedBox(height: 10,),
                      RowScrollPhotos_2(),

                    ],
                  ),
                )

              ],
            ),
          ),

          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Color(0xff0066FF),
            unselectedItemColor: Color(0xff484848),
            showSelectedLabels: true, //해당 탭 선택시 아이콘 밑에 라벨 유무
            showUnselectedLabels: false, // 라벨 유무
            onTap: onTabTapped,
            currentIndex: _currentIndex,


            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: Image(image: AssetImage('images/img_16.png'),
                  height: 34, width: 41,),
                label: '사진변환',
              ),
              BottomNavigationBarItem(
                icon: Image(image: AssetImage('images/img_17.png'),
                  width: 32, height: 30,),
                label: 'AR',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: '마이페이지',
              ),
            ],
          ),
        ),
      ),
    );
  }
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

Future<List<ContestPageData>> getGeneralBoard()  async {
  List<String> boardList = [];

  final url = Uri.parse('http://13.209.160.87:8080/api/v1/contest/all?boardType=일반');
  final Map<String, String> data = {
    "title": "",
    "content": "",
    "writer": "",
    "userImg":"",
  };

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json; charset=utf-8'},
    body: json.encode(data),
  );

  if(response.statusCode==200){
    final jsonData = json.decode(utf8.decode(response.bodyBytes));
    final data = jsonData['content'] as List<dynamic>;

    final List<ContestPageData> contestPageDataList = data.map((item) {
      return ContestPageData(
        id:BigInt.from(item['id']),
        author: item['author'],
        title: item['title'],
        userImg: item['user_img'],
        viewCount: item['view_count'],
        photo: item['first_photo'],
        likecnt: item['likecnt'],
        commentCnt: item['comment_cnt'],
      );
    }).toList();
    print(contestPageDataList);
    return contestPageDataList;

  } else {
    throw Exception('Failed to load contest data');
  }
}

Future<List<ContestPageData>> getAIBoard()  async {
  List<String> boardList = [];

  final url = Uri.parse('http://13.209.160.87:8080/api/v1/contest/all?boardType=AI');
  final Map<String, String> data = {
    "title": "",
    "content": "",
    "writer": "",
    "userImg":"",
  };

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json; charset=utf-8'},
    body: json.encode(data),
  );

  if(response.statusCode==200){
    final jsonData = json.decode(utf8.decode(response.bodyBytes));
    final data = jsonData['content'] as List<dynamic>;

    final List<ContestPageData> contestPageDataList = data.map((item) {
      return ContestPageData(
        id:BigInt.from(item['id']),
        author: item['author'],
        title: item['title'],
        userImg: item['user_img'],
        viewCount: item['view_count'],
        photo: item['first_photo'],
        likecnt: item['likecnt'],
        commentCnt: item['comment_cnt'],
      );
    }).toList();
    print(contestPageDataList);
    return contestPageDataList;

  } else {
    throw Exception('Failed to load contest data');
  }
}



//#우와.. AI가 만든 사진이야 <--- 이 부분 관련
Future<List<Widget>> Post_1() async {
  List<ContestPageData> urls= await getAIBoard();
  List<Widget> Post_1Widgets = [];
  List<String> Post_1images = [];
  List<String> Post_1ImgUrls = [];
  List<String> Post_1Title = [];
  List<int> PostComment = [];
  List<int> PostView = [];
  List<int> PostLike = [];
  List<String> PostWriter = [];

  for (ContestPageData pagedata in urls) {
    Post_1images.add(pagedata.getPhoto());
    Post_1ImgUrls.add(pagedata.getUserImg());
    Post_1Title.add(pagedata.getTitle());
    PostComment.add(pagedata.getCommentCnt());
    PostLike.add(pagedata.getLikecnt());
    PostWriter.add(pagedata.getAuthor());
    PostView.add(pagedata.getViewCount());

  }





  Widget image;
  int i = 0;
  while (i < urls.length) {
    image = Stack(
      children: [
        Container(
          child: Column(
            children: [
              SizedBox(height: 106,),
              Image.asset('images/img_14.png'),
            ],
          ) ,
          height: 171,
          width: 110,
          margin: EdgeInsets.fromLTRB(0, 0, 26, 0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(11),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(Post_1images[i]) //Best5 사진 url
            ),
          ),
        ),
        Positioned(
          top: -5,
          right: 20,
          child: HeartButton(),
        ),
        Positioned(
            bottom: 20,
            left: 10,
            child: Container(
              width: 220,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        width:63,
                        child: Text(
                          // softWrap: true,
                          Post_1Title[i],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'SUIT',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                    ],
                  ),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  IconButton(
                    onPressed: () {
                      print('사진 게시글');
                    },
                    icon: Icon(Icons.arrow_forward,
                        size: 16, color: Colors.white),
                  ),
                ],
              ),
            ))
      ],
    );

    Post_1Widgets.add(image);
    i++;
  }
  return Post_1Widgets;
}


// #이게 내가 찍은 사진이라고? <---- 아부분 관련
Future<List<Widget>> Post_2() async {
  List<ContestPageData> urls= await getGeneralBoard();
  List<String> Post_2images = [];
  List<Widget> Post_2Widgets = [];
  List<String> Post_2ImgUrls = [];
  List<String> Post_2Title = [];
  List<int> PostComment = [];
  List<int> PostView = [];
  List<int> PostLike = [];
  List<String> PostWriter = [];

  for (ContestPageData pagedata in urls) {
    Post_2images.add(pagedata.getPhoto());
    Post_2ImgUrls.add(pagedata.getUserImg());
    Post_2Title.add(pagedata.getTitle());
    PostComment.add(pagedata.getCommentCnt());
    PostLike.add(pagedata.getLikecnt());
    PostWriter.add(pagedata.getAuthor());
    PostView.add(pagedata.getViewCount());
  }


  Widget image;
  int i = 0;
  while (i < urls.length) {
    image = Stack(
      children: [
        Container(
          child: Column(
            children: [
              SizedBox(height: 106,),
              Image.asset('images/img_14.png'),
            ],
          ) ,
          height: 171,
          width: 110,
          margin: EdgeInsets.fromLTRB(0, 0, 26, 0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(11),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(Post_2images[i]) //Best5 사진 url
            ),
          ),
        ),
        Positioned(
          top: -5,
          right: 20,
          child: HeartButton(),
        ),
        Positioned(
            bottom: 20,
            left: 10,
            child: Container(
              width: 220,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        width:63,
                        child: Text(
                          // softWrap: true,
                          Post_2Title[i],
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'SUIT',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                    ],
                  ),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  IconButton(
                    onPressed: () {
                      print('사진 게시글');
                    },
                    icon: Icon(Icons.arrow_forward,
                        size: 16, color: Colors.white),
                  ),
                ],
              ),
            ))
      ],
    );

    Post_2Widgets.add(image);
    i++;
  }
  return Post_2Widgets;
}

class RowScrollPhotos_1 extends StatefulWidget {
  const RowScrollPhotos_1({Key? key}) : super(key: key);

  @override
  State<RowScrollPhotos_1> createState() => _RowScrollPhotos_1State();
}

class _RowScrollPhotos_1State extends State<RowScrollPhotos_1> {
  List<Widget> post1Widgets = []; // Store the widgets
  @override
  void initState() {
    super.initState();
    // Call the asynchronous function when the widget initializes
    loadPost1Widgets();
  }

  Future<void> loadPost1Widgets() async {
    // Call the asynchronous function
    List<Widget> result = await Post_1();
    setState(() {
      // Update the widget tree with the result
      post1Widgets = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 171,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: ScrollPhysics(),
        primary: true,
        child: Row(
          children: post1Widgets, // Use the stored widgets
        ),
      ),
    );
  }
}


class RowScrollPhotos_2 extends StatefulWidget {
  const RowScrollPhotos_2({Key? key}) : super(key: key);

  @override
  State<RowScrollPhotos_2> createState() => _RowScrollPhotos_2State();
}

class _RowScrollPhotos_2State extends State<RowScrollPhotos_2> {
  List<Widget> post2Widgets = []; // Store the widgets
  @override
  void initState() {
    super.initState();
    // Call the asynchronous function when the widget initializes
    loadPost1Widgets();
  }

  Future<void> loadPost1Widgets() async {
    // Call the asynchronous function
    List<Widget> result = await Post_2();
    setState(() {
      // Update the widget tree with the result
      post2Widgets = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 171,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: ScrollPhysics(),
        primary: true,
        child: Row(
          children: post2Widgets, // Use the stored widgets
        ),
      ),
    );
  }
}



class HeartButton extends StatefulWidget {
  @override
  _HeartButtonState createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromRGBO(217, 217, 217, 0.6),
          ),
        ),
        IconButton(
          icon: Icon(
            _isLiked ? Icons.favorite : Icons.favorite_border,
            size: 18,
            color: _isLiked ? Colors.red : Colors.white,
          ),
          onPressed: () {
            setState(() {
              _isLiked = !_isLiked;
            });
          },
        ),
      ],
    );
  }
}


