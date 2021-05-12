import 'package:abatime/models/Movie.dart';
import 'package:abatime/models/core/entities/movie_stack.dart';
import 'package:abatime/providers/genre_provider.dart';
import 'package:abatime/ui/widgets/ads_widgets/native_ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../routes.dart';
import '../widgets/widgets.dart';
import '../widgets/ads_widgets/banner_widget.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MovieStack> movieStacks;

  @override
  void initState() {
    super.initState();
    movieStacks = [
      MovieStack(stackName: 'Recently Added', sortBy: 'date_added'),
      MovieStack(sortBy:'year',stackName: 'This Year'),
      MovieStack(sortBy: 'rating', stackName: 'Top Rated'),
      MovieStack(sortBy: 'download_count', stackName: 'Most Downloaded'),
      MovieStack(sortBy: 'like_count', stackName: 'Top Favourites'),
    ];
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
          ...movieStacks
              .map((movieObject) => _moviesDivision(movieObject, genre))
              .toList(),
        ],
      ),
    );
  }

   Widget _moviesDivision(MovieStack stack, String genre) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
      ),
      sliver: SliverToBoxAdapter(
        child: MovieContainer(
          key: PageStorageKey(stack.sortBy),
          movieStack: stack,
          genre: genre,
          onMovieSelect: (movie) => _navigateToNextScreen(context, movie),
        ),
      ),
    );
  }

  _navigateToNextScreen(BuildContext context, Movie movie) {
    Navigator.of(context)
        .pushNamed(Routes.movieDetailScreen, arguments: movie.id);
  }
}
