import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String trailingItem;
  final Function onTap;

  const CustomListItem(
      {Key key,
      this.title,
      this.subtitle,
      this.imageUrl,
      this.trailingItem,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).secondaryHeaderColor,
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        leading: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
        title: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline6.copyWith(
              color: Colors.white,
              letterSpacing: 1.0,
              fontWeight: FontWeight.normal),
        ),
        subtitle: Text(
          subtitle.toString(),
          style: Theme.of(context)
              .textTheme
              .caption
              .copyWith(color: Colors.white60, letterSpacing: 1.0),
        ),
        trailing: Text(trailingItem.toString()),
        onTap: () => onTap(),
      ),
    );
  }
}
