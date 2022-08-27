import 'package:flutter/material.dart';

PreferredSize offAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(77),
    child: AppBar(
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
  );
}
