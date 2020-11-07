import 'package:AbaTime/models/Movie.dart';
import 'package:AbaTime/providers/all_providers.dart';
import 'package:AbaTime/shimmers/movie_list_shimmer.dart';
import 'package:AbaTime/shimmers/shimmer_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';

class MovieContainer extends StatelessWidget {
  final Map<String, String> title;
  final String genre;
  const MovieContainer({Key key, this.title, this.genre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Movie Container build with $genre');
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
          child: Text(
            title.values.first,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(letterSpacing: 1.5, color: Colors.white70),
          ),
        ),
        const SizedBox(height: 8.0),
        FutureBuilder(
          future: movieProvider.fetchMovies(title.keys.first, genre),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return MovieListShimmer();
            } else if (snapshot.error != null) {
              return Text('${snapshot.error.toString()}');
            } else {
              return MovieListContainer(sortName: title.keys.first);
            }
          },
        ),
      ],
    );
  }
}

class MovieListContainer extends StatelessWidget {
  final String sortName;

  const MovieListContainer({Key key, @required this.sortName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    final movies = movieProvider.moviesMap[sortName];
    return Container(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (_, index) => InkWell(
          onTap: () => navigateToNextScreen(context, movies[index]),
          child: MovieItem(movie: movies[index]),
        ),
      ),
    );
  }

  navigateToNextScreen(BuildContext context, Movie movie) {
    Navigator.of(context)
        .pushNamed(Routes.movieDetailScreen, arguments: movie.id);
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
                  Icons.star,
                  size: 18,
                  color: Theme.of(context).accentColor,
                ),
              ],
            )),
      ],
    );
  }
}
