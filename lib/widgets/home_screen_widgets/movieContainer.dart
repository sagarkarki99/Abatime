import 'package:AbaTime/model/movie.dart';
import 'package:AbaTime/provider/MoviesProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routes.dart' as routes;

class MovieContainer extends StatelessWidget {
  final String title;

  const MovieContainer({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        SizedBox(height: 8.0),
        FutureBuilder(
          future: Provider.of<MovieProvider>(context, listen: false)
              .fetchAllMovies(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              );
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
    print(movies.length);
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (_, index) => InkWell(
          onTap: () => navigateToNextScreen(context, movies[index]),
          child: Container(
            margin: const EdgeInsets.fromLTRB(8.0, 2.0, 0.0, 4.0),
            child: FadeInImage.assetNetwork(
              fadeInDuration: Duration(milliseconds: 500),
              placeholder: 'h',
              image: movies[index].largeCoverImage,
              width: 110,
            ),
          ),
        ),
      ),
    );
  }

  navigateToNextScreen(BuildContext context, Movie movie) {
    Navigator.of(context).pushNamed(routes.movieDetailScreen, arguments: movie);
  }
}
