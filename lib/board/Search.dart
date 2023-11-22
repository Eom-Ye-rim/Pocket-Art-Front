import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar_example/board/PhotoBoard.dart';
import 'package:flutter_ar_example/board/PostSearch.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(const Search());
}

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),

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
    ),
            body: Frame427320768(),
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
                MaterialPageRoute(builder: (context) => const PhotoBoard()),
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

class SearchResult {
    final String title;
    final String author;
    final String user_img;
    final int view_count;
    final int likecnt;
    final int comment_cnt;
    final String first_photo;


  SearchResult({required this.title, required this.author, required this.user_img,required this.view_count,
    required this.likecnt,required this.comment_cnt,required this.first_photo});

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      title: json['title'],
      author: json['author'],
      user_img: json['user_img'],
      view_count: json['view_count'],
      likecnt: json['likecnt'],
      comment_cnt: json['comment_cnt'],
      first_photo: json['first_photo'],

    );
  }
}

class Frame427320768 extends StatefulWidget {
  @override
  _Frame427320768State createState() => _Frame427320768State();
}

class _Frame427320768State extends State<Frame427320768> {
  List<String> searchHistory = [];
  TextEditingController searchController = TextEditingController();

  //하나씩 삭제
  void deleteSearchHistoryItem(String item) {
    searchHistory.remove(item);
    setState(() {});
  }

  // 전체 삭제
  void deleteAllSearchHistory() {
    searchHistory.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> searchHistoryWidgets = searchHistory.map((historyItem) {
      return Row(
        children: [
          Container(
            width: 80,
            height: 39,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 0.50, color: Color(0xFFDBDBDB)),
                borderRadius: BorderRadius.circular(19.50),
              ),
            ),
            child: Center(
              child: Text(
                historyItem,
                style: TextStyle(
                  color: Color(0xFF272727),
                  fontSize: 12,
                  fontFamily: 'Apple SD Gothic Neo',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              deleteSearchHistoryItem(historyItem);
            },
            child: Container(
              width: 30, // Adjust the size as needed
              height: 30, // Adjust the size as needed
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // Background color of the circle
              ),
              child: Center(
                child: Icon(
                  Icons.close,
                  size: 16, // Adjust the size as needed
                  color: Colors.black, // Icon color
                ),
              ),
            ),
          ),
        ],
      );
    }).toList();





    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Colors.white),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 390,
                    height: 46,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 308.67,
                          top: 17.33,
                          child: Container(
                            width: 66.66,
                            height: 11.34,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 42.33,
                                  top: 0,
                                  child: Container(
                                    width: 24.33,
                                    height: 11.33,
                                    child: Stack(children: [
                                    ]),
                                  ),
                                ),
                                // Positioned(
                                //   left: 22.03,
                                //   top: 0,
                                //   child: Container(
                                //     width: 15.27,
                                //     height: 10.97,
                                //     decoration: BoxDecoration(
                                //       image: DecorationImage(
                                //         image: NetworkImage("https://via.placeholder.com/15x11"),
                                //         fit: BoxFit.fill,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // Positioned(
                                //   left: 0,
                                //   top: 0.34,
                                //   child: Container(
                                //     width: 17,
                                //     height: 10.67,
                                //     decoration: BoxDecoration(
                                //       image: DecorationImage(
                                //         image: NetworkImage("https://via.placeholder.com/17x11"),
                                //         fit: BoxFit.fill,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 18,
                  top: 352,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                    child: Row(
                      children: [
                        // Your search history widgets here
                        ...searchHistoryWidgets,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 337,
                  top: 248,
                  child: Container(
                    width: 31,
                    height: 31,
                    padding: const EdgeInsets.all(3.88),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 22,
                  top: 122,
                  child: SizedBox(
                    width: 238,
                    height: 83,
                    child: Text(
                      '무엇을\n찾고 계신가요?👀',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontFamily: 'Apple SD Gothic Neo',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 22,
                  top: 250,
                  child: SizedBox(
                    width: 300,
                    height: 251,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '검색어를 입력하세요',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      controller: searchController,
                    ),
                  ),
                ),
                Positioned(
                  left: 337,
                  top: 250,
                  child: GestureDetector(
                    onTap: () async {
                      print("검색 버튼 클릭됨");
                      String searchText = searchController.text;
                      if (searchText.isNotEmpty) {
                        searchHistory.add(searchText);
                        searchController.clear();
                        setState(() {});

                        Uri uri = Uri.parse(
                            'http://54.180.79.174:8080/api/v1/contest/all');
                        final response = await http.post(
                          uri,
                          headers: {
                            'Content-Type': 'application/json; charset=UTF-8',
                            // Specify JSON content type
                          },
                          body: json.encode({
                            "title": searchText,
                            "content": "",
                            "writer": "",
                          }),
                        );

                        if (response.statusCode == 200) {
                          print("success");

                          final Map<String, dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
                          final List<dynamic> searchResultsData = jsonResponse['content'] as List<dynamic>;

                          List<SearchResult> searchResults = searchResultsData
                              .map((data) => SearchResult.fromJson(data))
                              .toList();

                          print("searchResults: $searchResults");

                            // Navigate to the PostSearch() screen and pass the searchResults
                          for (SearchResult result in searchResults) {
                            print(result);
                            print("Title: ${result.title}");
                            print("Author: ${result.author}");
                            // Print other properties as needed
                          }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PostSearch(searchResults: searchResults),
                              ),
                            );
                          } else {
                            // Handle errors here
                            print("HTTP request failed with status ${response
                                .statusCode}");
                          }
                        }
                    },


                  // onTap: () {
                    //   print("검색 버튼 클릭됨");
                    //   String searchText = searchController.text;
                    //   if (searchText.isNotEmpty) {
                    //     searchHistory.add(searchText);
                    //     searchController.clear();
                    //     setState(() {});
                    //   }
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => PostSearch()), // Replace CreatePostPage with your actual page name.
                    //   );
                    //   // 여기에서 원하는 페이지로 이동하도록 수정
                    // },
                    child: Container(
                      width: 35,
                      height: 35,
                      padding: const EdgeInsets.all(3.88),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('images/search.png'),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 23,
                  top: 317,
                  child: Text(
                    '검색기록',
                    style: TextStyle(
                      color: Color(0xFF272727),
                      fontSize: 13,
                      fontFamily: 'Apple SD Gothic Neo',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

        if (searchHistory.isNotEmpty) // Only show "모두삭제" when there are items
              Positioned(
                left: 315,
                top: 317,
                child: GestureDetector(
                  onTap: () {
                    deleteAllSearchHistory();
                  },
                  child: Text(
                    '모두삭제',
                    style: TextStyle(
                      color: Color(0xFF242424),
                      fontSize: 13,
                      fontFamily: 'Apple SD Gothic Neo',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
                Positioned(
                  left: 22,
                  top: 282,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 44,
                    height: 1.50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/Line.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                  ],
            ),

          ),

        ],
      ),
    );

  }


}
