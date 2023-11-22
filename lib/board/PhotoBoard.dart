import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ar_example/MyPage/MyPage.dart';
import 'package:flutter_ar_example/board/Search.dart';
import 'package:flutter_ar_example/mainpage/MainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'CreatePost.dart';
import 'package:dio/dio.dart';

import 'ViewPost.dart';



void main() {
  runApp(const PhotoBoard());
}

class PhotoBoard extends StatefulWidget {
  const PhotoBoard({Key? key}) : super(key: key);

  @override
  State<PhotoBoard> createState() => _PhotoBoardState();
}

class _PhotoBoardState extends State<PhotoBoard> {
  int _selectedIndex = 0;

  Future<void> _onItemTapped(int index) async {
    print("Tapped index: $index");
    if (index == 1) {
      // Navigate to the CreatePostPage when "글쓰기" button is clicked.
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CreatePost()), // Replace CreatePostPage with your actual page name.
      );
    }
    if (index == 2) {
      // Navigate to the CreatePostPage when "글쓰기" button is clicked.
      final dio = Dio();
      final url = 'http://54.180.79.174:8080/api/v1/my';

      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('accessToken');

      // 인증 헤더 설정
      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await dio.get(url,);

      final responseData=response.data;
      print("MyPageData $responseData");


      Navigator.push(
        context,

        MaterialPageRoute(builder: (context) => MyPage(responseData:responseData)),
      );
    }
    setState(() {
      _selectedIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 리본 없애기
      home: DefaultTabController(
        // 상단 탭 만들기 위해서 DefaultTabController로 감싸줘야함
        length: 3, //탭 갯수
        child: Scaffold(
          appBar: AppBar(
            leading:gotoMainBtn(),
            title: Text(
              '사진 게시판',
              style: TextStyle(
                color: Color(0xFF484848),
                fontSize: 20,
                fontFamily: 'SUIT',
                fontWeight: FontWeight.w700,
              ),
            ),

            actions: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Search()), // Replace CreatePostPage with your actual page name.
                  );
                },
                icon: Icon(Icons.search),
                color: Color(0xff626262),
              )
            ],

            systemOverlayStyle: SystemUiOverlayStyle(
              //status bar 색 변경 -black
              statusBarIconBrightness: Brightness.dark, //<-- 안드로이드 설정
              statusBarBrightness: Brightness.light, //<-- ios설정
            ),
            automaticallyImplyLeading: true,
            // 상위페이지 생기면 뒤로가기 버튼 생성

            backgroundColor: Colors.white,
            //appbar background Color
            elevation: 10,
            // appBar 그림자
            shadowColor: Color(0x1A0066FF),

            bottom: TabBar(
              labelColor: Color(0xff0066FF),
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 16,
              ),
              indicatorColor: Color(0xff0066FF),
              indicatorWeight: 5,
              tabs: <Widget>[
                Tab(
                  text: ('전체'),
                ),
                Tab(
                  text: 'AI',
                ),
                Tab(
                  text: '일반사진',
                ),
              ],
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              AllPhotosScreen(),
              AIPhotosScreen(),
              NormalPhotosScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Color(0xff0066FF),
            unselectedItemColor: Color(0xff484848),
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            // showSelectedLabels: false, //아이콘 밑에 라벨 유무
            // showUnselectedLabels: false, // 라벨 유무

            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '홈',
              ),
              BottomNavigationBarItem(
                // icon: Image(image: AssetImage('assets/img_4.png'),),
                icon: Icon(Icons.sticky_note_2_outlined),
                label: '글쓰기',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: '마이페이지',
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class AllPhotosScreen extends StatelessWidget {
  const AllPhotosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 0, 20), // 전체패딩
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '이번주 BEST 5!🎉',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontFamily: 'SUIT',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '이번 주에 가장 인기있었던 그림들을 만나보세요!',
                          style: TextStyle(
                            color: Color(0xFF9F9F9F),
                            fontSize: 11,
                            fontFamily: 'Apple SD Gothic Neo',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    Viewallbtn(),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                RowScrollPhotos(),
                Container(
                  height: 65,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            // width: 390,
            decoration: BoxDecoration(
                color: Color(0xffF6F6F6),
                border: Border(
                    top: BorderSide(color: Color(0xff444444), width: 0.2))),
            child: GridViewPhotos(num:0),
          )
        ],
      ),
    );
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
      ],
    );
  }
}

