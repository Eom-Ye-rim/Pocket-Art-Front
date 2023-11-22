import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ar_example/board/PhotoBoard.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Comment {
  static int _nextId = 1;
  final int id;
  final String content;
  final String author;
  final String profileImg;
  final DateTime timestamp;

  Comment({
    required this.id,
    required this.content,
    required this.author,
    required this.profileImg,
    required this.timestamp,
  });

}

class ViewPost extends StatefulWidget {
  final dynamic responseData;

  const ViewPost({Key? key, required this.responseData}) : super(key: key);

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  Future<void> fetchComments(List<dynamic> commentDataList) async {

    final List<Comment> fetchedCommentList = commentDataList.map((commentData) {
      return Comment(
        id: commentData['id'],
        content: commentData['content'],
        author: commentData['author'],
        profileImg: commentData['users']['profileImg'],
        timestamp: DateTime.parse(commentData['createDate']),
      );
    }).toList();

    setState(() {
      comments = fetchedCommentList;
    });
  }


  String PostUserName = '';
  String PostTitle = '';
  String TimeStamp = '';

  int Views =0; // 조회수 최대 4자리까지 가능( 5자리부터는 overflow 에러 나도록 화면 범위 설정돼있음)
  int like = 0;
  int Comments = 0;
  String CommentUserName = '';
  String postString = '';
  List<String> photolist=[];
  String user_img='';
  List<Comment> comments = [];
  List<String> taglist=[];
  @override
  void initState() {
    super.initState();
    // Initialize postString with the responseData contents if available
    if (widget.responseData!=null) {
      print(widget.responseData);
      postString = widget.responseData['data']['contents'];
      PostUserName = widget.responseData['data']['author'];
      Views = widget.responseData['data']['view_count'];
      PostTitle = widget.responseData['data']['title'];
      photolist = (widget.responseData['data']['photo_list'] as List<dynamic>?)?.cast<String>() ?? [];
      user_img = widget.responseData['data']['user_img'];

      final List<dynamic> commentDataList = widget.responseData['data']['comment_list'];
      fetchComments(commentDataList);

      TimeStamp = widget.responseData['data']['created_date'];
      taglist = (widget.responseData['data']['tag_list'] as List<dynamic>?)?.cast<String>() ?? [];

      print("실행");
    }
  }

  TextEditingController _commentController = TextEditingController();

  // 선택한 댓글의 ID를 저장하는 변수, null값으로 초기화
  int? selectedCommentId;

