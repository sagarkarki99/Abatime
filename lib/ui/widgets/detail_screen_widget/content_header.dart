import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ContentHeader extends StatelessWidget {
  final String? sc1;
  final String? sc2;
  final String? sc3;

  final Widget? child;

  const ContentHeader({Key? key, this.child, this.sc1, this.sc2, this.sc3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 2,
            height: 400.0,
            autoPlayInterval: Duration(seconds: 4),
          ),
          items: [
            BgImage(featuredImage: sc1),
            BgImage(featuredImage: sc2),
            BgImage(featuredImage: sc3),
          ],
        ),
        Positioned(
          left: 0.0,
          bottom: 30.0,
          child: child!,
        ),
      ],
    );
  }
}

class BgImage extends StatelessWidget {
  final String? featuredImage;

  BgImage({Key? key, this.featuredImage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(featuredImage!),
        ),
        color: Colors.black,
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
    );
  }
}
