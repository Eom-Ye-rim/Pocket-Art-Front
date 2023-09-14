import 'package:flutter/material.dart';
import 'package:flutter_ar_example/splash/ThirdSplash.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _MyApp(),
    );
  }
}

class _MyApp extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<_MyApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('images/f.mp4')
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
        // Navigate to SecondSplash when the video ends
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ThirdSplash()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : CircularProgressIndicator(), // Show a loading indicator while the video is initializing.
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}



