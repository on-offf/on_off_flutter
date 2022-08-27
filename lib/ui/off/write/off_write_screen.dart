import 'package:flutter/material.dart';

class OffWriteScreen extends StatelessWidget {
  static const routeName = "/off/write";

  const OffWriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Image(
            image: AssetImage("assets/icons/change_category.png"),
            width: 22,
            height: 28,
          ),
          SizedBox(
            width: 14.42,
          ),
          Image(
            image: AssetImage("assets/icons/setting.png"),
            width: 24.17,
            height: 24.76,
          ),
          SizedBox(
            width: 11.41,
          ),
        ],
        elevation: 0.0,
        backgroundColor: const Color(0xffEBEBEB),
      ),
    );
  }
}
