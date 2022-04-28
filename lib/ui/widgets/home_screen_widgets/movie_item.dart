import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../models/Movie.dart';
import '../../../shimmers/shimmer_item.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 8,
          child: Container(
            margin: const EdgeInsets.fromLTRB(8.0, 2.0, 0.0, 0.0),
            child: CachedNetworkImage(
              imageUrl: movie.mediumCoverImage ?? movie.largeCoverImage!,
              placeholder: (_, url) => ShimmerItem(),
              fadeInDuration: Duration(milliseconds: 500),
              fadeInCurve: Curves.bounceInOut,
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: Row(
              children: [
                Text(
                  movie.rating.toString(),
                ),
                Icon(
                  FluentIcons.star_24_filled,
                  size: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            )),
      ],
    );
  }
}
