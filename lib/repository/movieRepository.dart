// import 'package:AbaTime/apiClient/apiClient.dart';
// import 'package:AbaTime/model/movie.dart';
// import 'package:AbaTime/model/movieResponse.dart';
// import 'package:AbaTime/repository/httpException.dart';
// import 'package:dio/dio.dart';

// class MovieRepository {
//   Future<List<Movie>> fetchAllMovies() async {
//     try {
//       final data = await ApiClient.getInstance().get(
//         '/list_movies.json',
//         {'limit': 20},
//       );
//       print(data);
//       MovieResponse movieResponse = MovieResponse.fromJson(data);
//       return movieResponse.data.movies;
//     } on DioError catch (error) {
//       throw HttpException(error.toString());
//     }
//   }
// }
