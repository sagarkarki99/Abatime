import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          CustomAppBar(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              vertical: 4.0,
            ),
            sliver: SliverToBoxAdapter(
              child: MovieContainer(
                key: PageStorageKey('NewMovies'),
                title: "Recently Added",
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            sliver: SliverToBoxAdapter(
              child: MovieContainer(
                key: PageStorageKey('topRated'),
                title: "Top Rated",
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            sliver: SliverToBoxAdapter(
              child: MovieContainer(
                key: PageStorageKey('Most Downloaded'),
                title: "Most Downloads",
              ),
            ),
          ),
          // SliverPadding(
          //   padding: const EdgeInsets.symmetric(vertical: 4.0),
          //   sliver: SliverToBoxAdapter(
          //     child: PreviewContainer(
          //       key: PageStorageKey('priviews'),
          //       title: "Netflix Originals",
          //       lists: originals,
          //       isNetflixOriginal: true,
          //     ),
          //   ),
          // ),
          // SliverPadding(
          //   padding: const EdgeInsets.symmetric(vertical: 4.0),
          //   sliver: SliverToBoxAdapter(
          //     child: PreviewContainer(
          //       key: PageStorageKey('priviews'),
          //       title: "Trendings",
          //       lists: trending,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
