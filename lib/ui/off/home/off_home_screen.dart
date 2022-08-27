import 'dart:math' as math;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_off/domain/model/content.dart';
import 'package:on_off/ui/off/home/components/off_home_calendar.dart';

import 'package:on_off/constants/constants_text_style.dart';

class OffHomeScreen extends StatelessWidget {
  static const routeName = '/off/home';
  CarouselController carouselController = CarouselController();

  OffHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Content> contents = [
      Content(
        id: 1,
        time: DateTime.utc(2022, 8, 2, 12, 33),
        // date: "8월 2일 목요일",
        // time: "오후 12시 33분",
        content:
            "오늘 수영장을 다녀왔다! 오랜만에 친구들을 만나서 즐거운 시간을 보낸 것 같다!! 요즘 친구들 만난지 오래 되었는데 , 옛날처럼 자주 만났으면 좋겠다 흑흑.... 오늘도 즐거운 하루를 보낸거 같다... 방학이 평생 끝나지 않으면 좋겠다 ㅠㅠ",
        imagePaths: [
          "lib/ui/off/list/content1.png",
          "lib/ui/off/list/content1.png",
        ],
      ),
      Content(
        id: 2,
        time: DateTime.utc(2022, 8, 2, 12, 33),
        // date: "8월 4일 목요일",
        // time: "오후 12시 33분",
        content: "오랜만에 가는 공연! 너무 신나는 하루를 보냈다!! ㅎㅎ 언제쯤 공연 보러 자유롭게 갈 수 있으려나 ㅠㅠ ",
        imagePaths: [
          "lib/ui/off/list/content2.png",
          "lib/ui/off/list/content2.png",
        ],
      ),
      Content(
        id: 3,
        time: DateTime.utc(2022, 8, 2, 12, 33),
        // date: "8월 2일 목요일",
        // time: "오후 12시 33분",
        content:
            "내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용",
        imagePaths: [],
      ),
      Content(
        id: 4,
        time: DateTime.utc(2022, 8, 2, 12, 33),
        // date: "8월 2일 목요일",
        // time: "오후 12시 33분",
        content:
            "오늘 수영장을 다녀왔다! 오랜만에 친구들을 만나서 즐거운 시간을 보낸 것 같다!! 요즘 친구들 만난지 오래 되었는데 , 옛날처럼 자주 만났으면 좋겠다 흑흑.... 오늘도 즐거운 하루를 보낸거 같다... 방학이 평생 끝나지 않으면 좋겠다 ㅠㅠ",
        imagePaths: [
          "lib/ui/off/list/content1.png",
          "lib/ui/off/list/content1.png",
        ],
      ),
      Content(
        id: 5,
        time: DateTime.utc(2022, 8, 2, 12, 33),
        // date: "8월 4일 목요일",
        // time: "오후 12시 33분",
        content: "오랜만에 가는 공연! 너무 신나는 하루를 보냈다!! ㅎㅎ 언제쯤 공연 보러 자유롭게 갈 수 있으려나 ㅠㅠ ",
        imagePaths: [
          "lib/ui/off/list/content2.png",
          "lib/ui/off/list/content2.png",
        ],
      ),
      Content(
        id: 6,
        time: DateTime.utc(2022, 8, 2, 12, 33),
        // date: "8월 2일 목요일",
        // time: "오후 12시 33분",
        content:
            "내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용",
        imagePaths: [],
      ),
    ];

    final Content content = contents[0];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 77,
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              print('click change on & off');
            },
            child: const Image(
              image: AssetImage("assets/icons/change_category.png"),
              width: 22,
              height: 28,
            ),
          ),
          const SizedBox(
            width: 14.42,
          ),
          GestureDetector(
            onTap: () {
              print('click setting');
            },
            child: const Image(
              image: AssetImage("assets/icons/setting.png"),
              width: 24.17,
              height: 24.76,
            ),
          ),
          const SizedBox(
            width: 11.41,
          ),
        ],
        elevation: 0.0,
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 37, right: 37, bottom: 41),
        child: ListView(
          children: [
            OffHomeCalendar(),
            SizedBox(
              height: 47.5,
            ),
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
            SizedBox(height: 41),
          ],
        ),
      ),
    );
  }
}
