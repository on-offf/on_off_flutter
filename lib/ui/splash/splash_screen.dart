import 'package:flutter/material.dart';
import 'package:on_off/ui/off/detail/off_detail_screen.dart';
import 'package:on_off/ui/off/home/off_home_screen.dart';
import 'package:on_off/ui/off/list/off_list_screen.dart';
import 'package:on_off/ui/off/write/off_write_screen.dart';
import 'package:on_off/ui/splash/components/splash_swipe.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SplashSwipe(),
            SizedBox(
              height: 10.44,
            ),
            Text(
              '원하는 옵션으로 밀어주세요!',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: 0.15,
                height: 1.5,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, OffHomeScreen.routeName);
              },
              child: Text("홈"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, OffWriteScreen.routeName);
              },
              child: Text("작성"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, OffListScreen.routeName);
              },
              child: Text("리스트"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, OffDetailScreen.routeName);
              },
              child: Text("상세페이지"),
            ),
          ],
        ),
      ),
    );
  }
}
