import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            title: Text(
              'Aba Time',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(letterSpacing: -1.5),
            ),
            floating: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              vertical: 4.0,
            ),
            sliver: SliverToBoxAdapter(
              child: MovieContainer(
                key: PageStorageKey('NewMovies'),
                title: "New Movies",
              ),
            ),
          ),
          // SliverPadding(
          //   padding: const EdgeInsets.symmetric(vertical: 4.0),
          //   sliver: SliverToBoxAdapter(
          //     child: PreviewContainer(
          //       key: PageStorageKey('myLists'),
          //       title: "My Lists",
          //       lists: myList,
          //     ),
          //   ),
          // ),
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
