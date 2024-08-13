import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SimpleCarousel extends StatelessWidget {
  const SimpleCarousel({
    super.key,
    required this.imgList,
  });

  final List<dynamic> imgList;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(autoPlay: true),
      items: imgList
          .map((item) => Container(
                child: Image.network(
                  item['image'],
                  fit: BoxFit.contain,
                ),
              ))
          .toList(),
    );
  }
}
