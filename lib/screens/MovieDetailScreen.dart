import 'dart:ui';

import 'package:AbaTime/model/movieDetail.dart';

import 'package:AbaTime/provider/moviesProvider.dart';
import 'package:AbaTime/shimmers/movieDetailShimmer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:AbaTime/widgets/detail_screen_widget/contentHeader.dart';
import 'package:provider/provider.dart';
import '../widgets/widgets.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieId = ModalRoute.of(context).settings.arguments as int;

    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<MovieProvider>(context, listen: false)
            .fetchMovieDetail(movieId.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MovieDetailShimmer();
          } else if (!snapshot.hasData) {
            return Center(
              child: Text('Failed to load!'),
            );
          } else {
            return MovieDetailWidget(movie: snapshot.data);
          }
        },
      ),
    );
  }
}

class MovieDetailWidget extends StatelessWidget {
  final Movie movie;

  MovieDetailWidget({Key key, this.movie}) : super(key: key);

  playTrailer(BuildContext context) {
    showDialog(
      context: context,
      child: Dialog(
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: movie.ytTrailerCode,
              flags: YoutubePlayerFlags(
                  autoPlay: true, mute: false, forceHD: true),
            ),
            showVideoProgressIndicator: true,
            progressIndicatorColor: Theme.of(context).accentColor,
          ),
          builder: (context, player) {
            return player;
          },
        ),
      ),
    );
  }

  Widget _movieInfoContainer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () => playTrailer(context),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  movie.mediumCoverImage,
                ),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              width: 150,
              height: 200,
              decoration: BoxDecoration(
                  gradient: RadialGradient(colors: [
                Colors.black45,
                Colors.transparent,
                Colors.black45
              ])),
              child: Icon(
                Icons.play_circle_filled,
                size: 38,
                color: Colors.white70,
              ),
            ),
          ),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconWithInfo(
                label: '${movie.rating.toString()} / 10',
                icon: Icons.star,
              ),
              SizedBox(height: 16.0),
              IconWithInfo(
                label: movie.downloadCount.toString(),
                icon: Icons.file_download,
              ),
              SizedBox(height: 16.0),
              IconWithInfo(
                label: movie.likeCount.toString(),
                icon: Icons.favorite,
              ),
              SizedBox(height: 16.0),
              RaisedButton.icon(
                icon: Icon(Icons.file_download),
                label: Text('Download'),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                    elevation: 8,
                    builder: (context) => DownloadContainer(movie.torrents),
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldContext = Scaffold.of(context);
    final movieProvider = Provider.of<MovieProvider>(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContentHeader(
            sc1: movie.mediumScreenshotImage1,
            sc2: movie.mediumScreenshotImage2,
            sc3: movie.mediumScreenshotImage3,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: _movieInfoContainer(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    movie.titleLong,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(letterSpacing: 2.0),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    tooltip: 'Add to Watch List',
                    icon: Icon(Icons.add_to_queue),
                    onPressed: () {
                      //saving this movie to local db as watchlist
                      movieProvider.addToWatchList(movie);
                      scaffoldContext.hideCurrentSnackBar();
                      scaffoldContext.showSnackBar(
                        SnackBar(
                          content: Text('Added to Watch List'),
                          backgroundColor:
                              Theme.of(context).secondaryHeaderColor,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Wrap(
            direction: Axis.horizontal,
            children: [
              ...movie.genres
                  .map((movie) => CustomChip(
                        label: movie.toString(),
                        color: Theme.of(context).accentColor,
                      ))
                  .toList(),
            ],
          ),
          Text(
            movie.descriptionFull,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Colors.white60),
            strutStyle: StrutStyle(leading: 0.5),
          ),
          movie.cast == null ? SizedBox() : CastContainer(casts: movie.cast),
        ],
      ),
    );
  }
}

class DownloadContainer extends StatelessWidget {
  final List<Torrents> torrents;
  DownloadContainer(this.torrents);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 200,
      child: Row(
        children: [
          _downloadSide(context, torrents[0]),
          VerticalDivider(
            color: Colors.red,
          ),
          _downloadSide(context, torrents[1]),
        ],
      ),
    );
  }

  _downloadSide(BuildContext context, Torrents torrent) {
    return Expanded(
      flex: 1,
      child: InkWell(
        splashColor: Theme.of(context).accentColor.withOpacity(0.5),
        onTap: () {
          _openTorrentApp(torrent.url);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${torrent.quality}',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              '${torrent.type}',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              '${torrent.size}',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }

  void _openTorrentApp(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
