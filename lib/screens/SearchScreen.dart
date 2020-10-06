import 'dart:async';

import 'package:AbaTime/provider/allProviders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  Timer apiCallTimer;

  @override
  void initState() {
    super.initState();
    //startPlayer();
  }

  @override
  void dispose() {
    //_videoController.dispose();
    apiCallTimer.cancel();
    super.dispose();
  }

  _searchMovieWith(String query) {
    if (apiCallTimer != null) {
      apiCallTimer.cancel();
    }
    apiCallTimer = Timer(
        Duration(seconds: 2),
        () => Provider.of<MovieProvider>(context, listen: false)
            .searchMovieApi(query));
  }

  @override
  Widget build(BuildContext context) {
    final searchedMovies =
        Provider.of<MovieProvider>(context).allSearchedMovies;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: TextField(
          autofocus: true,
          autocorrect: true,
          cursorColor: Colors.white,
          decoration:
              InputDecoration(border: InputBorder.none, hintText: 'Search'),
          onChanged: (inputQuery) => _searchMovieWith(inputQuery),
        ),
      ),
      body: SafeArea(
        child:
            searchedMovies?.isEmpty ? Text('Loading...') : Text('Data Loaded'),
        // Container(
        //   // color: Colors.green,
        //   height: 400,
        //   child: VideoPlayer(_videoController),
        // ),
      ),
    );
  }
}
