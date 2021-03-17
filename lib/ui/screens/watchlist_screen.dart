import 'package:abatime/providers/movies_provider.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/widgets.dart';
import '../../routes.dart';

class WatchListScreen extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: Text('My Watchlist'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: provider.getAllWatchList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CustomLoading();
            } else if (!snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      FluentIcons.movies_and_tv_24_filled,
                      size: 52.0,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 12.0),
                    Text('No Movies in Watch List.'),
                  ],
                ),
              );
            } else {
              return Container(
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) => Dismissible(
                    key: ValueKey(
                        '${snapshot.data[index].title}/${snapshot.data[index].year}'),
                    background: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          SizedBox(width: 12.0),
                        ],
                      ),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      provider.deleteItem(snapshot.data[index].id);
                      scaffoldKey.currentState
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text('Removed from watch list.'),
                            backgroundColor: Theme.of(context).accentColor,
                          ),
                        );
                    },
                    child: CustomListItem(
                      title: snapshot.data[index].title,
                      subtitle: snapshot.data[index].year.toString(),
                      imageUrl: snapshot.data[index].imageUrl,
                      trailingItem: snapshot.data[index].rating.toString(),
                      onTap: () => Navigator.of(context).pushNamed(
                          Routes.movieDetailScreen,
                          arguments: snapshot.data[index].id),
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
