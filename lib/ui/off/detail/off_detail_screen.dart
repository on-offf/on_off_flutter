import 'dart:math' as math;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/model/content.dart';

class OffDetailScreen extends StatefulWidget {
  static const routeName = '/off/detail';

  const OffDetailScreen({Key? key}) : super(key: key);

  @override
  State<OffDetailScreen> createState() => _OffDetailScreenState();
}

class _OffDetailScreenState extends State<OffDetailScreen> {
  CarouselController carouselController = CarouselController();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, Content>;
    final Content content = routeArgs['content']!;

    return Scaffold(
      appBar: offAppBar(context),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 37,
        ),
        child: Column(children: [
          Row(
            children: [
              Text(
                DateFormat.MMMMEEEEd('ko_KR').format(content.time),
                style: kSubtitle2,
              ),
              SizedBox(width: 14),
              Image(
                image: AssetImage("assets/icons/plus.png"),
                width: 14,
                height: 14,
              ),
              SizedBox(width: 14),
              Expanded(
                child: Container(
                  height: 2,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 23),
          content.imagePaths.isEmpty
              ? SizedBox()
              : SizedBox(
                  width: 313,
                  height: 240,
                  child: Stack(
                    children: [
                      CarouselSlider(
                        carouselController: carouselController,
                        options: CarouselOptions(
                          initialPage: 0,
                          enableInfiniteScroll: false,
                          viewportFraction: 1.0,
                          aspectRatio: 313 / 240,
                          onPageChanged: (index, reason) {
                            _currentIndex = index;
                            setState(() {});
                          },
                        ),
                        items: content.imagePaths.map((img) {
                          return Container(
                            child: Image.asset(
                              img,
                              fit: BoxFit.fill,
                            ),
                          );
                        }).toList(),
                      ),
                      _currentIndex > 0
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                onPressed: () {
                                  carouselController.previousPage();
                                },
                                icon: Transform.rotate(
                                  angle: 180 * math.pi / 180,
                                  child: Icon(
                                    Icons.double_arrow_sharp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                      _currentIndex < content.imagePaths.length - 1
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () {
                                  carouselController.nextPage();
                                },
                                icon: Icon(
                                  Icons.double_arrow_sharp,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
          content.imagePaths.isEmpty ? SizedBox() : SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 10),
              Text(
                DateFormat('오후 HH:MM', 'ko_KR').format(content.time),
                style: kSubtitle2,
              ),
            ],
          ),
          SizedBox(height: 7),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                content.content,
                softWrap: true,
              ),
            ),
          ),
          SizedBox(height: 41),
        ]),
      ),
    );
  }
}
