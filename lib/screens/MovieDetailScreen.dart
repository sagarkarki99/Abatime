import 'package:AbaTime/model/movie.dart';
import 'package:AbaTime/widgets/detail_screen_widget/contentHeader.dart';
import 'package:flutter/material.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context).settings.arguments as Movie;

    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContentHeader(
          featuredImage: movie.largeCoverImage,
          genres: movie.genres,
          ratings: movie.rating,
        ),
        Text(movie.title),
        SizedBox(height: 12),
        Text(
          movie.summary,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: Colors.white60),
        ),
      ],
    ));
  }
}
