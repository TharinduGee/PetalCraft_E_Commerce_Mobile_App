import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyCarouselSlider extends StatefulWidget {
  @override
  State<MyCarouselSlider> createState() => _MyCarouselSliderState();
}

class _MyCarouselSliderState extends State<MyCarouselSlider> {
  final imgSldImages = [
    // Image.asset('assets/images/logo.png'),
    Image.asset('assets/images/vector-1.png'),
    Image.asset('assets/images/vector-2.png'),
    Image.asset('assets/images/vector-1.png'),
  ];

  int myCurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            height: 150,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: const Duration(milliseconds: 8000),
            enableInfiniteScroll: true,
            autoPlayInterval: const Duration(seconds: 2),
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            enlargeCenterPage: true,
            aspectRatio: 3.0,
            onPageChanged: (index, reason) {
              setState(() {
                myCurrentIndex = index;
              });
            },
          ),
          items: imgSldImages,
        ),
        AnimatedSmoothIndicator(
          activeIndex: myCurrentIndex,
          count: imgSldImages.length,
          effect: WormEffect(
              dotHeight: 18,
              dotWidth: 18,
              spacing: 5,
              dotColor: Colors.grey.shade200,
              activeDotColor: Colors.grey.shade900,
              paintStyle: PaintingStyle.fill),
        )
      ],
    );
  }
}
