import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  VideoPlayerController _videoController;
  String sampleUrl =
      'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4';
  String movieUrl =
      'https://api.123movie.cc/jadeed.php?ep=60735-6x5&server_name=f5_series&t=60735';
  startPlayer() {
    _videoController = VideoPlayerController.network('$sampleUrl')
      ..initialize().then((_) => setState(() {}))
      ..play();
  }

  @override
  void initState() {
    super.initState();
    startPlayer();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          // color: Colors.green,
          child: AspectRatio(
            aspectRatio: _videoController.value.initialized
                ? _videoController.value.aspectRatio
                : 2.333,
            child: VideoPlayer(_videoController),
          ),
        ),
      ),
    );
  }
}
