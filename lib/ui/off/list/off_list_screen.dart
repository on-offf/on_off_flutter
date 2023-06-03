import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/icon/icon_path.dart';
import 'package:on_off/ui/components/off_appbar.dart';
import 'package:on_off/ui/components/transform_daily_weekly.dart';
import 'package:on_off/ui/off/daily/off_daily_screen.dart';
import 'package:on_off/ui/components/focus_month.dart';
import 'package:on_off/ui/off/list/components/list_item.dart';
import 'package:on_off/ui/off/list/off_list_view_model.dart';
import 'package:on_off/ui/off/write/off_write_screen.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';

class OffListScreen extends StatelessWidget {
  static const routeName = '/off/list';

  const OffListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OffListViewModel viewModel = context.watch<OffListViewModel>();

    UiProvider uiProvider = context.watch<UiProvider>();
    return Scaffold(
      appBar: offAppBar(
        context,
        isPrevButton: true,
        settingButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 37,
          right: 37,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FocusMonth(),
                TransformDailyWeekly(
                  key: GlobalKey(),
                  text: 'Weekly',
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: ((context, index) {
                  if (index == 0 && viewModel.state.contents.isEmpty) {
                    return Column(
                      children: [
                        const SizedBox(height: 100,),
                        SvgPicture.asset(
                          IconPath.noHaveContent.name,
                          width: 130,
                          height: 130,
                          color: uiProvider.state.colorConst.getPrimary(),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          '이번 달은 아직 \n게시글이 없습니다!',
                          style: kSubtitle3.copyWith(
                            color: uiProvider.state.colorConst.getPrimary(),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                uiProvider
                                    .changeFloatingActionButtonSwitch(true);
                                Navigator.pushNamed(
                                    context, OffWriteScreen.routeName);
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      18.0,
                                    ),
                                    side: BorderSide(
                                      color: uiProvider.state.colorConst
                                          .getPrimary(),
                                    ),
                                  ),
                                ),
                              ),
                              child: Text(
                                '글쓰러가기',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  letterSpacing: 0.1,
                                  color:
                                      uiProvider.state.colorConst.getPrimary(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            TextButton(
                              onPressed: () {
                                uiProvider
                                    .changeFloatingActionButtonSwitch(true);
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      18.0,
                                    ),
                                    side: BorderSide(
                                      color: uiProvider.state.colorConst
                                          .getPrimary(),
                                    ),
                                  ),
                                ),
                              ),
                              child: Text(
                                '뒤로 가기',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  letterSpacing: 0.1,
                                  color:
                                      uiProvider.state.colorConst.getPrimary(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  } else {
                    return GestureDetector(
                      child: ListItem(content: viewModel.state.contents[index]),
                      onTap: () {
                        //daily 스크린으로 이동
                        uiProvider.changeSelectedDay(
                            viewModel.state.contents[index].time);
                        uiProvider.changeFocusedDay(
                            viewModel.state.contents[index].time);
                        Navigator.pushNamed(context, OffDailyScreen.routeName);
                      },
                    );
                  }
                }),
                itemCount: viewModel.state.contents.isEmpty ? 1 : viewModel.state.contents.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