class RowScrollPhotos extends StatefulWidget {
  const RowScrollPhotos({Key? key}) : super(key: key);

  @override
  State<RowScrollPhotos> createState() => _RowScrollPhotosState();
}

class _RowScrollPhotosState extends State<RowScrollPhotos> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Widget>>(
      future: Best5(context,5), // Best5 함수 호출
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Future가 완료될 때까지 로딩 인디케이터를 표시
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // 데이터 가져오는 동안 오류가 발생하면 이곳에서 처리합니다.
          return Text('오류: ${snapshot.error}');
        } else {
          // Future가 성공적으로 완료되면, snapshot.data에서 위젯 목록에 접근
          List<Widget> best5Widgets = snapshot.data ?? []; // 데이터가 null일 경우 기본값 제공
          return SizedBox(
            height: 276,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: ScrollPhysics(),
              primary: true,
              child: Row(
                children: best5Widgets,
              ),
            ),
          );
        }
      },
    );

  }
}

class Viewallbtn extends StatelessWidget {
  const Viewallbtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      height: 18,
      width: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(11),
        image: DecorationImage(
            fit: BoxFit.cover, image: AssetImage('images/img_6.png')),
      ),
      child: FilledButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        ),
        onPressed: () {
          print("View all btn test");
        },
        child: Text(
          'View all',
          textAlign: TextAlign.center,
          style: (TextStyle(
            color: Colors.transparent,
            fontSize: 10,
            fontFamily: 'SUIT',
          )),
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

Future<List<Widget>> createPhotos(BuildContext context , int num) async {
  List<ContestPageData> urls=[];
  if (num==0) {
   urls = await getBoard();
  }

  else if (num==1) {
   urls = await getAIBoard();
  }
  else if (num==2) {
    urls = await getGeneralBoard();
  }
  print(urls);
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
    HeartButton heartButton = _createHeartButton(pagedata.id);
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
                Positioned(
                  child: _createHeartButton(urls[i].id),
                  top: 1,
                  right: 1,
                )
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

                      // CircleAvatar(
                      //   radius: 15, //
                      //   backgroundImage: NetworkImage(UserProfileImg[i],),
                      // ),
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

class HeartButton extends StatefulWidget {
  final Function(bool isLiked) onLiked;
  final BigInt postId;
  HeartButton({required this.onLiked, required this.postId}); //생성자

  @override
  _HeartButtonState createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton> {
  bool _isLiked = false;
  @override
  void initState() {
    super.initState();
    _loadLikedState(); // 위젯이 초기화될 때 좋아요 상태를 로드
  }
  Future<void> _loadLikedState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLiked = prefs.getBool(widget.postId.toString()) ?? false;
    });
  }

  Future<void> _saveLikedState(bool isLiked) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(widget.postId.toString(), isLiked);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xff2E5AEA),
          ),
        ),
        IconButton(
          icon: Icon(
            _isLiked ? Icons.favorite : Icons.favorite_border,
            color: _isLiked ? Colors.white : Colors.white,
          ),
          onPressed: () {
            print("button click");
            setState(() {
              print("button click2");
              _isLiked = !_isLiked;
              _saveLikedState(_isLiked); // 눌렸을 때 좋아요 상태 저장

              widget.onLiked(_isLiked);
            });
          },
        ),
      ],
    );
  }
}

class HeartButton2 extends StatefulWidget {
  final Function(bool isLiked) onLiked;
  HeartButton2({required this.onLiked});

  @override
  _HeartButton2State createState() => _HeartButton2State();
}

