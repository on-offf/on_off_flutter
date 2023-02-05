import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/ui/on/monthly/on_monthly_view_model.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

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

    return Container(
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
          top: uiProvider.state.calendarFormat == CalendarFormat.month ? 0 : 25,
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
                DateFormat.MMMMEEEEd('ko_KR')
                    .format(uiProvider.state.focusedDay),
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
            IconButton(
              onPressed: () => _buildBottomSheet(context),
              icon: const Icon(Icons.menu),
            ),
          ],
        ),
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

  Widget items(
    context,
    OnMonthlyViewModel viewModel,
    uiProvider,
  ) {
    List<Widget> todos = [];
    if (viewModel.state.todos != null) {
      for (int i = 0; i < viewModel.state.todos!.length; i++) {
        todos.add(
          SizedBox(
            height: 27,
            child: Row(
              children: [
                Checkbox(
                  value: viewModel.state.todos![i].status == 1 ? true : false,
                  onChanged: (bool? value) {
                    viewModel.changeTodoStatus(viewModel.state.todos![i]);
                  },
                  activeColor: uiProvider.state.colorConst.getPrimary(),
                  side: const BorderSide(
                    color: Color(0xffD9D9D9),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Text(
                  viewModel.state.todos![i].title,
                  style: viewModel.state.todos![i].status == 1
                      ? kBody2.copyWith(
                          color: const Color(0xffb3b3b3),
                          decoration: TextDecoration.lineThrough,
                        )
                      : kBody2,
                ),
              ],
            ),
          ),
        );
        todos.add(
          const SizedBox(height: 15),
        );
      }
    }

    return Column(
      children: [
        const SizedBox(height: 15),
        DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(7),
          color: uiProvider.state.colorConst.getPrimary(),
          strokeWidth: 1,
          child: Container(
            // height: 27,
            height: 45,
            color: const Color(0xfff8f8f8),
            child: Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (bool? value) {},
                  //작성하는 todo 칸은 체크박스 비활성화
                  activeColor: uiProvider.state.colorConst.getPrimary(),
                  side: const BorderSide(
                    color: Color(0xffD9D9D9),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    style: kSubtitle3,
                    decoration: InputDecoration(
                      hintText: "오늘의 리스트를 추가해 주세요!",
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: uiProvider.state.colorConst.getPrimary(),
                        ),
                      ),
                    ),
                    onFieldSubmitted: (value) async {
                      await viewModel.saveContent(value);
                      value = '';
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        ...todos,
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

  Future<dynamic> _buildBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) {
        return Container(
          height: 400,
          padding: EdgeInsets.all(20),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Text("미완료 일정 보기"),
                  height: 50,
                  width: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[500],
                  ),
                ),
                Container(
                  child: Text("완료 일정 보기"),
                  height: 50,
                  width: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              child: Text("오늘의 일정 전체보기"),
              height: 50,
              width: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[500],
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: Text("다수의 일정 삭제하기"),
              height: 50,
              width: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[500],
              ),
            ),
          ]),
        );
      },
    );
  }
}
