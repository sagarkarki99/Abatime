import 'package:abatime/providers/genre_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    final genreProvider = Provider.of<GenreProvider>(context, listen: false);
    final genres = genreProvider.allGenres;

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
        child: Container(
          key: PageStorageKey('genres'),
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
          height: 40,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: genres.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: ChoiceChip(
                  selected: genreProvider.selectedGenreIndex == index,
                  onSelected: (selectedValue) {
                    genreProvider.setSelectedGenre(index);
                  },
                  selectedColor: Theme.of(context).accentColor.withOpacity(0.3),
                  labelStyle: TextStyle(
                      color: genreProvider.selectedGenreIndex == index
                          ? Theme.of(context).accentColor
                          : Colors.white60),
                  label: Text(genres[index]),
                  backgroundColor: Theme.of(context).secondaryHeaderColor),
            ),
          ),
        ),
        preferredSize: Size(MediaQuery.of(context).size.width, 50),
      ),
    );
  }
}
