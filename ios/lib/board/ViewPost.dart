import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// ignore_for_file: prefer_const_constructors


void main() {
  runApp(const ViewPost());
}

class Comment {
  static int _nextId = 1;
  final int id;
  final String content;
  final String author;
  final DateTime timestamp;

  Comment({
    required this.id,
    required this.content,
    required this.author,
    required this.timestamp,
  });

// Comment({
//   required this.content,
//   required this.author,
//   required this.timestamp,
// }) : id = _nextId++;
}

class ViewPost extends StatefulWidget {
  const ViewPost({Key? key}) : super(key: key);

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  String PostUserName = 'username123';
  String TimeStamp = '1111.22.33일 44:55';
  int Views = 1234; // 조회수 최대 4자리까지 가능( 5자리부터는 overflow 에러 나도록 화면 범위 설정돼있음)
  int like = 56;
  int Comments = 78;
  String CommentUserName = 'user789';

  TextEditingController _commentController = TextEditingController();
  List<Comment> comments = [];

  // 선택한 댓글의 ID를 저장하는 변수, null값으로 초기화
  int? selectedCommentId;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 리본 없애기
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
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
                                'https://www.qrart.kr:491/wys2/file_attach/2017/08/04/1501830205-47.jpg'))),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 19,
                            //유저 프로필 이미지 url
                            backgroundImage: NetworkImage(
                                'https://www.qrart.kr:491/wys2/file_attach/2017/08/04/1501830205-47.jpg'),
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
                          SizedBox(
                            width: 164,
                          ),
                          IconButton(
                            icon: Icon(Icons.linear_scale),
                            onPressed: () {
                              print('팝업메뉴 버튼');
                            },
                          ),
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
                            '내가 만든 사진',
                            style: TextStyle(
                              color: Color(0xFF626262),
                              fontSize: 24,
                              fontFamily: 'SUIT',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 144,
                          ),
                          Icon(
                            Icons.remove_red_eye_outlined,
                            color: Color(0xffAAAAAA),
                            size: 14,
                          ),
                          Text(
                            Views.toString(),
                            style: TextStyle(
                              color: Color(0xffAAAAAA),
                              fontSize: 10,
                              fontFamily: 'SUIT',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 11),
                      ExpandableTextWidget(),
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
                          ChipListWidget(),
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
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    Comment comment = comments[index];
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
                          backgroundImage: NetworkImage(
                              'https://www.qrart.kr:491/wys2/file_attach/2017/08/04/1501830205-47.jpg'), // 사용자 프로필 이미지 경로로 변경
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
                    backgroundImage: NetworkImage(
                        'https://www.qrart.kr:491/wys2/file_attach/2017/08/04/1501830205-47.jpg'), // 사용자 프로필 이미지 경로로 변경
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
                          )),
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
                      onPressed: () {
                        if (_commentController.text.isNotEmpty) {
                          if (selectedCommentId != null) {
                            // 댓글 수정 동작
                            final Comment updatedComment = Comment(
                              id: selectedCommentId!, // 선택한 댓글의 ID
                              content: _commentController.text,
                              author: PostUserName, // 사용자 이름 설정
                              timestamp: DateTime.now(),
                            );

                            // 수정된 댓글로 업데이트
                            setState(() {
                              final index = comments
                                  .indexWhere((c) => c.id == selectedCommentId);
                              if (index != -1) {
                                comments[index] = updatedComment;
                              }
                              selectedCommentId = null; // 선택한 댓글 ID 초기화
                              _commentController.clear();
                            });
                          } else {
                            // 새로운 댓글 추가 동작
                            Comment newComment = Comment(
                              id: comments.length + 1, // 고유 ID 부여
                              content: _commentController.text,
                              author: PostUserName, // 사용자 이름 설정
                              timestamp: DateTime.now(),
                            );

                            setState(() {
                              comments.add(newComment);
                              _commentController.clear();
                            });
                          }
                        }
                      },
                      child: Text(selectedCommentId != null
                          ? '수정'
                          : '입력',
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}

class ExpandableTextWidget extends StatefulWidget {
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
    final String postString =
        "라 인생의 생의 듣기만 약동하다. 있는 아니한 예수는 청춘의 교향악이다. 피가 는 이상의 장식하는 듣는다. 거선의 같이, 이상의 무엇이 것이다. 같이, 열매가 것이다. 가는 생명을 인간의 것이다다. 피가 이상의 장식하는 듣는다. 거선의 같이, 이상의 무엇이 것이다. 같이, 열매가 것이다. 가는 생명을 인간의 것이다. 위하여 얼마나 가나다라 마바사 용기가 없는 것이다. 라 인생의 생의 듣기만 약동하다. 있는 아니한 예수는 청춘의 교향악이다. 피가 는 이상의 장식하는 듣는다. 거선의 같이, 이상의 무엇이 것이다. 같이, 열매가 것이다. 가는 생명을 인간의 것이다다. 피가 이상의 장식하는 듣는다. 거선의 같이, 이상의 무엇이 것이다. 같이, 열매가 것이다. 가는 생명을 인간의 것이다. 위하여 얼마나 가나다라 마바사 용기가 없는 것이다.";

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
  final List<String> stringList = [
    'Tag 111',
    'Tag 2222',
    'AR사진입니다',
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: stringList.map((tag) {
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
