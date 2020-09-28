import 'package:flutter/material.dart';

class ContentHeader extends StatelessWidget {
  final String featuredImage;
  final List<dynamic> genres;
  final num ratings;

  const ContentHeader({Key key, this.featuredImage, this.genres, this.ratings})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 400.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(featuredImage),
            ),
            color: Colors.brown,
          ),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black],
              ),
            ),
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 30,
            child: Row(
              children: [
                ...List.generate(2, (index) => Text(genres[index])).toList(),
                Spacer(),
                Text(ratings.toString()),
                Icon(Icons.star)
              ],
            )),
      ],
    );
  }
}
