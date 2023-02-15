import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/entity/on/on_todo.dart';
import 'package:on_off/ui/on/monthly/components/todo_bottom_sheet.dart';
import 'package:on_off/ui/on/monthly/on_monthly_view_model.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class OnMonthlyItem extends StatelessWidget {
  OnMonthlyItem({super.key});

  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();

  var createTodoTextFormFieldController = TextEditingController();

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
                    controller: createTodoTextFormFieldController,
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
                      createTodoTextFormFieldController.text = '';
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 300,
          child: ReorderableListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            buildDefaultDragHandles: viewModel.state.order == 'todoOrder',
            itemBuilder: (context, index) {
              return buildTodo(
                viewModel.state.todos![index],
                viewModel,
                uiProvider,
              );
            },
            itemCount: viewModel.state.todos!.length,
            onReorder: (oldIndex, newIndex) async {
              List<OnTodo> copyTodos = [];
              int i = 0;
              for (int index = 0;
                  index < viewModel.state.todos!.length;
                  index++) {
                if (index == oldIndex) {
                  continue;
                } else if (index == newIndex) {
                  OnTodo todo = viewModel.state.todos![oldIndex];
                  copyTodos.add(todo.copyWith(todoOrder: i++));
                }

                OnTodo todo = viewModel.state.todos![index];
                copyTodos.add(todo.copyWith(todoOrder: i++));
              }

              if (newIndex == viewModel.state.todos!.length) {
                OnTodo todo = viewModel.state.todos![oldIndex];
                copyTodos.add(todo.copyWith(todoOrder: newIndex));
              }
              await viewModel.updateTodos(copyTodos);
            },
          ),
        ),
      ],
    );
  }

  Widget buildTodo(
    OnTodo todo,
    OnMonthlyViewModel viewModel,
    UiProvider uiProvider,
  ) {
    return Column(
      key: ObjectKey(todo.id),
      children: [
        SizedBox(
          height: 27,
          child: Slidable(
            endActionPane: ActionPane(
              extentRatio: 0.2,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) async {
                    await viewModel.deleteTodo(todo);
                  },
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                ),
              ],
            ),
            child: Row(
              children: [
                Checkbox(
                  value: todo.status == 1 ? true : false,
                  onChanged: (bool? value) async {
                    await viewModel.changeTodoStatus(todo);
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
                  todo.title,
                  style: todo.status == 1
                      ? kBody2.copyWith(
                          color: const Color(0xffb3b3b3),
                          decoration: TextDecoration.lineThrough,
                        )
                      : kBody2,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
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
        return const TodoBottomSheetMenu();
      },
    );
  }
}
