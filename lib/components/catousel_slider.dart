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
    Image.asset('assets/images/banners/4.png'),
    Image.asset('assets/images/banners/5.png'),
    Image.asset('assets/images/banners/6.png'),
  ];

  int myCurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            height: 170,
            //width = 414
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: const Duration(milliseconds: 12000),
            enableInfiniteScroll: true,
            autoPlayInterval: const Duration(seconds: 3),
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            enlargeCenterPage: true,
            aspectRatio: 3.0,
            onPageChanged: (index, reason) {
              setState(() {
                myCurrentIndex = index;
              });
            },
          ),
          items: imgSldImages.map((image) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context)
                      .size
                      .width, // Set the height for the aspect ratio
                  color: Color.fromARGB(255, 220, 214, 252),
                  margin: EdgeInsets.symmetric(horizontal: 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image(
                      image: image
                          .image,
                      fit: BoxFit
                          .cover, 
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(
          height: 5,
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
