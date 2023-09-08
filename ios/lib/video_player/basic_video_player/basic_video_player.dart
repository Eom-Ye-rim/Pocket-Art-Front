// @packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

class BasicVideoPlayer extends StatefulWidget {
  final String url;

  BasicVideoPlayer({Key? key, required this.url}) : super(key: key);

  @override
  _BasicVideoPlayer createState() => _BasicVideoPlayer();
}

class _BasicVideoPlayer extends State<BasicVideoPlayer> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(widget.url),
      autoPlay: false,
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video player'),
      ),
      body: FlickVideoPlayer(flickManager: flickManager),
    );
  }
}