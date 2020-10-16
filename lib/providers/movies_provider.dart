import 'package:AbaTime/https/api_client.dart';
import 'package:AbaTime/config/end_points.dart';
import 'package:AbaTime/models/Movie.dart';
import 'package:AbaTime/models/MovieDetail.dart' as movieDetail;
import 'package:AbaTime/models/MovieResponse.dart';
import 'package:AbaTime/repository/http_exception.dart';
import '../repository/local_database.dart' as localDb;
import 'base_provider.dart';

class MovieProvider extends BaseProvider {
  List<Movie> movies = [];
  List<Movie> _searchedMovies = [];
  String _moviesErrorMessage = 'Something went wrong!';

//exposing to UI
  List<Movie> get allMovies => [...movies];
  List<Movie> get allSearchedMovies => [..._searchedMovies];
  String get getMovieErrorMessage => _moviesErrorMessage;

  Future<void> fetchAllMovies(String sortName, String genre) async {
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
      movies = movieResponse.data.movies;
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<movieDetail.Movie> fetchMovieDetail(String id) async {
    try {
      final response = await ApiClient.getInstance().get(MOVIE_DETAIL, {
        'movie_id': id,
        'with_images': true,
        'with_cast': true,
      });
      movieDetail.MovieDetail detail =
          movieDetail.MovieDetail.fromJson(response);
      return detail.data.movie;
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<void> searchMovieApi(String query) async {
    setState(ViewState.LOADING);
    try {
      final responses = await ApiClient.getInstance().get(MOVIE_LIST, {
        'query_term': query,
      });
      MovieResponse movieResponse = MovieResponse.fromJson(responses);
      if (movieResponse.data.movies != null) {
        _searchedMovies = movieResponse.data.movies;
        // notifyListeners();
        setState(ViewState.WITHDATA);
      } else {
        setErrorMessage('No Result Found!');
        setState(ViewState.WITHERROR);
      }

      print(_searchedMovies);
    } catch (error) {
      setErrorMessage(error.toString());
    }
  }

  void addToWatchList(movieDetail.Movie movie) async {
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
        await localDb.retrieve(tableName: 'movies_table');

    List<DbMovie> movies = maps
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
    return movies;
  }

  void setErrorMessage(String message) {
    _moviesErrorMessage = message;
    notifyListeners();
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
