import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar_example/board/PhotoBoard.dart';

import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../mainpage/MainPage.dart';
import 'ViewPost.dart';

// ignore_for_file: prefer_const_constructors
final GlobalKey<_TagInputChipState> tagInputChipKey =
    GlobalKey<_TagInputChipState>();

void main() {
  runApp(const CreatePost());
}

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  XFile? _pickedFile;
  String title = "";
  String contents = "";
  String type = "";
  String selectedStyle = "";
  List<String> hashtag = [];

  void _addTag(String tag) {
    setState(() {
      hashtag.add(tag); // Update the hashtag list
    });
  }

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentsController = TextEditingController();
  TextEditingController _tagController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      // 상단 탭 만들기 위해서 DefaultTabController로 감싸줘야함
      length: 3, //탭 갯수
      child: Scaffold(
        appBar: AppBar(
          leading: gotoMainBtn(),
          title: Text(
            '게시물 작성',
            style: TextStyle(
              color: Color(0xFF484848),
              fontSize: 20,
              fontFamily: 'SUIT',
              fontWeight: FontWeight.w700,
            ),
          ),

          actions: <Widget>[
            IconButton(
              onPressed: () {},
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

        // home: Scaffold(
        //   appBar: AppBar(
        //     systemOverlayStyle: SystemUiOverlayStyle(
        //       statusBarIconBrightness: Brightness.dark,
        //       statusBarBrightness: Brightness.light,
        //     ),
        //     automaticallyImplyLeading: false,
        //     backgroundColor: Colors.transparent,
        //     elevation: 0.0,
        //     leading:gotoMainBtn(),
        //     title: Row(
        //
        //       children: [
        //
        //         // Icon(
        //         //   Icons.edit_note, //
        //         //   color: Color(0xFF727272), // 아이콘 색상
        //         // ),
        //
        //         Text(
        //           '게시물 작성',
        //           style: TextStyle(
        //             color: Color(0xFF727272),
        //             fontSize: 22,
        //             fontFamily: 'SUIT',
        //             fontWeight: FontWeight.w700,
        //           ),
        //         ),
        //
        //       IconButton(
        //         onPressed: () {
        //         },
        //         icon: Icon(Icons.menu),
        //         color: Color(0xff626262),
        //       )
        //       ],
        //     ),
        //
        //   ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(21),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 346,
                  height: 346,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.50, color: Colors.grey),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      print("사진 추가 ");
                      var picker = ImagePicker();
                      var image =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        setState(() {
                          _pickedFile = image;
                        });
                      }
                    },
                    child: _pickedFile != null
                        ? Container(
                            width: 346,
                            height: 346,
                            child: Image.file(
                              File(_pickedFile!.path),
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            width: 346,
                            height: 346,
                            color: Colors.transparent, // 빈 상자 채우기용
                            child: Icon(
                              Icons.camera_alt_outlined,
                              size: 30,
                              color: Color(0xff4A61DE),
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: 26,
                ),
                Text(
                  '제목',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(13, 0, 13, 0),
                    width: 346,
                    height: 55,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.50, color: Colors.grey),
                      ),
                    ),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          title =
                              value; // Set the title variable when the user enters a title
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '제목을 입력하세요.',
                      ),
                    )),
                SizedBox(
                  height: 35,
                ),
                Text(
                  '내용',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(13, 0, 13, 0),
                  width: 346,
                  height: 163,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.50, color: Colors.grey),
                    ),
                  ),
                  child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          contents =
                              value; // Set the title variable when the user enters a title
                        });
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      maxLength: 800,
                      decoration: InputDecoration(
                        hintText: '내용을 입력하세요.',
                        border: InputBorder.none,
                      )),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  '화풍',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                CustomToggleButtons(
                  onChanged: (index) {
                    setState(() {
                      selectedStyle = index == 0 ? "동양" : "서양";
                    });
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  '카테고리',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                CustomCategoryToggleButtons(
                  onCategoryChanged: (index) {
                    setState(() {
                      type = index == 0 ? "AI" : "일반";
                    });
                  },
                ),
                SizedBox(
                  height: 42,
                ),
                Text(
                  '태그설정',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'SUIT',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                TagInputChip(
                  onAddTag: _addTag, // Pass the _addTag function
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: FilledButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFF363636),
                      ),
                    ),
                    onPressed: () {
                      // Call your upload function here
                      _uploadPost(hashtag);

                      // After uploading, navigate to the search route
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         ViewPost(), // Replace SearchRoute with the actual route you want to navigate to
                      //   ),
                      // );
                    },
                    child: Center(
                      child: Text(
                        '업로드',
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
        ),
      ),
    ));
  }

  Future<void> _uploadPost(List<String> hashtag) async {
    print("Register post");
    final dio = Dio();
    final url = 'http://13.209.160.87:8080/api/v1/contest';

    print(title);
    print(contents);
    print(selectedStyle);
    print(type);
    print(hashtag);
    final hashtagString = hashtag.join(',');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('accessToken');

    // Create FormData containing contestRequest data
    final formData = FormData();

    // Add simple fields
    formData.fields.add(MapEntry('title', title));
    formData.fields.add(MapEntry('contents', contents));
    formData.fields.add(MapEntry('style', selectedStyle));
    formData.fields.add(MapEntry('type', type.toString()));
    formData.fields.add(MapEntry('hashtag', hashtagString));

    if (_pickedFile != null) {
      // Add the image file
      formData.files.add(MapEntry(
        'files',
        await MultipartFile.fromFile(_pickedFile!.path),
      ));
    }

    // Set the authorization header
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    try {
      final response = await dio.post(
        url,
        data: formData,
        options: Options(
          contentType:
              'multipart/form-data', // Use multipart/form-data for file uploads
        ),
      );

      print(response.data['data']['photo_list']);
      print(response.data['data']['tag_list']);

      if (response.statusCode == 200) {
        print('The request was sent successfully.');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewPost(
                responseData: response.data), // responseData는 응답 데이터입니다.
          ),
        );
        // Process successful response
      } else {
        print('Request failed: ${response.statusCode}');
        // Handle the error
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }
}

