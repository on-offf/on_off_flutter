import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_off/ui/on/monthly/on_monthly_view_model.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../constants/constants_text_style.dart';
import '../../../../domain/icon/icon_path.dart';

class OnMonthlyItem extends StatelessWidget {
  OnMonthlyItem({super.key});
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  @override
  Widget build(BuildContext context) {
    OnMonthlyViewModel viewModel = context.watch<OnMonthlyViewModel>();
    UiProvider uiProvider = context.watch<UiProvider>();
    LayerLink layerLink = LayerLink();

    _scrollControllerListener(_scrollController, uiProvider);
    _scrollControllerListener(_scrollController2, uiProvider);

    return viewModel.state.todos == null
        ? SingleChildScrollView(
            //작은 화면에서 게시글 없을 때 화면이 잘려서 에러 발생하는 것 보완
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
                  '이날은 아직 \n일정이 없습니다!',
                  style: kSubtitle3.copyWith(
                    color: uiProvider.state.colorConst.getPrimary(),
                  ),
                  textAlign: TextAlign.center,
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
                child: bottomView(context, viewModel, uiProvider, layerLink),
              ),
            ),
          );
  }

  Widget bottomView(context, viewModel, uiProvider, layerLink) {
    return Column(
      children: [
        Row(
          children: [
            CompositedTransformTarget(
              link: layerLink,
              child: Text(
                "1월 25일 수요일",

                ///TODO 날짜 가져와서 변경하도록 수정
                // DateFormat.MMMMEEEEd('ko_KR')
                //     .format(viewModel.state.content!.time),
                style: kSubtitle3,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 2,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        // const SizedBox(height: 23),
        SizedBox(
          height: 500,
          child: SingleChildScrollView(
            physics: uiProvider.state.calendarFormat == CalendarFormat.month
                ? const NeverScrollableScrollPhysics() //아래에서 위로 스와이프하지 않았을 때 스크롤 방지
                : const BouncingScrollPhysics(),
            controller: _scrollController2,
            child: items(context, viewModel, uiProvider),
          ),
        ),
      ],
    );
  }

  Widget items(context, viewModel, uiProvider) {
    List<Widget> todos = [];
    for (int i = 0; i < viewModel.state.todos.length; i++) {
      todos.add(
        SizedBox(
          height: 27,
          child: Row(
            children: [
              Checkbox(
                value: viewModel.state.todos[i].status,
                onChanged: (bool? value) {
                  ///TODO 클릭시 OnTodo의 status 변함
                  // viewModel.state.todos[i].status = value!;
                },
                activeColor: uiProvider.state.colorConst.getPrimary(),
                side: BorderSide(
                  color: Color(0xffD9D9D9),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Text(
                "${viewModel.state.todos[i].title}",
                style: viewModel.state.todos[i].status
                    ? kBody2.copyWith(
                        color: Color(0xffb3b3b3),
                        decoration: TextDecoration.lineThrough,
                      )
                    : kBody2,
              ),
            ],
          ),
        ),
      );
      todos.add(SizedBox(height: 15));
    }

    return Column(
      children: [
        const SizedBox(height: 15),
        ...todos,
        DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(7),
          color: uiProvider.state.colorConst.getPrimary(),
          strokeWidth: 1,
          child: Container(
            height: 27,
            color: Color(0xfff8f8f8),
            child: Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (bool? value) {
                    // viewModel.state.todos[i].status = value!;
                  },
                  activeColor: uiProvider.state.colorConst.getPrimary(),
                  side: BorderSide(
                    color: Color(0xffD9D9D9),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Text(
                  "오늘의 리스트를 추가해 주세요!",
                  style: kSubtitle3,
                ),
              ],
            ),
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