  @override
  Widget build(BuildContext context) {

        return MaterialApp(
    home: DefaultTabController(
    // 상단 탭 만들기 위해서 DefaultTabController로 감싸줘야함
    length: 3, //탭 갯수
    child: Scaffold(
    appBar: AppBar(
    leading:gotoMainBtn(),
    title: Text(
    '게시물 보기',

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

    },
    icon: Icon(Icons.list),
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
    ),

        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(17, 17, 17, 17),
                  child: Column(
                    children: [
                      Container(
                        height: 356,
                        width: 356,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover, image: NetworkImage(
                              // 게시글 사진 url
                                photolist[0]))),
                      ),

                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                              radius: 19,
                              backgroundImage: NetworkImage(user_img),
                              backgroundColor: Colors.transparent, // 이 부분은 제거
                              foregroundColor: Colors.transparent,
                            ),

                          SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                PostUserName,
                                style: TextStyle(
                                  color: Color(0xFF626262),
                                  fontSize: 15,
                                  fontFamily: 'SUIT',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                TimeStamp,
                                style: TextStyle(
                                  color: Color(0xFFAAAAAA),
                                  fontSize: 10,
                                  fontFamily: 'SUIT',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),

                          // IconButton(
                          //   icon: Icon(Icons.linear_scale),
                          //   onPressed: () {
                          //     print('팝업메뉴 버튼');
                          //   },
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'images/img_9.png',
                            width: 17,
                            height: 38,
                          ),
                          SizedBox(
                            width: 19,
                          ),
                          Text(
                            PostTitle,
                            style: TextStyle(
                              color: Color(0xFF626262),
                              fontSize: 24,
                              fontFamily: 'SUIT',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          // SizedBox(
                          //   width: 114,
                          // ),
                            // Padding(
                            //   padding: EdgeInsets.only(right: 10), // 원하는 여백 값으로 설정
                            //   child: Icon(
                            //     Icons.remove_red_eye_outlined,
                            //     color: Color(0xffAAAAAA),
                            //     size: 14,
                            //   ),
                            // ),
                          // Text(
                          //   Views.toString(),
                          //   style: TextStyle(
                          //     color: Color(0xffAAAAAA),
                          //     fontSize: 10,
                          //     fontFamily: 'SUIT',
                          //     fontWeight: FontWeight.w400,
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(height: 11),
                      ExpandableTextWidget(postString: postString),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 3),
                            margin: EdgeInsets.only(right: 5),
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: Color(0xffB0C2FF), // Border color
                                width: 1, // Border width
                              ),
                            ),
                            child: Image.asset(
                              'images/img_10.png',
                              width: 8,
                              height: 8,
                            ),
                          ),
                          ChipListWidget(tags: taglist),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(9, 0, 17, 0),
                  height: 50,
                  width: 390,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffD7D7D7),
                        width: 1,
                      )),
                  child: Row(
                    children: [
                      HeartButton(),
                      Text(
                        like.toString() + 'likes',
                        style: TextStyle(
                          color: Color(0xFFAAAAAA),
                          fontSize: 11,
                          fontFamily: 'SUIT',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 28,
                      ),
                      Icon(
                        Icons.messenger_outline_sharp,
                        size: 23,
                        color: Color(0xff565656),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        Comments.toString(),
                        style: TextStyle(
                          color: Color(0xFFAAAAAA),
                          fontSize: 11,
                          fontFamily: 'SUIT',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 169,
                      ),
                      ShareButton()
                    ],
                  ),
                ),

                // 댓글 목록
                ListView.builder(
                  itemCount: comments.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {

                    Comment comment = comments[index]; //comment_list 불러오도록 수정
                    return Container(
                      decoration: ShapeDecoration(
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          side:
                          BorderSide(width: 0.50, color: Color(0xffCFCFCF)),
                        ),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 19,
                          backgroundImage: NetworkImage(user_img),
                          backgroundColor: Colors.transparent, // 이 부분은 제거
                          foregroundColor: Colors.transparent,
                        ),
                        title: Text(
                          comment.author,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'SUIT',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          comment.content,
                          style: TextStyle(
                            color: Color(0xff999999),
                            fontSize: 14,
                            fontFamily: 'SUIT',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: PopupMenuButton<int>(
                          itemBuilder: (context) => [
                            PopupMenuItem<int>(
                              value: 0,
                              child: Text('수정하기',
                                style: TextStyle(
                                  color: Color(0xFF949494),
                                  fontSize: 13,
                                  fontFamily: 'SUIT',
                                  fontWeight: FontWeight.w400,
                                ),),
                            ),
                            PopupMenuItem<int>(
                              value: 1,
                              child: Text('삭제하기',
                                style: TextStyle(
                                  color: Color(0xFF949494),
                                  fontSize: 13,
                                  fontFamily: 'SUIT',
                                  fontWeight: FontWeight.w400,
                                ),),
                            ),
                          ],
                          onSelected: (value) {
                            if (value == 0) {
                              // 수정 버튼을 눌렀을 때 실행할 동작
                              setState(() {
                                selectedCommentId = comment.id; // 수정할 댓글 ID 설정
                                _commentController.text =
                                    comment.content; // 수정할 내용을 입력 필드에 설정
                              });
                            } else if (value == 1) {
                              // 삭제 버튼을 눌렀을 때 실행할 동작
                              setState(() {
                                comments.removeWhere(
                                        (c) => c.id == comment.id); // 해당 ID의 댓글 삭제
                              });
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),

        bottomNavigationBar: BottomAppBar(
          child: Container(
              width: 390,
              decoration: ShapeDecoration(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 0.50, color: Color(0xffCFCFCF)),
                ),
              ),
              padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
              child: Row(
                children: [
              CircleAvatar(
                    radius: 19,
                    backgroundImage: NetworkImage(user_img),
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.transparent,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      controller: _commentController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '댓글을 입력하세요...',
                        hintStyle: TextStyle(
                          color: Color(0xffC1C1C1),
                        ),
                      ),
                      onEditingComplete: () {
                        // 입력 완료 시 실행할 동작
                        // 포커스를 해제하면 키보드가 숨겨집니다.
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ),
                  Container(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff4A61DE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                        onPressed: () async{
                          if (_commentController.text.isNotEmpty) {
                            if (selectedCommentId != null) {
                              // 댓글 수정 동작
                              final Comment updatedComment = comments.firstWhere((c) => c.id == selectedCommentId);
                              // 수정된 댓글로 업데이트
                              setState(() {
                                final index = comments.indexWhere((c) => c.id == selectedCommentId);
                                if (index != -1) {
                                  comments[index] = updatedComment;
                                }
                                selectedCommentId = null; // 선택한 댓글 ID 초기화
                              });
                            } else {

                                final response = await addComment(widget.responseData['data']['id'], _commentController.text);
                                if (response != null) {
                                setState(() {
                                print("호출");
                                comments.add(response);
                                _commentController.clear();
                                });
                              }
                            }
                          }
                        },

                        child: Text(selectedCommentId != null
                            ? '수정'
                            : '입력',)
                    )
                  )
                ],
              )),
        ),
      ),
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
class ExpandableTextWidget extends StatefulWidget {
  final String postString; // Add this line


  ExpandableTextWidget({required this.postString, Key? key}) : super(key: key);
  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  bool expanded = false;

  void toggleExpanded() {
    setState(() {
      expanded = !expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String postString = widget.postString;


    return Container(
      width: 356,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            postString,
            overflow: expanded ? TextOverflow.visible : TextOverflow.fade,
            softWrap: true,
            maxLines: expanded ? null : 7,
            style: TextStyle(
              color: Color(0xFF707070),
              fontSize: 17,
              fontFamily: 'SUIT',
              fontWeight: FontWeight.w300,
              height: 1.29,
            ),
          ),
          if (postString.length > 300) // 문자열 길이 조절
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: toggleExpanded,
                child: Text(
                  expanded ? '더보기 닫기' : '+더보기',
                  style: TextStyle(
                    color: Color(0xFF5967D5),
                    fontSize: 16,
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ChipListWidget extends StatelessWidget {
  final List<String> tags; // Add this line
  ChipListWidget({required this.tags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: tags.map((tag) {
        return Chip(
          labelStyle: TextStyle(
            color: Color(0xFF7F7F7F),
            fontSize: 10,
            fontFamily: 'SUIT',
            fontWeight: FontWeight.w500,
          ),
          label: Text(tag),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color(0xffB0C2FF), width: 1),
            borderRadius: BorderRadius.circular(19.5),
          ),
        );
      }).toList(),
    );
  }
}

class HeartButton extends StatefulWidget {
  const HeartButton({Key? key}) : super(key: key);

  @override
  State<HeartButton> createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isLiked = !_isLiked;
        });
      },
      borderRadius: BorderRadius.circular(15),
      child: Container(
        margin: EdgeInsets.only(right: 10),
        width: 26,
        height: 40,
        child: Center(
          child: IconButton(
            icon: Icon(
              _isLiked ? Icons.favorite : Icons.favorite_border,
              size: 26,
              color: _isLiked ? Color(0xff3D3D3D) : Color(0xff565656),
            ),
            onPressed: () {
              setState(() {
                _isLiked = !_isLiked;
              });
            },
          ),
        ),
      ),
    );
  }
}

class ShareButton extends StatelessWidget {
  const ShareButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: IconButton(
          icon: Icon(
            Icons.share,
            size: 26,
            color: Color(0xff3D3D3D),
          ),
          onPressed: () {
            print('공유버튼');
          },
        ));
  }
}

Future<Comment> addComment(int postId, String commentContent) async {
  final dio = Dio();
  final url = 'http://54.180.79.174:8080/api/v1/comment/$postId';

  try {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    // 인증 헤더 설정
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.post(
      url,
      data: {'content': commentContent}, // 요청 바디에 데이터 추가
    );

    if (response.statusCode == 200) {
      // 서버 응답이 성공인 경우
      final responseData = response.data; // JSON 데이터를 Map으로 가져옴
      print("responseDate + $responseData");
      // JSON 데이터를 Comment 객체로 파싱
      Comment newComment = Comment(
        id: responseData['data']['id'], // 고유 ID 부여
        content: responseData['data']['author'],
        author: responseData['data']['content'], // 사용자 이름 설정
        profileImg: responseData['data']['userImg'],
        timestamp: DateTime.now(),
      );

      return newComment;
    } else {
      // 서버 응답이 실패인 경우
      // 오류 처리 코드 추가
      return Future.error('Failed to add comment: ${response.statusCode}');
    }
  } catch (e) {
    // 오류 처리 코드 추가
    return Future.error('Error adding comment: $e');
  }
}



