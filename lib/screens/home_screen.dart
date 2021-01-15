import 'package:AbaTime/providers/genre_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _moviesDivision(Map<String, String> title, String genre) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
      ),
      sliver: SliverToBoxAdapter(
        child: MovieContainer(
            key: PageStorageKey(title.keys.first), title: title, genre: genre),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final genre = Provider.of<GenreProvider>(context).selectedGenre;
    print('sliver rebuild with $genre genre');
    return Scaffold(
      // extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          CustomAppBar(),
          _moviesDivision({'date_added': 'Recently Added'}, genre),
          _moviesDivision({'rating': 'Top Rated'}, genre),
          _moviesDivision({'download_count': 'Most Downloaded'}, genre),
          _moviesDivision({'like_count': 'Top Favourites'}, genre),
        ],
      ),
    );
  }
}
