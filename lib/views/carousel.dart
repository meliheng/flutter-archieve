import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {
  const Carousel({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          autoPlayInterval: Duration(
            milliseconds: 1000,
          ), // Neredeyse anlık geçiş
          autoPlayAnimationDuration: Duration(
            milliseconds: 1000,
          ), // Animasyon süresi
          autoPlayCurve: Curves.linear, // Lineer geçiş
          pauseAutoPlayOnTouch: false, // Dokununca durmasın
          pauseAutoPlayOnManualNavigate: false, // Manuel geçişte durmasın
          pauseAutoPlayInFiniteScroll: false, // Sonsuz scrollda durmasın
          enableInfiniteScroll: true,
        ),
        items:
            [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    clipBehavior: Clip.hardEdge,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Image.network(
                      "https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U",
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }).toList(),
      ),
    );
  }
}
