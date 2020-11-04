import 'package:AbaTime/config/end_points.dart';
import 'package:AbaTime/https/api_client.dart';
import 'package:AbaTime/models/Movie.dart';
import 'package:AbaTime/models/MovieResponse.dart';
import 'package:AbaTime/models/MovieDetail.dart' as movieDetail;
import 'package:dartz/dartz.dart';

import 'app_error.dart';

class MovieRepository {
  Future<Either<AppError, List<Movie>>> getAllMovies(
      String sortName, String genre) async {
    try {
      final data = await ApiClient.getInstance().get(
        MOVIE_LIST,
        genre == 'All'
            ? {
                'limit': 20,
                'sort_by': sortName,
              }
            : {
                'limit': 20,
                'sort_by': sortName,
                'genre': genre,
              },
      );
      MovieResponse movieResponse = MovieResponse.fromJson(data);
      return Right(movieResponse.data.movies);
    } on HttpException catch (error) {
      return Left(AppError(error.toString()));
    }
  }

  Future<Either<AppError, movieDetail.Movie>> getMovieDetailWith(
      String id) async {
    try {
      final response = await ApiClient.getInstance().get(MOVIE_DETAIL, {
        'movie_id': id,
        'with_images': true,
        'with_cast': true,
      });
      movieDetail.MovieDetail detail =
          movieDetail.MovieDetail.fromJson(response);
      return Right(detail.data.movie);
    } catch (error) {
      return Left(AppError(error.toString()));
    }
  }
}
