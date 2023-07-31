// @packages
import 'package:flutter/material.dart';

// @widgets
import 'package:flutter_ar_example/video_player/custom_video_player/custom_video_player.dart';

class VideoTabs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VideoTabs();
}

class _VideoTabs extends State<VideoTabs> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) => setState(() => _currentIndex = index),
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.movie),
            label: 'Video 1',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.movie),
            label: 'Video 2',
          ),
        ],
      ),
      body: IndexedStack(
        children: <Widget>[
          VideoPlayer(
            url:
            'https://assets.mixkit.co/videos/preview/mixkit-person-on-a-bicycle-starts-to-ride-on-a-cycling-40904-large.mp4',
          ),
          VideoPlayer(
            url:
            'https://assets.mixkit.co/videos/preview/mixkit-meadow-surrounded-by-trees-on-a-sunny-afternoon-40647-large.mp4',
          ),
        ],
        index: _currentIndex,
      ),
    );
  }
}