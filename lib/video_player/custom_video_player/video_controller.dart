// @ packages
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';

// @widgets
import 'package:flutter_ar_example/video_player/custom_video_player/play_toggle.dart';

class VideoControls extends StatelessWidget {
  final double iconSize;
  final double fontSize;

  const VideoControls({
    Key? key,
    this.iconSize = 20,
    this.fontSize = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FlickShowControlsAction(
          child: FlickSeekVideoAction(
            child: Center(
              child: FlickVideoBuffer(
                child: FlickAutoHideChild(
                  showIfVideoNotInitialized: false,
                  child: PlayToggle(),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: FlickAutoHideChild(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: Color.fromRGBO(0, 0, 0, 0.4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      FlickPlayToggle(size: 20),
                      SizedBox(width: 10),
                      FlickCurrentPosition(fontSize: fontSize),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          child: FlickVideoProgressBar(
                            flickProgressBarSettings: FlickProgressBarSettings(
                              height: 5,
                              handleRadius: 7,
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 8,
                              ),
                              backgroundColor: Colors.white24,
                              bufferedColor: Colors.white38,
                              getPlayedPaint: ({
                                double? handleRadius,
                                double? height,
                                double? playedPart,
                                double? width,
                              }) {
                                return Paint()
                                  ..shader = LinearGradient(colors: [
                                    Colors.red,
                                    Colors.yellow,
                                  ], stops: [
                                    0.0,
                                    0.5
                                  ]).createShader(
                                    Rect.fromPoints(
                                      Offset(0, 0),
                                      Offset(width!, 0),
                                    ),
                                  );
                              },
                              getHandlePaint: ({
                                double? handleRadius,
                                double? height,
                                double? playedPart,
                                double? width,
                              }) {
                                return Paint()
                                  ..shader = RadialGradient(
                                    colors: [
                                      Colors.red,
                                      Colors.yellow,
                                      Colors.white
                                    ],
                                    stops: [0.0, 0.4, 0.5],
                                    radius: 0.2,
                                  ).createShader(
                                    Rect.fromCircle(
                                      center: Offset(playedPart!, height! / 2),
                                      radius: handleRadius!,
                                    ),
                                  );
                              },
                            ),
                          ),
                        ),
                      ),
                      FlickTotalDuration(fontSize: fontSize),
                      SizedBox(width: 10),
                      FlickSoundToggle(size: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}