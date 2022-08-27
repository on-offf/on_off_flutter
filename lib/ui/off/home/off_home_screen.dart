import 'package:flutter/material.dart';
import 'package:on_off/ui/off/home/components/off_home_calendar.dart';

class OffHomeScreen extends StatelessWidget {
  static const routeName = '/off/home';

  const OffHomeScreen({Key? key}) : super(key: key);

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
        padding: const EdgeInsets.only(left: 37, right: 37, bottom: 41),
        child: Column(
          children: [
            OffHomeCalendar(),
          ],
        ),
      ),
    );
  }
}
