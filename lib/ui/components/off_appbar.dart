import 'package:flutter/material.dart';
import 'package:on_off/domain/icon/icon_path.dart';

PreferredSize offAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(77),
    child: AppBar(
      toolbarHeight: 77,
      leading: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Image(
          image: AssetImage(IconPath.setting.name),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            print('click change on & off');
          },
          child: Image(
            image: AssetImage(IconPath.changeCategory.name),
            width: 17,
            height: 26,
          ),
        ),
        const SizedBox(
          width: 14.42,
        ),
        GestureDetector(
          onTap: () {
            print('click setting');
          },
          child: Image(
            image: AssetImage(IconPath.setting.name),
            width: 24.17,
            height: 24.76,
          ),
        ),
        const SizedBox(
          width: 40,
        ),
      ],
      elevation: 0.0,
      backgroundColor: Theme.of(context).canvasColor,
    ),
  );
}
