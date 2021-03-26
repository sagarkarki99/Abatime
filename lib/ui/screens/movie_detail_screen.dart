import 'dart:ui';

import 'package:abatime/models/MovieDetail.dart';
import 'package:abatime/models/core/entities/movie_stack.dart';
import 'package:abatime/providers/detail_provider.dart';
import 'package:abatime/shimmers/movie_detail_shimmer.dart';
import 'package:abatime/ui/widgets/detail_screen_widget/download_container.dart';
import 'package:abatime/ui/widgets/ads_widgets/banner_widget.dart';
import 'package:abatime/ui/widgets/detail_screen_widget/movie_stat_info.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
                  child: MovieTitle(movieTitle: movie.titleLong),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    tooltip: 'Add to Watch List',
                    icon: Icon(FluentIcons.add_circle_24_regular),
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
            child: MovieDescription(movie: movie),
          ),
          BannerWidget(),
          movie.cast == null ? SizedBox() : CastContainer(casts: movie.cast),
          MovieContainer(
            genre: movie.genres[0],
            movieStack: MovieStack(
              sortBy: 'recently_added',
              stackName: 'Similar Movies',
            ),
            onMovieSelect: (movie) {
              context
                  .read<DetailProvider>()
                  .fetchMovieDetailWith(movie.id.toString());
            },
          ),
        ],
      ),
    );
  }

  playTrailer(BuildContext context, Movie movie) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: movie.ytTrailerCode,
              flags: YoutubePlayerFlags(
                autoPlay: true,
                mute: false,
                forceHD: true,

              ),
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
                  Colors.transparent,
                  Colors.black45,
                  Colors.transparent,
                ]),
              ),
              child: Icon(
                FluentIcons.play_circle_24_regular,
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
              MovieStatInfo(
                label: '${movie.rating.toString()} / 10',
                iconData: FluentIcons.star_28_filled,
              ),
              SizedBox(height: 16.0),
              MovieStatInfo(
                  label: movie.downloadCount.toString(),
                  iconData: FluentIcons.arrow_download_24_filled),
              SizedBox(height: 16.0),
              MovieStatInfo(
                label: movie.likeCount.toString(),
                iconData: FluentIcons.heart_24_filled,
              ),
              SizedBox(height: 16.0),
              TextButton.icon(
                icon: Icon(
                  FluentIcons.arrow_download_24_regular,
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
}

class MovieDescription extends StatelessWidget {
  const MovieDescription({
    Key key,
    @required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Text(
      movie.descriptionFull,
      textAlign: TextAlign.left,
      style:
          Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white60),
      strutStyle: StrutStyle(leading: 0.5),
    );
  }
}

class MovieTitle extends StatelessWidget {
  final String movieTitle;

  const MovieTitle({
    Key key,
    @required this.movieTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      movieTitle,
      style: Theme.of(context).textTheme.headline6.copyWith(letterSpacing: 2.0),
    );
  }
}
