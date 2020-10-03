import 'package:AbaTime/assets.dart';
import 'package:AbaTime/model/movie.dart';
import 'package:AbaTime/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.black,
      title: Text(
        'Aba Time',
        style:
            Theme.of(context).textTheme.headline4.copyWith(letterSpacing: -1.5),
      ),
      centerTitle: true,
      floating: true,
      bottom: PreferredSize(
        child: GestureDetector(
          onTap: () => showSearch(context: context, delegate: MovieSearch()),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).secondaryHeaderColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              'Search',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Color(0xFFa0a0a0)),
            ),
          ),
        ),
        preferredSize: Size(MediaQuery.of(context).size.width, 50),
      ),
    );
  }
}

class MovieSearch extends SearchDelegate<Movie> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.cancel),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text(query);
  }
}
