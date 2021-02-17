import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TvShowScreen extends StatefulWidget {
  @override
  _TvShowScreenState createState() => _TvShowScreenState();
}

class _TvShowScreenState extends State<TvShowScreen> {
  // VideoPlayerController _controller;
  // final String _videoUrl =
  //     'https://vidcloud9.com/goto.php?url=aHR0cHM6LyAdeqwrwedffryretgsdFrsftrsvfsfsr9zdG9yYWdlLmdvb2dsZWFwaXMuY29tL2lkeWxsaWMtcmV0dXJuLTI5MjAxOS8xRUJNNDRCNThNRDcvMjJtXzE2MDQzNzM1OTUzMzE1MDYubXA0';
  // final String _videoUrl =
  //     'https://ytsembed.xyz/stream/8619B57A3F39F1B49A1A698EA5400A883928C0A2';
  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.network(_videoUrl);
    // _controller.initialize();
    // _controller.play();
  }

  @override
  void dispose() {
   // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Shimmer.fromColors(
              baseColor: Colors.white70,
              period: Duration(seconds: 2),
              highlightColor:
                  Theme.of(context).secondaryHeaderColor.withOpacity(0.6),
              child: Text(
                'Coming Soon',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.white, letterSpacing: 2),
              ),
            ),
          ),
        //   Container(
        //     height: 400,
        //     width: MediaQuery.of(context).size.width,
        //     child: VideoPlayer(_controller),
        //   ),
        ],
      ),
    );
  }
}
