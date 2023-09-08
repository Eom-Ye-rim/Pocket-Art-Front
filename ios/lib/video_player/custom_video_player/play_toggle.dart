// @packages
import 'package:flutter/services.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayToggle extends StatelessWidget {
  const PlayToggle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlickControlManager controlManager =
    Provider.of<FlickControlManager>(context);
    FlickVideoManager videoManager = Provider.of<FlickVideoManager>(context);

    double size = 50;
    Color color = Colors.white;

    Widget playWidget = Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(38)),
      ),
      width: 76,
      height: 76,
      child: Icon(
        Icons.play_arrow,
        size: size,
        color: color,
      ),
    );

    Widget pauseWidget = Container(
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.all(Radius.circular(38)),
      ),
      width: 76,
      height: 76,
      child: Icon(
        Icons.pause,
        size: size,
        color: color,
      ),
    );

    Widget replayWidget = Container(
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.all(Radius.circular(38)),
      ),
      width: 76,
      height: 76,
      child: Icon(
        Icons.replay,
        size: size,
        color: color,
      ),
    );

    Widget getWidget() {
      if (videoManager.isVideoEnded) {
        return replayWidget;
      } else if (videoManager.isPlaying) {
        return pauseWidget;
      }
      return playWidget;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        splashColor: Color.fromRGBO(108, 165, 242, 0.5),
        key: key,
        onTap: () {
          videoManager.isVideoEnded
              ? controlManager.replay()
              : controlManager.togglePlay();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: EdgeInsets.all(10),
          child: getWidget(),
        ),
      ),
    );
  }
}