
import 'package:flutter/material.dart';
import 'package:flutter_ar_example/splash/FirstSplash.dart';
import 'package:flutter_ar_example/splash/ThirdSplash.dart';

import '../user/LoginMain.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(const SecondSplash());

class SecondSplash extends StatelessWidget {
  const SecondSplash({Key? key}); // 'Key?' 타입의 key를 수정

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        body: Frame427320775(),
      ),
    );
  }
}

class Frame427320775 extends StatefulWidget {
  @override
  _SecondSplash createState() => _SecondSplash();
}

class _SecondSplash extends State<Frame427320775> {
  late VideoPlayerController _controller;
  bool videoCompleted = false; // 비디오 재생 완료 여부를 저장하기 위한 변수

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('images/AR_Final.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown and set the state when the video is initialized.
        setState(() {
          print('Video initialized successfully');
          _controller.play(); // 자동으로 영상 재생 시작
        });
      });

    // Add a listener to detect when the video playback is completed
    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration) {
        // 비디오 재생이 완료되면 videoCompleted를 true로 설정
        setState(() {
          videoCompleted = true;
        });
      }
    });
    _controller.setLooping(true);

    // Add a listener to detect when the video playback is completed
    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration) {
        // Video playback is completed, but since looping is enabled,
        // it will automatically restart from the beginning.
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    // if (videoCompleted) {
    //   // 만약 비디오 재생이 완료되었다면 FirstSplash 페이지로 이동
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(builder: (context) => ThirdSplash()),
    //     );
    //   });
    // }

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            _controller.value.isInitialized
                ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
                : CircularProgressIndicator(), // Show a loading indicator while the video is initializing.
            Positioned(
              left: 170,
              top: 80,
              child: Container(
                width: 14,
                height: 14,
                decoration: ShapeDecoration(
                  color: Color(0xFFD9D9D9),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 200,
              top: 80,
              child: Container(
                width: 14,
                height: 14,
                decoration: ShapeDecoration(
                  color: Color(0xFF406BF6),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 230,
              top: 80,
              child: Container(
                width: 14,
                height: 14,
                decoration: ShapeDecoration(
                  color: Color(0xFFD9D9D9),
                  shape: OvalBorder(),
                ),
              ),
            ),

            Positioned(
              left: 115,
              top: 151,
              child: Text(
                '신기한 AR을 활용해\n 그림을 현실로 체험하고!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Apple SD Gothic Neo',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Positioned(
              left: 270,
              top: 610,
              child: Container(
                width: 105,
                height: 130,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/ARCharacter.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 320,
              top: 777,
              child: GestureDetector(
                onTap: () {
                  // 클릭 시 실행할 동작을 여기에 추가
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ThirdSplash()),
                  );
                },
           child:Icon(Icons.arrow_forward),
              )
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

