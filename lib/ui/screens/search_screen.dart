import 'dart:async';

import 'package:abatime/models/Movie.dart';
import 'package:abatime/providers/all_providers.dart';
import 'package:abatime/providers/base_provider.dart';
import 'package:abatime/shimmers/vertical_list_shimmer.dart';
import 'package:abatime/ui/widgets/search_screen.dart/search_image_tile.dart';
import 'package:abatime/ui/widgets/widgets.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Timer apiCallTimer;

  @override
  void dispose() {
    apiCallTimer?.cancel();
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
          cursorColor: Theme.of(context).accentColor,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search',
            prefixIcon: Icon(FluentIcons.search_24_filled,
                color: Theme.of(context).accentColor),
          ),
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
            return _loadSearchedMoviesGrid(movieProvider.allSearchedMovies);
          } else if (movieProvider.state == ViewState.WITHERROR) {
            return CustomLabelWithIcon(
              label: movieProvider.uiErrorMessage,
              icon: Icons.file_copy_outlined,
            );
          } else {
            return CustomLabelWithIcon(
              icon: FluentIcons.search_28_regular,
              label: 'Search with movies title...',
            );
          }
        }),
      ),
    );
  }

  Widget _loadSearchedMoviesGrid(List<Movie> searchedMovies) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StaggeredGridView.countBuilder(
        primary: false,
        crossAxisCount: 4,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        itemCount: searchedMovies.length,
        itemBuilder: (context, index) {
          Movie movie = searchedMovies[index];
          return SearchImageTile(
            movie: movie,
            onTap: (movie) => Navigator.of(context)
                .pushNamed(Routes.movieDetailScreen, arguments: movie.id),
          );
        },
        staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
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
          onTap: () => Navigator.of(context).pushNamed(Routes.movieDetailScreen,
              arguments: searchedMovies[index].id),
        ),
      ),
    );
  }
}
