import 'package:abatime/config/end_points.dart';
import 'package:abatime/https/api_client.dart';
import 'package:abatime/models/Movie.dart';
import 'package:abatime/models/MovieResponse.dart';
import 'package:abatime/models/core/abatime_stack.dart';
import 'package:abatime/repository/app_error.dart';

class MovieStack extends AbaTimeStack<Movie> {
  final sortBy;
  final stackName;
  List<Movie> _movies = [];
  MovieStack({this.sortBy = '',this.stackName = 'All Movies'});

  List<Movie> get movies {
    if (_movies.isEmpty) {
      throw AppError('No Movies Available');
    }
    return _movies;
  }

  @override
  Future<List<Movie>> find(String query) {
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> retrieve(String genre) async {
    try {
      final data = await ApiClient.getInstance().get(
        '$MOVIE_LIST',
        genre == 'All'
            ? {
                'limit': 20,
                'sort_by': sortBy,
                'order_by': 'des',
              }
            : {
                'limit': 20,
                'sort_by': sortBy,
                'genre': genre,
                'order_by': 'dec'
              },
      );
      MovieResponse movieResponse = MovieResponse.fromJson(data);
      _movies = movieResponse.data.movies;
      return _movies;
    } catch (e) {
      rethrow;
    }
  }
}
