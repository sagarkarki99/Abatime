import 'package:abatime/models/MovieDetail.dart';
import 'package:abatime/providers/base_provider.dart';
import 'package:abatime/repository/app_error.dart';
import 'package:abatime/repository/movie_repository.dart';
import 'package:dartz/dartz.dart';

class DetailProvider extends BaseProvider{
  final _movieRepository = MovieRepository();
  Movie _detailMovie;

  Movie get detailMovie => _detailMovie;

  Future<void> fetchMovieDetailWith(String id) async {
    Either<AppError,Movie> eitherResult =
        await _movieRepository.getMovieDetailWith(id);

    eitherResult.fold((AppError appError) {
      setErrorMessage(appError.toString());
      setUiState(ViewState.WITHERROR);
    }, (Movie movie) {
      _detailMovie = movie;
      setUiState(ViewState.WITHDATA);
    });
  }

  void addToWatchList(Movie movie) async{
    await _movieRepository.addToWatchList(movie) ;
  }
}