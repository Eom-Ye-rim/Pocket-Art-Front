import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// ignore_for_file: prefer_const_constructors

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          automaticallyImplyLeading: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.edit_note, //
                color: Color(0xFF727272), // 아이콘 색상
              ),
              Text(
                '게시물 작성',
                style: TextStyle(
                  color: Color(0xFF727272),
                  fontSize: 22,
                  fontFamily: 'SUIT',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
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
                CustomToggleButtons(),
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
                TagInputChip(),
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
                    onPressed: () {},
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
    );
  }
}

class CustomToggleButtons extends StatefulWidget {
  const CustomToggleButtons({Key? key}) : super(key: key);

  @override
  _CustomToggleButtonsState createState() => _CustomToggleButtonsState();
}

class _CustomToggleButtonsState extends State<CustomToggleButtons> {
  List<bool> isSelected = [false, false];

  void _onPressed(int index) {
    setState(() {
      isSelected = isSelected.map((value) => false).toList();
      isSelected[index] = true;
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
  @override
  _TagInputChipState createState() => _TagInputChipState();
}

class _TagInputChipState extends State<TagInputChip> {
  List<String> tags = [];
  TextEditingController _tagController = TextEditingController();

  void _addTag(String tag) {
    setState(() {
      tags.add(tag);
      _tagController.clear();
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
