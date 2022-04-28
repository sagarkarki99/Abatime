import 'package:dartz/dartz.dart';

import '../models/Movie.dart';
import '../models/MovieDetail.dart' as movieDetail;
import '../models/core/entities/movie_stack.dart';
import '../repository/app_error.dart';
import '../repository/movie_repository.dart';
import 'base_provider.dart';

class MovieProvider extends BaseProvider {
  MovieRepository _movieRepository = MovieRepository();
  movieDetail.Movie? _detailMovie;
  List<Movie> _movies = [];
  List<Movie>? _searchedMovies = [];
  Map<String, List<Movie>> _allMovies = {};

//exposing to UI
  List<Movie> get allMovies => [..._movies];
  List<Movie> get allSearchedMovies => [..._searchedMovies!];
  movieDetail.Movie? get getMovieDetail => _detailMovie;
  Map<String, List<Movie>> get moviesMap => {..._allMovies};

  Future<void> fetchMovies(MovieStack _movieStack, String? genre) async {
    // setUiState(ViewState.LOADING);

    try {
      return Future.value(_movieStack.retrieve(genre));
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<void> fetchMovieDetailWith(String id) async {
    try {
      movieDetail.Movie? movie = await _movieRepository.getMovieDetailWith(id);
      return Future.value(movie);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<void> searchMovieApi(String query) async {
    setUiState(ViewState.LOADING);
    Either<AppError, List<Movie>?> eitherResult =
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

  Future<List<DbMovie>?> getAllWatchList() async {
    List<DbMovie> watchListMovies = await _movieRepository.getAllWatchList();
    if (watchListMovies.isEmpty) {
      return null;
    }
    return watchListMovies;
  }

  Future<void> deleteItem(int? id) async {
    await _movieRepository.removeFromWatchList(id);
    setUiState(ViewState.WITHDATA);
  }
}
