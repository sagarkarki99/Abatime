import 'package:abatime/providers/movies_provider.dart';
import 'package:abatime/ui/ui_utils.dart/slide_transition_container.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../repository/movie_repository.dart';
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
        title: Text('My Watch List',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Colors.white)),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: provider.getAllWatchList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CustomLoading();
            } else if (!snapshot.hasData) {
              return Center(
                  child: SlideTransitionContainer(
                child: CustomLabelWithIcon(
                  icon: FluentIcons.movies_and_tv_24_filled,
                  label: 'No Movies in Watch List.',
                ),
              ));
            } else {
              final data = snapshot.data as List<DbMovie>;
              return Container(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) => Dismissible(
                    key: ValueKey('${data[index].title}/${data[index].year}'),
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
                      provider.deleteItem(data[index].id);
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text('Removed from watch list.'),
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                          ),
                        );
                    },
                    child: CustomListItem(
                      title: data[index].title,
                      subtitle: data[index].year.toString(),
                      imageUrl: data[index].imageUrl,
                      trailingItem: data[index].rating.toString(),
                      onTap: () => Navigator.of(context).pushNamed(
                          Routes.movieDetailScreen,
                          arguments: data[index].id),
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
