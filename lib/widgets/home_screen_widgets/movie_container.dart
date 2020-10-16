import 'package:AbaTime/models/Movie.dart';
import 'package:AbaTime/providers/all_providers.dart';
import 'package:AbaTime/shimmers/movie_list_shimmer.dart';
import 'package:AbaTime/shimmers/shimmer_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routes.dart' as routes;

class MovieContainer extends StatelessWidget {
  final Map<String, String> title;
  final String genre;
  const MovieContainer({Key key, this.title, this.genre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
          child: Text(
            title.values.first,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        SizedBox(height: 8.0),
        FutureBuilder(
          future: Provider.of<MovieProvider>(context, listen: false)
              .fetchAllMovies(title.keys.first, genre),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return MovieListShimmer();
            } else if (snapshot.error != null) {
              return Text('No Movies Available');
            } else {
              return MovieListContainer();
            }
          },
        ),
      ],
    );
  }
}

class MovieListContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    final movies = movieProvider.allMovies;
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (_, index) => InkWell(
          onTap: () => navigateToNextScreen(context, movies[index]),
          child: Container(
            margin: const EdgeInsets.fromLTRB(8.0, 2.0, 0.0, 4.0),
            child: CachedNetworkImage(
              imageUrl: movies[index].mediumCoverImage ??
                  movies[index].largeCoverImage,
              placeholder: (_, url) => ShimmerItem(),
              fadeInDuration: Duration(milliseconds: 500),
              fadeInCurve: Curves.bounceInOut,
            ),
          ),
        ),
      ),
    );
  }

  navigateToNextScreen(BuildContext context, Movie movie) {
    Navigator.of(context)
        .pushNamed(routes.movieDetailScreen, arguments: movie.id);
  }
}
