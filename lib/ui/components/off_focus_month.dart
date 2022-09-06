import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/ui/off/home/off_home_state.dart';
import 'package:on_off/ui/off/home/off_home_view_model.dart';
import 'package:provider/provider.dart';


class OffFocusMonth extends StatelessWidget {
  const OffFocusMonth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OffHomeViewModel viewModel = context.watch<OffHomeViewModel>();
    OffHomeState state = viewModel.state;

    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        bottom: 17
      ),
      child: Text(
        DateFormat('yyyy년 MM월', 'ko_KR').format(state.changeCalendarPage),
        style: kTitle2,
      ),
    );
  }
}
