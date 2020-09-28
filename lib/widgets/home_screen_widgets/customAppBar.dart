import 'package:AbaTime/assets.dart';
import 'package:AbaTime/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final scrollOffset;
  const CustomAppBar({Key key, this.scrollOffset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(scrollOffset);
    return ResponsiveWidget(
      mobile: _mobileAppBar(),
      tablet: _tabletAppBar(),
    );
  }

  Widget _mobileAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      color:
          Colors.black.withOpacity((scrollOffset / 360).clamp(0, 1).toDouble()),
      child: Row(
        children: [
          Image.asset(
            Assets.netflixLogo0,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AppBarButton(
                  label: "All Shows",
                  onTap: () => print('AllShows'),
                ),
                _AppBarButton(label: "Movie", onTap: () {}),
                _AppBarButton(label: "My List", onTap: () {}),
                // const Spacer(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _tabletAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      color:
          Colors.black.withOpacity((scrollOffset / 360).clamp(0, 1).toDouble()),
      child: Row(
        children: [
          Image.asset(
            Assets.netflixLogo1,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AppBarButton(label: "Home", onTap: () {}),
                _AppBarButton(
                  label: "TV Shows",
                  onTap: () => print('AllShows'),
                ),
                _AppBarButton(label: "Movies", onTap: () {}),
                _AppBarButton(label: "Latest", onTap: () {}),
                _AppBarButton(label: "My List", onTap: () {}),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 30,
                  ),
                  onPressed: () => print('searching...'),
                ),
                _AppBarButton(label: "KIDS", onTap: () {}),
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                    size: 30,
                  ),
                  onPressed: () => print('searching...'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _AppBarButton extends StatelessWidget {
  final label;
  final Function onTap;
  const _AppBarButton({Key key, this.label, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.grey,
      onTap: onTap,
      child: Container(
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
