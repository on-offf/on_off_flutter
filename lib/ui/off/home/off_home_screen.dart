import 'package:flutter/material.dart';
import 'package:on_off/ui/components/off_appbar.dart';
import 'package:on_off/ui/off/home/components/off_home_calendar.dart';

import 'package:on_off/ui/off/home/components/off_home_item.dart';

import '../../components/off_focus_month.dart';

class OffHomeScreen extends StatelessWidget {
  static const routeName = '/off/home';

  const OffHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: offAppBar(context),
      body: Padding(
        padding: const EdgeInsets.only(left: 37, right: 37, bottom: 41),
        child: ListView(
          children: [
            const OffFocusMonth(),
            const OffHomeCalendar(),
            const SizedBox(
              height: 47.5,
            ),
            OffHomeItem(),
            const SizedBox(height: 41),
          ],
        ),
      ),
    );
  }
}
