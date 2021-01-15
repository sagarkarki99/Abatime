import 'package:AbaTime/models/Movie.dart';
import 'package:AbaTime/models/MovieDetail.dart' as movieDetail;
import 'package:AbaTime/repository/app_error.dart';
import 'package:AbaTime/repository/movie_repository.dart';
import 'package:dartz/dartz.dart';

import 'base_provider.dart';

class MovieProvider extends BaseProvider {
  MovieRepository _movieRepository = MovieRepository();
  movieDetail.Movie _detailMovie;
  List<Movie> _movies = [];
  List<Movie> _searchedMovies = [];
  Map<String, List<Movie>> _allMovies = {};

//exposing to UI
  List<Movie> get allMovies => [..._movies];
  List<Movie> get allSearchedMovies => [..._searchedMovies];
  movieDetail.Movie get getMovieDetail => _detailMovie;
  Map<String, List<Movie>> get moviesMap => {..._allMovies};

  Future<void> fetchMovies(String sortName, String genre) async {
    // setUiState(ViewState.LOADING);

    Either<AppError, List<Movie>> eitherResult =
        await _movieRepository.getAllMovies(sortName, genre);
    eitherResult.fold((AppError error) {
      setErrorMessage(error.toString());
      setUiState(ViewState.WITHERROR);
      return Future<String>.error(
          error.toString(), StackTrace.fromString(error.toString()));
    }, (List<Movie> movies) {
      _movies = movies;
      _allMovies[sortName] = movies;
      setUiState(ViewState.WITHDATA);
    });
  }

  Future<void> fetchMovieDetailWith(String id) async {
    Either<AppError, movieDetail.Movie> eitherResult =
        await _movieRepository.getMovieDetailWith(id);

    eitherResult.fold((AppError appError) {
      setErrorMessage(appError.toString());
      setUiState(ViewState.WITHERROR);
    }, (movieDetail.Movie movie) {
      _detailMovie = movie;
      setUiState(ViewState.WITHDATA);
    });
  }

  Future<void> searchMovieApi(String query) async {
    setUiState(ViewState.LOADING);
    Either<AppError, List<Movie>> eitherResult =
        await _movieRepository.getSearchedMoviesWith(query);
    eitherResult.fold((appError) {
      setErrorMessage(appError.toString());
      setUiState(ViewState.WITHERROR);
    }, (movies) {
      _searchedMovies = movies;
      setUiState(ViewState.WITHDATA);
    });
  }

  Future<void> addToWatchList(movieDetail.Movie movie) async {
    await _movieRepository.addToWatchList(movie);
  }

  Future<List<DbMovie>> getAllWatchList() async {
    List<DbMovie> watchListMovies = await _movieRepository.getAllWatchList();
    if (watchListMovies.isEmpty) {
      return null;
    }
    return watchListMovies;
  }
}
