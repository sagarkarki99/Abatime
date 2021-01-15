import 'package:AbaTime/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/widgets.dart';
import '../routes.dart';

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
                  itemBuilder: (context, index) => CustomListItem(
                    title: snapshot.data[index].title,
                    subtitle: snapshot.data[index].year.toString(),
                    imageUrl: snapshot.data[index].imageUrl,
                    trailingItem: snapshot.data[index].rating.toString(),
                    onTap: () => Navigator.of(context).pushNamed(
                        Routes.movieDetailScreen,
                        arguments: snapshot.data[index].id),
                  ),
                ),
              );
            }
          }),
    );
  }
}