class _HeartButton2State extends State<HeartButton2> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0x802D59EA), // 0x80 투명도 50%
          ),
        ),
        IconButton(
          icon: Icon(
            _isLiked ? Icons.favorite : Icons.favorite_border,
            color: _isLiked ? Colors.white : Color(0xFFFFFF),
          ),
          onPressed: () {
            print("button click");
            print(_isLiked);
            setState(() {
              print("button click");
              print(_isLiked);
              _isLiked = !_isLiked;
              widget.onLiked(_isLiked);
            });
          },
        ),
      ],
    );
  }
}

Future<void> _makeLikeAPIRequest(BigInt postId) async {
  print(postId);

  final url = Uri.parse('http://54.180.79.174:8080/api/v1/heart/$postId');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var accessToken = prefs.getString('accessToken');
  try {
    print("좋아요 API 호출");
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=utf-8 ',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      // The like API call was successful.
      print('Like API call successful.');
    } else {
      // The like API call failed.
      print('Failed to like the post. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // An error occurred during the API call.
    print('Error while liking the post: $e');
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


class ContestData {
  final BigInt id;
  final String author;
  final String title;
  final String contents;
  final int viewCount;
  final List<String> photoList;
  final String createdDate;
  final String userImg;

  ContestData({
    required this.id,
    required this.author,
    required this.title,
    required this.contents,
    required this.viewCount,
    required this.photoList,
    required this.createdDate,
    required this.userImg,
  });
  String getTitle(){
    return title;
    // return utf8.decode(base64.decode(title));
  }
  String getContents(){
    return contents;

  }

  String getUserImg(){
    return userImg;

  }
}
Future<List<ContestPageData>> getGeneralBoard()  async {
  List<String> boardList = [];

  final url = Uri.parse('http://54.180.79.174:8080/api/v1/contest/all?boardType=일반');
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

  final url = Uri.parse('http://54.180.79.174:8080/api/v1/contest/all?boardType=AI');
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


Future<List<ContestPageData>> getBoard()  async {
  List<String> boardList = [];
  final url = Uri.parse(
      'http://54.180.79.174:8080/api/v1/contest/all');
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


Future<List<ContestData>> getTop5Image()  async {
  List<String> Best5ImgUrls = [];
  final url = Uri.parse(
      'http://54.180.79.174:8080/api/v1/contest/best');
  final response = await http.get(url);
  if(response.statusCode==200){
    final jsonData = json.decode(utf8.decode(response.bodyBytes));
    final data = jsonData['data'] as List<dynamic>;

    final List<ContestData> contestDataList = data.map((item) {
      return ContestData(
        id:BigInt.from(item['id']),
        author: item['author'],
        userImg: item['user_img'],
        title: item['title'],
        contents: item['contents'],
        viewCount: item['view_count'],
        photoList: List<String>.from(item['photo_list']),
        createdDate: item['created_date'],
      );
    }).toList();
    print(contestDataList);
    return contestDataList;

  } else {
    throw Exception('Failed to load contest data');
  }
}


Future<void> _makeDislikeAPIRequest(BigInt postId) async {
  final url = Uri.parse('http://54.180.79.174:8080/api/v1/unheart/$postId');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var accessToken = prefs.getString('accessToken');

  try {
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $accessToken',
      },
    );


    if (response.statusCode == 200) {
      // The dislike API 호출
      print('Dislike API call successful.');
    } else {
      // API 호출 실패
      print('Failed to dislike the post. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // An error occurred during the API call.
    print('Error while disliking the post: $e');
  }
}

HeartButton _createHeartButton(BigInt postId) {
  return HeartButton(
    postId: postId,
    onLiked: (bool isLiked) {
      print("onLiked callback executed with isLiked: $isLiked");
      if (isLiked) {
        print("Call the Like button");
        _makeLikeAPIRequest(postId);
      } else {
        _makeDislikeAPIRequest(postId);
      }
    },
  );
}

//Best5 image
Future<List<Widget>> Best5(BuildContext context,int numImg) async{
  List<Widget> Best5images = [];
  List<ContestData> Best5ImgUrls = await getTop5Image();
  List<String> images = [];
  List<String> PostTitle = [];
  List<String> PostContent = [];
  List<String> UserProfileImg = [];
  int j = 0;

  while (j < numImg && j < Best5ImgUrls.length) {
    for (String photoUrl in Best5ImgUrls[j].photoList) {
      images.add(photoUrl);
      HeartButton heartButton = _createHeartButton(Best5ImgUrls[j].id);

    }
    j++;
  }
  try{
    for (ContestData contestData in Best5ImgUrls) {
      PostTitle.add(contestData.getTitle());
      final koreanText=contestData.getTitle();
      final encodedKoreanText = base64.encode(utf8.encode(koreanText));
      print(encodedKoreanText);
      PostContent.add(contestData.getContents());
      UserProfileImg.add(contestData.getUserImg());

    }
  } catch (e) {
    print(e);
  }
  Widget image;
  int i = 0;
  while (i < numImg) {
    image = Stack(
      children: [
        Container(
          child: Image.asset('images/img_8.png'),
          height: 276,
          width: 233,
          margin: EdgeInsets.fromLTRB(0, 0, 26, 0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 0.5,
            ),

            borderRadius: BorderRadius.circular(22),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(images[i]) //Best5 사진 url
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 30,
          child: _createHeartButton(Best5ImgUrls[i].id), // HeartButton 적용
        ),
        Positioned(
            bottom: 20,
            left: 10,
            child: Container(
              width: 220,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
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
                      Container(
                        child: Text(
                          PostTitle[i],
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'SUIT',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        width: 160,
                        child: Text(
                          PostContent[i],
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'SUIT',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      print('BEST5 사진 버튼 test');
                    },
                    icon: ThinArrowIcon(size: 42, color: Colors.white),
                  ),
                ],
              ),
            ))
      ],
    );

    Best5images.add(image);
    i++;
  }
  return Best5images;
}

class ThinArrowIcon extends StatelessWidget {
  final double size;
  final Color color;

  ThinArrowIcon({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _ThinArrowIconPainter(color),
      ),
    );
  }
}

class _ThinArrowIconPainter extends CustomPainter {
  final Color color;

  _ThinArrowIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2.5 // 화살표 아이콘 두께 조절
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final double halfWidth = size.width / 2;
    final double halfHeight = size.height / 2;
    final double quarterWidth = size.width / 4;
    final double eighthHeight = size.height / 8;

    // Draw the arrow lines
    canvas.drawLine(Offset(eighthHeight, halfHeight),
        Offset(size.width - eighthHeight, halfHeight), paint);
    canvas.drawLine(Offset(size.width - eighthHeight, halfHeight),
        Offset(size.width - halfWidth, eighthHeight), paint);
    canvas.drawLine(Offset(size.width - eighthHeight, halfHeight),
        Offset(size.width - halfWidth, size.height - eighthHeight), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class AIPhotosScreen extends StatelessWidget {
  const AIPhotosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          Container(
            padding: EdgeInsets.all(20),
            width: 390,
            decoration: BoxDecoration(
                color: Color(0xffF6F6F6),
                border: Border(
                    top: BorderSide(color: Color(0xff444444), width: 0.2))),
            child: GridViewPhotos(num:1),
          ),

        ],
      ),
    );
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
    print("zz + $response");

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


class NormalPhotosScreen extends StatelessWidget {
  const NormalPhotosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [



          Container(
            padding: EdgeInsets.all(20),
            width: 390,
            decoration: BoxDecoration(
                color: Color(0xffF6F6F6),
                border: Border(
                    top: BorderSide(color: Color(0xff444444), width: 0.2))),
            child: GridViewPhotos(num:2),
          ),

        ],
      ),
    );
  }
}

//page가 동적으로 바뀌도록 해야하는거 아님?