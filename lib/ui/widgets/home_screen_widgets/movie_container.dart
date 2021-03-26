import 'package:abatime/models/Movie.dart';
import 'package:abatime/models/core/entities/movie_stack.dart';
import 'package:abatime/providers/all_providers.dart';
import 'package:abatime/shimmers/movie_list_shimmer.dart';
import 'package:abatime/shimmers/shimmer_item.dart';
import 'package:abatime/ui/widgets/ads_widgets/banner_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.movieStack.movies.length; i++) {
      
        widgetsItem.add(
          InkWell(
            onTap: () => widget.onSelect(widget.movieStack.movies[i]),
            child: MovieItem(movie: widget.movieStack.movies[i]),
          ),
        );
      
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

class MovieItem extends StatelessWidget {
  const MovieItem({
    Key key,
    @required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 8,
          child: Container(
            margin: const EdgeInsets.fromLTRB(8.0, 2.0, 0.0, 0.0),
            child: CachedNetworkImage(
              imageUrl: movie.mediumCoverImage ?? movie.largeCoverImage,
              placeholder: (_, url) => ShimmerItem(),
              fadeInDuration: Duration(milliseconds: 500),
              fadeInCurve: Curves.bounceInOut,
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: Row(
              children: [
                Text(
                  movie.rating.toString(),
                ),
                Icon(
                  FluentIcons.star_24_filled,
                  size: 18,
                  color: Theme.of(context).accentColor,
                ),
              ],
            )),
      ],
    );
  }
}
