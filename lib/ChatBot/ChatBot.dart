import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:url_launcher/url_launcher.dart';

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
          leadingWidth: 200,
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
              Container(
                width: 32.39,
                height: 25.91,
                color: Colors.transparent,
                child: Image(
                  image: AssetImage('images/img_36.png'),
                ),
              ),
              SizedBox(width: 10,),
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
      isUserMessage: true, buttons: [],
    );
    setState(() {
      _messages.insert(0, message);
    });

    // 사용자 입력이 '처음으로'일 경우의 기본응답
    if (text == '처음으로') {
      _handleBotResponse(
        "'처음으로' 키워드 입력시 응답 123123123123",
        [
          ButtonInfo(text: '앱 소개', url: 'http://example.com/button1'),
          ButtonInfo(text: 'AR 가이드', url: 'http://example.com/button2'),
          ButtonInfo(text: '이용가이드', url: null), // 이용가이드 url null로 설정
        ],
      );
    }  else {
      // 다른 사용자 입력을 처리합니다.
    }
  }

  void _handleBotResponse(String text, List<ButtonInfo> buttons) {
    ChatMessage message = ChatMessage(
      text: text,
      isUserMessage: false,
      buttons: buttons,
      onButton1Click: _handleButton1Click,
      onButton2Click: _handleButton2Click,
      onButton3Click: _handleButton3Click,
    );

    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleButton1Click() async { //앱소개 버튼 url
    await launch('http://example.com/button1');
  }

  void _handleButton2Click() async {// AR 가이드 버튼 url
    await launch('http://example.com/button2');
  }

  void _handleButton3Click() {
    _handleBotResponse("'처음으로' 키워드 입력하면 앱 소개/ AR 가이드를 확인할 수 있습니다.", []);
    _handleBotResponse('chat GPT 를 이용해 자세한 답변을 들을 수 있습니다.', []);
  }

  @override
  void initState() {
    super.initState();

    // 채팅 화면이 처음 열렸을 때 봇의 초기 응답
    _handleBotResponse(
      '안녕하세요! Pocket Art 입니다. 무엇을 도와드릴까요?',
      [
        ButtonInfo(text: '앱 소개', url: 'http://example.com/button1'),
        ButtonInfo(text: 'AR 가이드', url: 'http://example.com/button2'),
        ButtonInfo(text: '이용가이드', url: null), // 이용가이드 url은 null로 설정
      ],
    );
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
        height: 60,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            SizedBox(width: 15,),
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
                icon: Icon(Icons.send, color: Color(0xff6F8EF1),),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({
    required this.text,
    required this.isUserMessage,
    required this.buttons,
    this.onButton1Click,
    this.onButton2Click,
    this.onButton3Click,
  });

  final String text;
  final bool isUserMessage;
  final List<ButtonInfo> buttons;
  final VoidCallback? onButton1Click;
  final VoidCallback? onButton2Click;
  final VoidCallback? onButton3Click;

  Widget _buildButtons() {
    if (buttons.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5,),
        Row(
          children: [
            SizedBox(width: 60,),
            if (buttons.length >= 1)
              Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.0),),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff44618B),
                  ),
                  onPressed: () {
                    if (buttons[0].text == '앱 소개' && onButton1Click != null) {
                      onButton1Click!();
                    }
                  },
                  child: Text(buttons[0].text),
                ),
              ),
            SizedBox(width: 10,),
            if (buttons.length >= 2)
              Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.0),),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xff44618B)
                  ),
                  onPressed: () {
                    if (buttons[1].text == 'AR 가이드' && onButton2Click != null) {
                      onButton2Click!();
                    }
                  },
                  child: Text(buttons[1].text),
                ),
              ),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            SizedBox(width: 60,),
            if (buttons.length >= 3)
              Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0.0),),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xff44618B)
                  ),
                  onPressed: () {
                    if (buttons[2].text == '이용가이드' && onButton3Click != null) {
                      onButton3Click!();
                    }
                  },
                  child: Text(buttons[2].text),
                ),
              ),
          ],
        )
      ],
    );


  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: isUserMessage
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: <Widget>[
              if (!isUserMessage)
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('images/img_35.png'),
                ),
              Container(
                child: BubbleSpecialOne(
                  text: text,
                  isSender: false,
                  tail: false,
                  color: isUserMessage? Color(0xFF6F8EF1) : Colors.white,
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: isUserMessage ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ],
          ),
          _buildButtons(),
        ],
      ),
    );
  }
}

class ButtonInfo {
  ButtonInfo({
    required this.text,
    required this.url,
  });

  final String text;
  final String? url;
}

void main() {
  runApp(MyChatApp());
}
