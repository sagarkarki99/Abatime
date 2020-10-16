import 'package:flutter/foundation.dart';

class GenreProvider with ChangeNotifier {
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

  var _selectedGenre = 'All';

  List<String> get allGenres => [...genres];

  String get selectedGenre => _selectedGenre;

  void setSelectedGenre(int index) {
    _selectedGenre = genres[index];
    notifyListeners();
  }
}
