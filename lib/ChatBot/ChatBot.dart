
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



void main() {
  runApp(MyChatApp());
}

class MyChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          backgroundColor: Colors.white,
          elevation: 5,
          leadingWidth: 140,

          shadowColor: Colors.black,

          leading: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Text(
                '챗봇 test',
                style: TextStyle(
                  color: Color(0xFF505050),
                  fontSize: 20,
                  fontFamily: 'SUIT',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ],
          ),


        ),
        body: ChatScreen(),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      isUserMessage: true,
    );
    setState(() {
      _messages.insert(0, message);
    });

    // 사용자 입력이 '처음으로'일 경우의 기본응답
    if (text == '처음으로') {
      _handleBotResponse(
          "'처음으로' 키워드 입력에 대한 기본응답 test", ['옵션 1', '옵션 2', '옵션 3']);

    } else {

    }
  }

  void _handleBotResponse(String text, List<String> options) {
    ChatMessage message = ChatMessage(
      text: text,
      isUserMessage: false,
    );

    setState(() {
      _messages.insert(0, message);
    });

    // 사용자가 선택할 수 있는 옵션들을 보여줌
    for (var option in options) {
      _messages.insert(
        0,
        ChatMessage(
          text: option,
          isUserMessage: false,
        ),
      );
    }





    // 여기에서 gpt api 관련 코드 추가해야할듯
  }

  @override
  void initState() {
    super.initState();

    // 채팅 화면이 처음 열렸을 때 봇의 초기 응답
    _messages.insert(0, ChatMessage(
      text: '챗봇 화면 시작 시 기본응답 test ',
      isUserMessage: false,
    ));
  }




  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffE8EDFF),
      child: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Colors.blue),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(
                  hintText: "메세지 입력...",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send,
                color: Color(0xff6F8EF1),),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ChatMessage 위젯에서 사용자 메시지와 봇 메시지 구분
class ChatMessage extends StatelessWidget {
  ChatMessage({required this.text, required this.isUserMessage});

  final String text;
  final bool isUserMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: isUserMessage
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: BubbleSpecialOne(
              text: text,
              isSender: false,
              tail: false,
              // color: Color(0xFF6F8EF1),
              color: isUserMessage? Color(0xFF6F8EF1) : Colors.white,
              textStyle: TextStyle(
                fontSize: 20,
                color: isUserMessage ? Colors.white : Colors.black,
              ),
            ),



          ),
        ],
      ),
    );
  }
}