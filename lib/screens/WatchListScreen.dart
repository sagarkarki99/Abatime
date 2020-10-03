import 'package:AbaTime/provider/moviesProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/widgets.dart';
import '../routes.dart' as routes;

class WatchListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: Text('MY List'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: Provider.of<MovieProvider>(context).getAllWatchList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CustomLoading();
            } else if (!snapshot.hasData) {
              return Center(
                child: Text('No Movies in Watch List.'),
              );
            } else {
              return Container(
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) =>
                      WatchMovieItem(movie: snapshot.data[index]),
                ),
              );
            }
          }),
    );
  }
}

class WatchMovieItem extends StatelessWidget {
  final DbMovie movie;

  const WatchMovieItem({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).secondaryHeaderColor,
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        leading: Image.network(
          movie.imageUrl,
          fit: BoxFit.cover,
        ),
        title: Text(
          movie.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline6.copyWith(
              color: Colors.white,
              letterSpacing: 1.0,
              fontWeight: FontWeight.normal),
        ),
        subtitle: Text(
          movie.year.toString(),
          style: Theme.of(context)
              .textTheme
              .caption
              .copyWith(color: Colors.white60, letterSpacing: 1.0),
        ),
        trailing: Text(movie.rating.toString()),
        onTap: () => Navigator.of(context)
            .pushNamed(routes.movieDetailScreen, arguments: movie.id),
      ),
    );
  }
}
