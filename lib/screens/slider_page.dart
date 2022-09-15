import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Photo_slider extends StatefulWidget {
  const Photo_slider({Key? key}) : super(key: key);

  @override
  State<Photo_slider> createState() => _Photo_sliderState();
}

class _Photo_sliderState extends State<Photo_slider> {
  CarouselController buttonCarouselController = CarouselController();
  int initialPage = 0;
  bool view = false;
  @override
  Widget build(BuildContext context) {
    dynamic res = ModalRoute.of(context)!.settings.arguments;
    List images = res.images as List;
    return Scaffold(
      backgroundColor: Colors.blueGrey.withOpacity(0.9),
      appBar: AppBar(
        title: Text(res.category),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CarouselSlider(
            carouselController: buttonCarouselController,
            options: CarouselOptions(
              scrollPhysics: const BouncingScrollPhysics(),
              clipBehavior: Clip.antiAlias,
              height: 400.0,
              viewportFraction: 0.7,
              initialPage: initialPage,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
              autoPlayCurve: Curves.slowMiddle,
              enlargeCenterPage: true,
              onPageChanged: (val, _) {
                setState(() {
                  initialPage = val;
                });
              },
              scrollDirection: Axis.vertical,
            ),
            items: images.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: const BoxDecoration(),
                    child: Image.asset(
                      i,
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.high,
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...images.map((e) {
                int i = images.indexOf(e);
                return Row(
                  children: [
                    InkWell(
                      onTap: () {
                        buttonCarouselController.animateToPage(i);
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color:
                              (initialPage == i) ? Colors.black : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                  ],
                );
              }).toList(),
            ],
          ),
        ],
      ),
      floatingActionButton: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 30,
          ),
          FloatingActionButton(
            onPressed: () => buttonCarouselController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.slowMiddle),
            child: const Icon(Icons.arrow_back_sharp),
            mini: true,
          ),
          Spacer(),
          FloatingActionButton(
            onPressed: () => buttonCarouselController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.slowMiddle),
            child: const Icon(Icons.arrow_forward),
            mini: true,
          ),
        ],
      ),
    );
  }
}
