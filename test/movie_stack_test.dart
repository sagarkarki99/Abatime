import 'package:AbaTime/https/api_client.dart';
import 'package:AbaTime/models/core/entities/movie_stack.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart' as matcher;

void main() {
  group('container of movie data test', () {
    test(
        'throw exception when creating MovieStack when failed to fetch movies from api.',
        () {
      final moviesStack = MovieStack(sortBy: 'recently_added');

      expect(() async => await moviesStack.retrieve('All'),
          throwsA(matcher.TypeMatcher<HttpException>()));
    });
  });
}
