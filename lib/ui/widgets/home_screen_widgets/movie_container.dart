import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/Movie.dart';
import '../../../models/core/entities/movie_stack.dart';
import '../../../providers/all_providers.dart';
import '../../../shimmers/movie_list_shimmer.dart';
import '../ads_widgets/native_ad_widget.dart';
import 'movie_item.dart';

class MovieContainer extends StatefulWidget {
  final MovieStack movieStack;
  final String genre;
  final Function(Movie movie) onMovieSelect;
  const MovieContainer(
      {Key key, this.genre, this.movieStack, this.onMovieSelect})
      : super(key: key);

  @override
  _MovieContainerState createState() => _MovieContainerState();
}

class _MovieContainerState extends State<MovieContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Movie Container build with ${widget.genre}');
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
          child: Text(
            widget.movieStack.stackName,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(letterSpacing: 1.5, color: Colors.white70),
          ),
        ),
        const SizedBox(height: 8.0),
        FutureBuilder(
          future: movieProvider.fetchMovies(widget.movieStack, widget.genre),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return MovieListShimmer();
            } else if (snapshot.error != null) {
              return Text('${snapshot.error.toString()}');
            } else {
              return MovieListContainer(
                  movieStack: widget.movieStack,
                  onSelect: (movie) => widget.onMovieSelect(movie));
            }
          },
        ),
      ],
    );
  }
}

class MovieListContainer extends StatefulWidget {
  final MovieStack movieStack;
  final Function(Movie) onSelect;
  const MovieListContainer({Key key, @required this.movieStack, this.onSelect})
      : super(key: key);

  @override
  _MovieListContainerState createState() => _MovieListContainerState();
}

class _MovieListContainerState extends State<MovieListContainer> {
  List<Widget> widgetsItem = [];
  int firstAdIndex = 3;
  int secondAdIndex = 12;
  int thirdAdIndex = 18;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.movieStack.movies.length + 3; i++) {
      if (i == firstAdIndex || i == secondAdIndex || i == thirdAdIndex) {
        widgetsItem.add(NativeAdWidget());
      } else {
        final movie = widget.movieStack.movies[_getItemIndex(i)];
        widgetsItem.add(
          InkWell(
            onTap: () => widget.onSelect(movie),
            child: MovieItem(movie: movie),
          ),
        );
      }
    }
  }

  int _getItemIndex(int rawIndex) {
    if (rawIndex >= thirdAdIndex) {
      return rawIndex - 3;
    } else if (rawIndex >= secondAdIndex) {
      return rawIndex - 2;
    } else if (rawIndex >= firstAdIndex) {
      return rawIndex - 1;
    } else {
      return rawIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.movieStack.sortBy == 'year' ? 16 / 14 : 16 / 10,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widgetsItem.length,
        itemBuilder: (_, index) => widgetsItem[index],
      ),
    );
  }
}
