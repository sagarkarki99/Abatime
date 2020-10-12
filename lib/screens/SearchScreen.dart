import 'dart:async';

import 'package:AbaTime/model/movie.dart';
import 'package:AbaTime/provider/allProviders.dart';
import 'package:AbaTime/provider/baseProvider.dart';
import 'package:AbaTime/shimmers/verticalListShimmer.dart';
import 'package:AbaTime/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../routes.dart' as routes;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Timer apiCallTimer;
  Future<List<Movie>> _searchedMoviesFuture;

  @override
  void dispose() {
    apiCallTimer.cancel();
    super.dispose();
  }

  _searchMovieWith(String query) {
    if (apiCallTimer != null) {
      apiCallTimer.cancel();
    }
    apiCallTimer = Timer(Duration(seconds: 1), () {
      Provider.of<MovieProvider>(context, listen: false).searchMovieApi(query);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: TextField(
          autofocus: true,
          autocorrect: true,
          cursorColor: Colors.white,
          decoration:
              InputDecoration(border: InputBorder.none, hintText: 'Search'),
          onChanged: (inputQuery) => _searchMovieWith(inputQuery),
          onSubmitted: (inputQuery) => _searchMovieWith(inputQuery),
        ),
      ),
      body: SafeArea(
        child:
            Consumer<MovieProvider>(builder: (context, movieProvider, child) {
          print(movieProvider.state);
          if (movieProvider.state == ViewState.LOADING) {
            return VerticalListShimmer();
          } else if (movieProvider.state == ViewState.WITHDATA) {
            return _loadSearchedMoviesList(movieProvider.allSearchedMovies);
          } else if (movieProvider.state == ViewState.WITHERROR) {
            return CustomLabelWithIcon(
              label: movieProvider.getMovieErrorMessage,
              icon: Icons.file_copy_outlined,
            );
          } else {
            return CustomLabelWithIcon(
              icon: Icons.search,
              label: 'Search with movies title, actor name ...',
            );
          }
        }),
      ),
    );
  }

  Widget _loadSearchedMoviesList(List<Movie> searchedMovies) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: searchedMovies.length,
        itemBuilder: (context, index) => CustomListItem(
          title: searchedMovies[index].title,
          subtitle: searchedMovies[index].year.toString(),
          trailingItem: searchedMovies[index].rating.toString(),
          imageUrl: searchedMovies[index].smallCoverImage,
          onTap: () => Navigator.of(context).pushNamed(routes.movieDetailScreen,
              arguments: searchedMovies[index].id),
        ),
      ),
    );
  }
}
