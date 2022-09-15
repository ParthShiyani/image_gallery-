import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_gallary/models/images.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Store> photos = [];

  lodeJasonBank() async {
    String jsonData = await rootBundle.loadString("assets/json/data.json");

    List res = jsonDecode(jsonData);

    setState(() {
      photos = res.map((e) => Store.fromJSON(e)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    lodeJasonBank();
  }

  CarouselController buttonCarouselController = CarouselController();
  int initialPage = 0;
  bool toggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.withOpacity(0.7),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Gallery"),
        // backgroundColor: Colors.blueAccent.withOpacity(0.7),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: StaggeredGrid.count(
            crossAxisCount: 10,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            children: photos
                .map(
                  (e) => StaggeredGridTile.count(
                    crossAxisCellCount: e.crossAxisCellCount,
                    mainAxisCellCount: e.mainAxisCellCount,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.of(context).pushNamed("slider", arguments: e);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(e.image),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "${e.category}  -  ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text("ANIME"),
  //       centerTitle: true,
  //       backgroundColor: Colors.black,
  //     ),
  //     body: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(8),
  //             child: StaggeredGrid.count(
  //               crossAxisCount: 4,
  //               mainAxisSpacing: 4,
  //               crossAxisSpacing: 4,
  //               children: photos
  //                   .map(
  //                     (e) => StaggeredGridTile.count(
  //                       crossAxisCellCount: 2,
  //                       mainAxisCellCount: 2,
  //                       child: InkWell(
  //                         onTap: () {
  //                           Navigator.of(context)
  //                               .pushNamed('slider', arguments: e);
  //                         },
  //                         child: Ink(
  //                           child: Container(
  //                             decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(25),
  //                               image: DecorationImage(
  //                                 image: AssetImage(e.image),
  //                                 fit: BoxFit.fill,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   )
  //                   .toList(),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
