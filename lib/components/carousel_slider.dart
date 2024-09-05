
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide CarouselController;


class CustomCarouselSlider extends StatelessWidget {
  const CustomCarouselSlider({super.key, required this.items});

  final List<Widget> items;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: items,
      options: CarouselOptions(
        height: 250,
        initialPage: 0,

        autoPlayAnimationDuration: const Duration(seconds: 3),
        autoPlayCurve: Curves.fastOutSlowIn,

        autoPlayInterval: Duration(seconds: 2),

        enableInfiniteScroll: true,
        enlargeCenterPage: true,
        enlargeFactor: .4,
        scrollDirection: Axis.horizontal,
        viewportFraction: .65,
      ),
    );
  }
}
