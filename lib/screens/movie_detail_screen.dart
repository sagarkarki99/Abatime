import 'dart:ui';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as url;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../config/utils/torrent_manager.dart';
import '../models/MovieDetail.dart';
import '../models/core/entities/movie_stack.dart';
import '../providers/detail_provider.dart';
import '../shimmers/movie_detail_shimmer.dart';
import '../widgets/detail_screen_widget/content_header.dart';
import '../widgets/widgets.dart';

class MovieDetailScreen extends StatelessWidget {
  final String movieId;
  const MovieDetailScreen(this.movieId, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<DetailProvider>(context, listen: false)
            .fetchMovieDetailWith(movieId.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MovieDetailShimmer();
          } else if (snapshot.error != null) {
            return Center(
              child: Text('Failed to load!'),
            );
          } else {
            return MovieDetailWidget();
          }
        },
      ),
    );
  }
}

class MovieDetailWidget extends StatelessWidget {
  playTrailer(BuildContext context, Movie movie) {
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
            thumbnail: Image.network(movie.mediumCoverImage),
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

  Widget _movieInfoContainer(BuildContext context, Movie movie) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () => playTrailer(context, movie),
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
              TextButton.icon(
                icon: Icon(
                  Icons.file_download,
                  color: Theme.of(context).accentColor,
                ),
                label: Text(
                  'Get Torrent',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                    ),
                    builder: (context) => DownloadContainer(movie),
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
    final movieProvider = Provider.of<DetailProvider>(context);
    final movie = movieProvider.detailMovie;

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
              child: _movieInfoContainer(context, movie),
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
                  .map(
                    (movie) => CustomChip(
                      label: movie.toString(),
                      color: Theme.of(context).accentColor,
                    ),
                  )
                  .toList(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              movie.descriptionFull,
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.white60),
              strutStyle: StrutStyle(leading: 0.5),
            ),
          ),
          movie.cast == null ? SizedBox() : CastContainer(casts: movie.cast),
          MovieContainer(
            genre: movie.genres[0],
            movieStack: MovieStack(
              sortBy: 'recently_added',
              stackName: 'Similar Movies',
            ),
            onMovieSelect: (movie) {
              context.read<DetailProvider>().fetchMovieDetailWith(movie.id.toString());
            },
          ),
        ],
      ),
    );
  }
}

class DownloadContainer extends StatefulWidget {
  final Movie movie;
  DownloadContainer(this.movie);

  @override
  _DownloadContainerState createState() => _DownloadContainerState();
}

class _DownloadContainerState extends State<DownloadContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: MediaQuery.of(context).size.height * 0.30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.0),
          topRight: Radius.circular(18.0),
        ),
      ),
      child: widget.movie.torrents.length == 1
          ? _downloadSide(context, widget.movie.torrents[0])
          : Row(
              children: [
                _downloadSide(context, widget.movie.torrents[0]),
                VerticalDivider(
                  color: Colors.red,
                ),
                _downloadSide(context, widget.movie.torrents[1]),
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
          Navigator.pop(context);
          _openTorrentApp(torrent, context);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.tv,
              size: 42,
            ),
            Text(
              '${torrent.quality}',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 8.0),
            Text(
              '${torrent.type}',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              '${torrent.size}',
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }

  void _openTorrentApp(Torrents torrent, BuildContext context) async {
    if (await TorrentManager.isTorrentClientAvailable()) {
      AndroidIntent intent = AndroidIntent(
        action: 'action_view',
        package: TorrentManager.getAvailableClient(),
        data: TorrentManager.getMagnetUrl(torrent.hash, torrent.url),
      );
      await intent.launch();
    } else {
      await url.launch(
          'https://play.google.com/store/apps/details?id=com.bittorrent.client&hl=en&gl=US');
    }
  }
}
