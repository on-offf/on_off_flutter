import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/icon/icon_path.dart';
import 'package:on_off/ui/components/build_selected_icons.dart';
import 'package:on_off/ui/off/daily/off_daily_screen.dart';
import 'package:on_off/ui/off/gallery/off_gallery_screen.dart';
import 'package:on_off/ui/off/monthly/off_monthly_view_model.dart';
import 'package:on_off/ui/off/write/off_write_screen.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class OffMonthlyItem extends StatelessWidget {
  OffMonthlyItem({Key? key}) : super(key: key);
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();

  @override
  Widget build(BuildContext context) {
    OffMonthlyViewModel viewModel = context.watch<OffMonthlyViewModel>();
    UiProvider uiProvider = context.watch<UiProvider>();
    LayerLink layerLink = LayerLink();

    _scrollControllerListener(_scrollController, uiProvider);
    _scrollControllerListener(_scrollController2, uiProvider);

    return viewModel.state.content == null
        ? SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Image(
                  image: AssetImage(IconPath.noHaveContent.name),
                  width: 120,
                  height: 120,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  '이날은 아직 \n게시글이 없습니다!',
                  style: kSubtitle3.copyWith(
                    color: uiProvider.state.colorConst.getPrimary(),
                  ),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: () {
                    uiProvider.changeFloatingActionButtonSwitch(true);
                    Navigator.pushNamed(context, OffWriteScreen.routeName);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          18.0,
                        ),
                        side: BorderSide(
                          color: uiProvider.state.colorConst.getPrimary(),
                        ),
                      ),
                    ),
                  ),
                  child: Text(
                    '글쓰러 가기',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      letterSpacing: 0.1,
                      color: uiProvider.state.colorConst.getPrimary(),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            decoration: uiProvider.state.calendarFormat == CalendarFormat.week
                ? const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(-3, -3),
                        blurRadius: 1,
                        spreadRadius: 1,
                        color: Color.fromRGBO(0, 0, 0, .1),
                      ),
                    ],
                  )
                : const BoxDecoration(),
            child: Container(
              decoration: uiProvider.state.calendarFormat == CalendarFormat.week
                  ? BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(22),
                        topRight: Radius.circular(22),
                      ),
                      color: uiProvider.state.colorConst.canvas,
                    )
                  : const BoxDecoration(),
              padding: EdgeInsets.only(
                top: uiProvider.state.calendarFormat == CalendarFormat.month
                    ? 0
                    : 25,
                left: 37,
                right: 37,
              ),
              child: SingleChildScrollView(
                physics: uiProvider.state.calendarFormat == CalendarFormat.month
                    ? const NeverScrollableScrollPhysics()
                    : const BouncingScrollPhysics(),
                controller: _scrollController,
                child: item(context, viewModel, uiProvider, layerLink),
              ),
            ),
          );
  }

  Widget item(context, viewModel, uiProvider, layerLink) {
    return Column(
      children: [
        Row(
          children: [
            CompositedTransformTarget(
              link: layerLink,
              child: Text(
                DateFormat.MMMMEEEEd('ko_KR')
                    .format(viewModel.state.content!.time),
                style: kSubtitle3,
              ),
            ),
            viewModel.state.icon != null
                ? buildSelectedIcon(viewModel.state.icon.name)
                : const SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 2,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 23),
        Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(100, 207, 239, .1),
          ),
          height: 500,
          child: SingleChildScrollView(
            physics: uiProvider.state.calendarFormat == CalendarFormat.month
                ? const NeverScrollableScrollPhysics()
                : const BouncingScrollPhysics(),
            controller: _scrollController2,
            child: Column(
              children: [
                Container(
                  height: 41,
                  padding: const EdgeInsets.only(left: 8),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: const Color.fromRGBO(18, 112, 176, 0.24),
                  ),
                  child: Text(
                    viewModel.state.content!.title,
                    style: kSubtitle3.copyWith(height: 1),
                  ),
                ),
                const SizedBox(height: 10),
                showItem(context, viewModel, uiProvider),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget showItem(context, viewModel, uiProvider) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            uiProvider.changeFloatingActionButtonSwitch(true);
            uiProvider.changeCalendarFormat(CalendarFormat.month);
            Navigator.pushNamed(
              context,
              OffGalleryScreen.routeName,
              arguments: {'offImageList': viewModel.state.content?.imageList},
            );
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 74,
            height: 240,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.memory(
                viewModel.state.content!.imageList.first.imageFile,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width - 74,
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        GestureDetector(
          onTap: () {
            uiProvider.changeCalendarFormat(CalendarFormat.month);
            Navigator.pushNamed(
              context,
              OffDailyScreen.routeName,
              arguments: {
                'content': viewModel.state.content,
                'icon': viewModel.state.icon,
              },
            );
          },
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "오늘의 일기",
                    style: kSubtitle2,
                  ),
                  const SizedBox(
                    width: 40.5,
                  ),
                  Expanded(
                    child: Container(
                      height: 2,
                      decoration: const BoxDecoration(
                        color: Color(0xff219EBC),
                        borderRadius: BorderRadius.all(
                          Radius.circular(2.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              SizedBox(
                width: MediaQuery.of(context).size.width - 74,
                height: 100, //TODO 화면이 작은 폰에서도 작동하는지 확인해야 함.
                child: Text(
                  viewModel.state.content!.content,
                  textAlign: TextAlign.start,
                  softWrap: true,
                  style: kBody1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _scrollControllerListener(
      ScrollController scrollController, UiProvider uiProvider) {
    scrollController.addListener(() {
      if (scrollController.offset < -50) {
        uiProvider.changeCalendarFormat(CalendarFormat.month);
      }
    });
  }
}
