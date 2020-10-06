import 'package:flutter/material.dart';

import 'package:AbaTime/apiClient/apiClient.dart';
import 'package:AbaTime/config/endpoints.dart';
import 'package:AbaTime/model/movie.dart';
import 'package:AbaTime/model/movieDetail.dart' as movieDetail;
import 'package:AbaTime/model/movieResponse.dart';
import 'package:AbaTime/repository/httpException.dart';
import '../repository/localDatabase.dart' as localDb;

class MovieProvider extends ChangeNotifier {
  List<Movie> movies = [];
  List<Movie> _searchedMovies;

  List<Movie> get allMovies => [...movies];
  List<Movie> get allSearchedMovies => [..._searchedMovies];

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
    _searchedMovies = List();
    notifyListeners();
    try {
      final responses = await ApiClient.getInstance().get(MOVIE_LIST, {
        'query_term': query,
      });
      MovieResponse movieResponse = MovieResponse.fromJson(responses);
      print(responses);

      _searchedMovies = [...movieResponse.data.movies];
      notifyListeners();
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  addToWatchList(movieDetail.Movie movie) async {
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
