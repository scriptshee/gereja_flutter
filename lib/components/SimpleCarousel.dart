import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SimpleCarousel extends StatelessWidget {
  const SimpleCarousel({
    super.key,
    required this.imgList,
  });

  final List<String> imgList;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(autoPlay: true),
      items: imgList
          .map((item) => Container(
                color: Colors.green,
                child: Image.network(
                  item,
                  fit: BoxFit.cover,
                ),
              ))
          .toList(),
    );
  }
}
