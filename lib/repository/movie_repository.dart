import 'package:dartz/dartz.dart';

import '../config/end_points.dart';
import '../https/api_client.dart';
import '../models/Movie.dart';
import '../models/MovieDetail.dart' as movieDetail;
import '../models/MovieResponse.dart';
import '../repository/local_database.dart' as localDb;
import 'app_error.dart';
import 'fake_movie_list.dart';

class MovieRepository {
  Future<Either<AppError, List<Movie>?>> getAllMovies(
      String sortName, String genre) async {
    try {
      final data = await ApiClient.getInstance().get(
        MOVIE_LIST,
        genre == 'All'
            ? {
                'limit': 20,
                'sort_by': sortName,
                'order_by': 'des',
              }
            : {
                'limit': 20,
                'sort_by': sortName,
                'genre': genre,
                'order_by': 'dec'
              },
      );

      // final Map<String, dynamic> data = _getDemoData(sortName);
      MovieResponse movieResponse = MovieResponse.fromJson(data);
      return Right(movieResponse.data!.movies);
    } on HttpException catch (error) {
      return Left(AppError(error.toString()));
    }
  }

  Future<movieDetail.Movie?> getMovieDetailWith(String id) async {
    try {
      final response = await ApiClient.getInstance().get(MOVIE_DETAIL, {
        'movie_id': id,
        'with_images': true,
        'with_cast': true,
      });
      movieDetail.MovieDetail detail =
          movieDetail.MovieDetail.fromJson(response);
      return detail.data!.movie;
    } catch (error) {
      throw AppError(error.toString());
    }
  }

  Future<Either<AppError, List<Movie>?>> getSearchedMoviesWith(
      String query) async {
    try {
      final responses = await ApiClient.getInstance().get(MOVIE_LIST, {
        'query_term': query,
      });
      MovieResponse movieResponse = MovieResponse.fromJson(responses);
      if (movieResponse.data!.movies != null) {
        return Right(movieResponse.data!.movies);
      } else {
        return Left(AppError('No Result Found, Try Something Different!'));
      }
    } catch (error) {
      return Left(AppError(error.toString()));
    }
  }

  Future<void> addToWatchList(movieDetail.Movie movie) async {
    Map<String, dynamic> data = {
      'id': movie.id,
      'title': movie.title,
      'year': movie.year,
      'rating': movie.rating,
      'imageUrl': movie.mediumCoverImage
    };
    await localDb.insert(tableName: 'movies_table', data: data);
  }

  Future<List<DbMovie>> getAllWatchList() async {
    final List<Map<String, dynamic>> maps =
        await (localDb.retrieve(tableName: 'movies_table'));

    List<DbMovie> dbMovies = (maps)
        .map(
          (movie) => DbMovie(
            id: movie['id'],
            title: movie['title'],
            year: movie['year'],
            rating: movie['rating'],
            imageUrl: movie['imageUrl'],
          ),
        )
        .toList();
    return dbMovies;
  }

  removeFromWatchList(int? id) async {
    await localDb.delete(id, 'movies_table');
  }

  Map<String, dynamic>? _getDemoData(String sortName) {
    return fakeMovies[sortName];
  }
}

class DbMovie {
  final id;
  final title;
  final year;
  final rating;
  final imageUrl;

  DbMovie({this.id, this.title, this.year, this.rating, this.imageUrl});
}
