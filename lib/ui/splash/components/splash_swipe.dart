import 'package:flutter/material.dart';

class SplashSwipe extends StatelessWidget {
  const SplashSwipe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          GestureDetector(
            child: AnimatedContainer(
              width: 264.3,
              height: 48.33,
              duration: const Duration(seconds: 1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(27),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff219EBC),
                    Color(0xffFFB703),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 0, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'ON',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 20,
                        height: 1.362,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'OFF',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 20,
                        height: 1.362,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 2.15,
            left: 264.3 / 2 - 22,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Colors.white,
              ),
            ),
          )
        ]
    );
  }
}
