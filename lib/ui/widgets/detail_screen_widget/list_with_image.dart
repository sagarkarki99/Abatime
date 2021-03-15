import 'package:abatime/models/MovieDetail.dart';
import 'package:flutter/material.dart';

class CastContainer extends StatelessWidget {
  final List<Cast> casts;

  const CastContainer({Key key, this.casts}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Cast', style: Theme.of(context).textTheme.headline6),
        ),
        Container(
          height: 150.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: casts.length,
            itemBuilder: (context, index) => CastItem(
              cast: casts[index],
            ),
          ),
        ),
      ],
    );
  }
}

class CastItem extends StatelessWidget {
  final cast;

  const CastItem({Key key, this.cast}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 150,
      width: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Image.network(
              cast.urlSmallImage,
              width: 100,
              fit: BoxFit.fill,
            ),
          ),
          Text(
            cast.name,
            style: Theme.of(context).textTheme.bodyText1,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            cast.characterName,
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
