// @packages
import 'package:flutter/services.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ar_example/video_player/custom_video_player/video_controller.dart';

// @widgets
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  final String url;

  VideoPlayer({Key? key, required this.url}) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
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
    return FlickVideoPlayer(
      flickManager: flickManager,
      preferredDeviceOrientation: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.portraitDown,
      ],
      flickVideoWithControls: FlickVideoWithControls(controls: VideoControls()),
    );
  }
}