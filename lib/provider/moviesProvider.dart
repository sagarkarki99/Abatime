import 'package:AbaTime/apiClient/apiClient.dart';
import 'package:AbaTime/model/movie.dart';
import 'package:AbaTime/model/movieResponse.dart';
import 'package:AbaTime/repository/httpException.dart';
import 'package:flutter/material.dart';

class MovieProvider extends ChangeNotifier {
  List<Movie> movies = [];

  List<Movie> get allMovies => [...movies];

  Future<void> fetchAllMovies() async {
    try {
      final data = await ApiClient.getInstance().get(
        '/list_movies.json',
        {'limit': 20},
      );
      MovieResponse movieResponse = MovieResponse.fromJson(data);
      movies = movieResponse.data.movies;
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }
}
