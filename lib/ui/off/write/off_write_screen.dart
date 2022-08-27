import 'package:flutter/material.dart';
import 'package:on_off/constants/constants_text_style.dart';

class OffWriteScreen extends StatelessWidget {
  static const routeName = "/off/write";
  var bodyController = TextEditingController();

  OffWriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.symmetric(horizontal: 37),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text(
                  "2022년 8월 첫째주",
                  style: kSubtitle1,
                ),
                SizedBox(
                  width: 6.38,
                ),
                Image(
                  image: AssetImage("assets/icons/down_arrow.png"),
                  width: 4.29,
                  height: 6.32,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "8월 2일 목요일",
                  style: kSubtitle2,
                ),
                SizedBox(
                  width: 14,
                ),
                Image(
                  image: AssetImage("assets/icons/plus.png"),
                  width: 14,
                  height: 14,
                ),
                SizedBox(
                  width: 14,
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
            SizedBox(
              height: 10,
            ),
            Text(
              "오후 12:33분",
              style: kSubtitle2,
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: TextField(
                controller: bodyController,
                style: kBody2,
                decoration: const InputDecoration(
                  hintText: '일기를 입력해주세요...',
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
