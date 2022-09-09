import 'package:abatime/models/Movie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class SearchImageTile extends StatelessWidget {
  final Movie? movie;
  final Function(Movie? Movie)? onTap;

  SearchImageTile({this.movie, this.onTap});

  // final _IntSize _size =
  //     _IntSize(Random().nextInt(250) + 100, Random().nextInt(350) + 100);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).primaryColor.withOpacity(0.4),
      onTap: () => onTap!(movie),
      child: Stack(
        children: [
          CachedNetworkImage(
            height: double.infinity,
            width: double.infinity,
            imageUrl: movie!.mediumCoverImage!,
            fit: BoxFit.cover,
          ),
          Container(
            // height: _size.height.toDouble(),
            // width: _size.width.toDouble(),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black87,
                    Colors.transparent,
                  ]),
            ),
          ),
          Positioned(
            top: 12.0,
            right: 12.0,
            child: Row(
              children: [
                Text(
                  movie!.rating.toString(),
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
                Icon(
                  FluentIcons.star_24_filled,
                  color: Theme.of(context).colorScheme.secondary,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IntSize {
  final int width;
  final int height;

  _IntSize(this.width, this.height);
}
