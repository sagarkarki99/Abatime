import 'package:AbaTime/https/api_client.dart';
import 'package:AbaTime/config/end_points.dart';
import 'package:AbaTime/models/Movie.dart';
import 'package:AbaTime/models/MovieDetail.dart' as movieDetail;
import 'package:AbaTime/models/MovieResponse.dart';
import 'package:AbaTime/repository/app_error.dart';
import 'package:AbaTime/repository/movie_repository.dart';
import 'package:dartz/dartz.dart';
import '../repository/local_database.dart' as localDb;
import 'base_provider.dart';

class MovieProvider extends BaseProvider {
  MovieRepository _movieRepository = MovieRepository();
  movieDetail.Movie _detailMovie;
  List<Movie> _movies = [];
  List<Movie> _searchedMovies = [];

//exposing to UI
  List<Movie> get allMovies => [..._movies];
  List<Movie> get allSearchedMovies => [..._searchedMovies];
  movieDetail.Movie get getMovieDetail => _detailMovie;

  Future<void> fetchAllMovies(String sortName, String genre) async {
    Either<AppError, List<Movie>> eitherResult =
        await _movieRepository.getAllMovies(sortName, genre);
    eitherResult.fold((AppError error) {
      print(error.toString());
      setUiState(ViewState.WITHERROR);
    }, (List<Movie> movies) {
      _movies = movies;
      notifyListeners();
    });
  }

  Future<void> fetchMovieDetailWith(String id) async {
    Either<AppError, movieDetail.Movie> eitherResult =
        await _movieRepository.getMovieDetailWith(id);

    eitherResult.fold((AppError appError) {
      setErrorMessage(appError.toString());
    }, (movieDetail.Movie movie) {
      _detailMovie = movie;

      notifyListeners();
      // setUiState(ViewState.WITHDATA);
    });
  }

  Future<void> searchMovieApi(String query) async {
    setUiState(ViewState.LOADING);
    try {
      final responses = await ApiClient.getInstance().get(MOVIE_LIST, {
        'query_term': query,
      });
      MovieResponse movieResponse = MovieResponse.fromJson(responses);
      if (movieResponse.data.movies != null) {
        _searchedMovies = movieResponse.data.movies;
        // notifyListeners();
        setUiState(ViewState.WITHDATA);
      } else {
        setErrorMessage('No Result Found!');
        setUiState(ViewState.WITHERROR);
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
}

class DbMovie {
  final id;
  final title;
  final year;
  final rating;
  final imageUrl;

  DbMovie({this.id, this.title, this.year, this.rating, this.imageUrl});
}
