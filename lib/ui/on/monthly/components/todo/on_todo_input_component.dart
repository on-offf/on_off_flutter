import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/ui/on/monthly/on_monthly_view_model.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';

class OnTodoInputComponent extends StatefulWidget {
  const OnTodoInputComponent({Key? key}) : super(key: key);

  @override
  State<OnTodoInputComponent> createState() => _OnTodoInputComponentState();
}

class _OnTodoInputComponentState extends State<OnTodoInputComponent> {
  final GlobalKey _widgetKey = GlobalKey();
  OnMonthlyViewModel? viewModel;

  @override
  void initState() {
    super.initState();

    KeyboardVisibilityController().onChange.listen((event) {
      if (!event) {
        viewModel!.updateKeyboardHeight(0);
        return;
      }

      RenderBox renderBox = _widgetKey.currentContext?.findRenderObject() as RenderBox;
      Offset offset = renderBox.localToGlobal(Offset.zero);
      double widgetHeight = renderBox.size.height;

      double upperSize = (offset.dy + (widgetHeight)) / 2;

      Future.delayed(const Duration(milliseconds: 450), (){
        double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

        viewModel!.updateKeyboardHeight(keyboardHeight);
        viewModel!.state.monthlyItemWrapperScrollController?.animateTo(
          keyboardHeight - upperSize,
          duration: const Duration(
            milliseconds: 200,
          ),
          curve: Curves.ease,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    UiProvider uiProvider = context.watch<UiProvider>();
    viewModel = context.watch<OnMonthlyViewModel>();
    var createTodoTextFormFieldController = TextEditingController();

    return TextFormField(
      key: _widgetKey,
      style:
          kSubtitle2.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
      controller: createTodoTextFormFieldController,
      decoration: InputDecoration(
        hintText: "오늘의 리스트를 추가해 주세요!",
        hintStyle: kSubtitle2.copyWith(fontWeight: FontWeight.bold),
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
        await viewModel?.saveContent(value);
        createTodoTextFormFieldController.text = '';
      },
    );
  }
}