class CustomCategoryToggleButtons extends StatefulWidget {
  final ValueChanged<int> onCategoryChanged;

  const CustomCategoryToggleButtons({Key? key, required this.onCategoryChanged})
      : super(key: key);

  @override
  _CustomCategoryToggleButtonsState createState() =>
      _CustomCategoryToggleButtonsState();
}

class _CustomCategoryToggleButtonsState
    extends State<CustomCategoryToggleButtons> {
  List<bool> isSelected = [false, false];

  void _onPressed(int index) {
    setState(() {
      isSelected = isSelected.map((value) => false).toList();
      isSelected[index] = true;
      widget.onCategoryChanged(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ToggleButtons(
        color: Colors.black.withOpacity(0.60),
        selectedColor: Colors.black,
        selectedBorderColor: Color(0xFF5A7AE3),
        fillColor: Color(0xFF2B57EE).withOpacity(0.1),
        splashColor: Color(0xFF2B57EE).withOpacity(0.12),
        hoverColor: Color(0xFF6200EE).withOpacity(0.04),
        borderRadius: BorderRadius.circular(0),
        constraints: BoxConstraints(minHeight: 54.0, minWidth: 108),
        isSelected: isSelected,
        onPressed: (index) => _onPressed(index),
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('AI'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('일반'),
          ),
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
                MaterialPageRoute(builder: (context) => const PhotoBoard()),
              );
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
          ),
          width: 15,
          height: 40,
        ),
        // Container(
        //   child: Text('Art Transfer',
        //       textAlign: TextAlign.center,
        //       style: TextStyle(
        //         color: Colors.white,
        //         fontSize: 12,
        //         fontFamily: 'SUIT',
        //         fontWeight: FontWeight.w600,
        //       )),
        //   width: 87,
        //   height: 18,
        //   decoration: ShapeDecoration(
        //     color: Color(0xFF4065DE),
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(14),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class CustomToggleButtons extends StatefulWidget {
  final ValueChanged<int> onChanged;

  const CustomToggleButtons({Key? key, required this.onChanged})
      : super(key: key);

  @override
  _CustomToggleButtonsState createState() => _CustomToggleButtonsState();
}

class _CustomToggleButtonsState extends State<CustomToggleButtons> {
  List<bool> isSelected = [false, false];

  void _onPressed(int index) {
    setState(() {
      isSelected = isSelected.map((value) => false).toList();
      isSelected[index] = true;
      widget.onChanged(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ToggleButtons(
        color: Colors.black.withOpacity(0.60),
        selectedColor: Colors.black,
        selectedBorderColor: Color(0xFF5A7AE3),
        fillColor: Color(0xFF2B57EE).withOpacity(0.1),
        splashColor: Color(0xFF2B57EE).withOpacity(0.12),
        hoverColor: Color(0xFF6200EE).withOpacity(0.04),
        borderRadius: BorderRadius.circular(0),
        constraints: BoxConstraints(minHeight: 54.0, minWidth: 108),
        isSelected: isSelected,
        onPressed: (index) => _onPressed(index),
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('동양풍'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('서양풍'),
          ),
        ],
      ),
    );
  }
}

class TagInputChip extends StatefulWidget {
  final Function(String) onAddTag;

  TagInputChip({Key? key, required this.onAddTag}) : super(key: key);

  @override
  _TagInputChipState createState() => _TagInputChipState();
}

class _TagInputChipState extends State<TagInputChip> {
  List<String> tags = []; // Initialize tags as an empty list
  List<String> hashtag = []; // Initialize hashtag as an empty list
  TextEditingController _tagController = TextEditingController();

  List<String> getTags() {
    return tags;
  }

  void _addTag(String tag) {
    setState(() {
      tags.add(tag);
      _tagController.clear();
      print(tags);
      widget.onAddTag(tag);

      // Update the 'hashtag' variable here
      hashtag = tags;
    });
  }

  void _removeTag(String tag) {
    setState(() {
      tags.remove(tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(13, 0, 13, 0),
          width: 346,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 0.50, color: Colors.grey),
            ),
          ),
          child: Wrap(
            spacing: 8.0,
            children: [
              ...tags.map(
                (tag) => InputChip(
                  label: Text(tag),
                  onDeleted: () => _removeTag(tag),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(19.5),
                  ),
                ),
              ),
              Container(
                width: 85,
                child: TextFormField(
                  controller: _tagController,
                  decoration: InputDecoration(
                    hintText: '새 태그 입력',
                  ),
                  onEditingComplete: () {
                    String tag = _tagController.text.trim();
                    if (tag.isNotEmpty) {
                      _addTag(tag);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _tagController.dispose();
    super.dispose();
  }
}
