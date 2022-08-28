import 'dart:math' as math;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/model/content.dart';

class OffHomeItem extends StatelessWidget {
  final Content content;
  CarouselController carouselController = CarouselController();
  OffHomeItem({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    // Use the controller to change the current page
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
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    // Use the controller to change the current page
                    carouselController.nextPage();
                  },
                  icon: Icon(
                    Icons.double_arrow_sharp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        content.imagePaths.isEmpty ? SizedBox() : SizedBox(height: 15),
        Row(
          children: [
            Text(
              "오늘의 일기",
              style: kSubtitle1,
            ),
            SizedBox(
              width: 40.5,
            ),
            Expanded(
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                  color: Color(0xff219EBC),
                  borderRadius: BorderRadius.all(
                    Radius.circular(2.0),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Text(
              DateFormat('오후 HH:MM', 'ko_KR').format(content.time),
              style: kSubtitle2,
            ),
          ],
        ),
        SizedBox(height: 7),
        Container(
          child: Text(
            content.content,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
