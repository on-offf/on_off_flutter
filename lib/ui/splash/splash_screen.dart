import 'package:flutter/material.dart';
import 'package:on_off/ui/splash/components/splash_swipe.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SplashSwipe(),
            SizedBox(height: 10.44,),
            Text(
              '원하는 옵션으로 밀어주세요!',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: 0.15,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
