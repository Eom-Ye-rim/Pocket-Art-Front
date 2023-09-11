
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar_example/board/PhotoBoard.dart';
import 'package:flutter_ar_example/ARScreen.dart';

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

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
      // 첫 번째 탭을 클릭했을 때의 작업

        break;
      case 1:
      // 두 번째 탭을 클릭했을 때의 작업
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Choice()),
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


//#우와.. AI가 만든 사진이야 <--- 이 부분 관련
List<Widget> Post_1(int numImg) {
  List<Widget> Post_1images = [];
  List<String> Post_1ImgUrls = [];
  Post_1ImgUrls.add(
      'https://upload.wikimedia.org/wikipedia/commons/f/fe/Vincent_van_Gogh_-_Sunflowers_%281888%2C_National_Gallery_London%29.jpg');
  Post_1ImgUrls.add(
      'https://www.qrart.kr:491/wys2/file_attach/2017/08/04/1501830205-47.jpg');
  Post_1ImgUrls.add(
      'https://seoartgallery.com/wp-content/uploads/2016/07/%EB%B0%98%EA%B3%A0%ED%9D%90-%EC%B4%88%EC%83%81%ED%99%94-633x767.jpg');
  Post_1ImgUrls.add(
      'https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/201503/10/htm_201503101403340104011.jpg');
  Post_1ImgUrls.add(
      'https://upload.wikimedia.org/wikipedia/commons/f/fe/Vincent_van_Gogh_-_Sunflowers_%281888%2C_National_Gallery_London%29.jpg');


  List<String> Post_1Title = [];
  Post_1Title.add('제목1 ');
  Post_1Title.add('제목2 ');
  Post_1Title.add('제목3 ');
  Post_1Title.add('제목4 ');
  Post_1Title.add('제목5 ');


  Widget image;
  int i = 0;
  while (i < numImg) {
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
                image: NetworkImage(Post_1ImgUrls[i]) //Best5 사진 url
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

    Post_1images.add(image);
    i++;
  }
  return Post_1images;
}


// #이게 내가 찍은 사진이라고? <---- 아부분 관련
List<Widget> Post_2(int numImg) {
  List<Widget> Post_2images = [];
  List<String> Post_2ImgUrls = [];
  Post_2ImgUrls.add(
      'https://upload.wikimedia.org/wikipedia/commons/f/fe/Vincent_van_Gogh_-_Sunflowers_%281888%2C_National_Gallery_London%29.jpg');
  Post_2ImgUrls.add(
      'https://www.qrart.kr:491/wys2/file_attach/2017/08/04/1501830205-47.jpg');
  Post_2ImgUrls.add(
      'https://seoartgallery.com/wp-content/uploads/2016/07/%EB%B0%98%EA%B3%A0%ED%9D%90-%EC%B4%88%EC%83%81%ED%99%94-633x767.jpg');
  Post_2ImgUrls.add(
      'https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/201503/10/htm_201503101403340104011.jpg');
  Post_2ImgUrls.add(
      'https://upload.wikimedia.org/wikipedia/commons/f/fe/Vincent_van_Gogh_-_Sunflowers_%281888%2C_National_Gallery_London%29.jpg');


  List<String> Post_2Title = [];
  Post_2Title.add('제목1 ');
  Post_2Title.add('제목2 ');
  Post_2Title.add('제목3 ');
  Post_2Title.add('제목4 ');
  Post_2Title.add('제목5 ');


  Widget image;
  int i = 0;
  while (i < numImg) {
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
                image: NetworkImage(Post_2ImgUrls[i]) //Best5 사진 url
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

    Post_2images.add(image);
    i++;
  }
  return Post_2images;
}

class RowScrollPhotos_1 extends StatefulWidget {
  const RowScrollPhotos_1({Key? key}) : super(key: key);

  @override
  State<RowScrollPhotos_1> createState() => _RowScrollPhotos_1State();
}

class _RowScrollPhotos_1State extends State<RowScrollPhotos_1> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 171,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: ScrollPhysics(),
          primary: true,
          child: Row(
            children: Post_1(5),
          ),
        ));
  }
}


class RowScrollPhotos_2 extends StatefulWidget {
  const RowScrollPhotos_2({Key? key}) : super(key: key);

  @override
  State<RowScrollPhotos_2> createState() => _RowScrollPhotos_2State();
}

class _RowScrollPhotos_2State extends State<RowScrollPhotos_2> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 171,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: ScrollPhysics(),
          primary: true,
          child: Row(
            children: Post_2(5),
          ),
        ));
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


