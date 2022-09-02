import 'package:flutter/material.dart';

//off 화면에서
List<Widget> buildSelectedIcons(List<String> seletcedIconPaths) {
  List<Widget> res = [];
  dynamic item;
  if (seletcedIconPaths.length > 0)
    for (var i in seletcedIconPaths) {
      item = Image(
        image: AssetImage(i),
        width: 14,
        height: 14,
      );
      res.add(item);
    }

  return res;
}
