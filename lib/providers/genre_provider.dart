import 'package:flutter/foundation.dart';

class GenreProvider with ChangeNotifier {
  int _selectedGenreIndex = 0;
  final genres = [
    'All',
    'Action',
    'Thriller',
    'Crime',
    'Romance',
    'Adventure',
    'Drama',
    'Sci-fi',
    'Animation',
    'Fantasy',
    'Mystery'
  ];

  List<String> get allGenres => [...genres];
  String get selectedGenre => genres[_selectedGenreIndex];
  int get selectedGenreIndex => _selectedGenreIndex;

  void setSelectedGenre(int index) {
    _selectedGenreIndex = index;
    notifyListeners();
  }
}
