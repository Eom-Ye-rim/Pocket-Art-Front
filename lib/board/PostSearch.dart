
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'CreatePost.dart';
import 'Search.dart';

// ignore_for_file: prefer_const_constructors


void main() {

  List<SearchResult> searchResults = []; // Initialize with your search results
  runApp(MaterialApp(
    home: PostSearch(searchResults: searchResults),
    debugShowCheckedModeBanner: false,

  ));
}

class PostSearch extends StatefulWidget {
  final List<SearchResult> searchResults;

  const PostSearch({Key? key, required this.searchResults}) : super(key: key);


  @override
  State<PostSearch> createState() => _PostSearchState();
}

class _PostSearchState extends State<PostSearch> {


  TextEditingController _searchController = TextEditingController();

  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
      // 첫 번째 탭을 클릭했을 때의 작업

      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => const PostSearch()),
      //   );

        break;
      case 1:
      // 두 번째 탭을 클릭했을 때의 작업
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreatePost()),
        );

        break;
      case 2:
      // 세 번째 탭을 클릭했을 때의 작업
      // 마이페이지

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
          automaticallyImplyLeading: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,

          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,
            color: Colors.black,),
            onPressed: () {
              //뒤로가기
              Navigator.pop(context);
            },
          ),

          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 330,
                child: TextFormField(
                  onFieldSubmitted: (String value) { //사용자가 엔터 누르면 호출됨
                    // 여기에 사용자가 입력 완료했을 때 이벤트 추가
                    print('입력받은 문자열 test: $value');
                  },

                  controller: _searchController,
                  decoration: InputDecoration(
                    // labelText: 'Search',
                    hintText: '검색어를 입력하세요.',
                    suffixIcon: IconButton(
                      onPressed: () {
                        _searchController.clear();
                      },
                      icon: Icon(Icons.clear),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Color(0xff0066FF),
            unselectedItemColor: Color(0xff484848),
            // showSelectedLabels: false, //아이콘 밑에 라벨 유무
            // showUnselectedLabels: false, // 라벨 유무
            onTap: onTabTapped,
            currentIndex: _currentIndex,

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
                icon: Icon(Icons.person),
                label: '마이페이지',
              ),
            ],
          ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                // width: 390,
                decoration: BoxDecoration(
                    color: Color(0xffF6F6F6),
                    border: Border(
                        top: BorderSide(color: Color(0xff444444), width: 0.2))),
                child: GridViewPhotos(searchResults: widget.searchResults)
              ),

            ],
          ),
        )

      ),

    );
  }
}
class GridViewPhotos extends StatefulWidget {
  final List<SearchResult> searchResults;

  GridViewPhotos({required this.searchResults});

  @override
  State<GridViewPhotos> createState() => _GridViewPhotosState();
}

class _GridViewPhotosState extends State<GridViewPhotos> {
  List<Widget> images = [];

  @override
  void initState() {
    super.initState();
    images = createPhotos(widget.searchResults);
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


List<Widget> createPhotos(List<SearchResult> searchResults) {

  List<Widget> images = [];
  List<String> urls = [];
  List<String> UserProfileImg = [];
  List<String> PostTitle = [];
  List<int> comment_cnt=[];
  List<int> like_cnt=[];
  List<int> view_cnt=[];
  print(searchResults.length);
  for (SearchResult result in searchResults) {
    urls.add(result.first_photo);
    UserProfileImg.add(result.user_img);
    PostTitle.add(result.title);
    view_cnt.add(result.view_count);
    comment_cnt.add(result.comment_cnt);
    like_cnt.add(result.likecnt);
    // Create Card widgets based on searchResults
    // ...
  }


  for (int i = 0; i < urls.length; i++) {
    Widget image = Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey, width: 1)),
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
                Positioned(
                  child: HeartButton(),
                  top: 1,
                  right: 1,
                )
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15, //
                    backgroundImage: NetworkImage(UserProfileImg[i]),
                  ),
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
            Row(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.remove_red_eye_outlined,
                      size: 15,
                      color: Color(0xffBDBDBD),
                    ),
                    Text(

                      view_cnt[i].toString(),
                      style: TextStyle(
                        color: Color(0xffBDBDBD),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      size: 15,
                      color: Color(0xffBDBDBD),
                    ),
                    Text(

                      comment_cnt[i].toString(),
                      style: TextStyle(
                        color: Color(0xffBDBDBD),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 15,
                      color: Color(0xffBDBDBD),
                    ),
                    Text(
                      like_cnt[i].toString(),
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
          ],
        ),
      ),
    );

    images.add(image);
  }
  return images;
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
            color: _isLiked ? Colors.white : Colors.white,
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
