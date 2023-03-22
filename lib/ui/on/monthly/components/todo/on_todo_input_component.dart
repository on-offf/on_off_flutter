import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/icon/icon_path.dart';
import 'package:on_off/ui/on/monthly/on_monthly_screen.dart';
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
  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UiProvider uiProvider = context.watch<UiProvider>();
    OnMonthlyViewModel viewModel = context.watch<OnMonthlyViewModel>();
    var createTodoTextFormFieldController = TextEditingController();
    viewModel.generateTodoInputState(focusNode);
    keyboardEvent(context, viewModel);

    return Row(
      key: _widgetKey,
      children: [
        DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(7),
          color: uiProvider.state.colorConst.getPrimary(),
          strokeWidth: 1,
          child: SizedBox(
            height: 41,
            width: 262,
            child: TextFormField(
              focusNode: viewModel.state.todoInputFocusNode,
              style:
                  kSubtitle2.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              controller: createTodoTextFormFieldController,
              maxLength: 15,
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
                counterText: "", //글자수 세는것 안보이게
                contentPadding: const EdgeInsets.only(left: 20, bottom: 6, top: 0),
              ),
              onFieldSubmitted: (value) async {
                await viewModel.saveContent(value);
                createTodoTextFormFieldController.text = '';
              },
            ),
          ),
        ),
        const SizedBox(width: 7),
        DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(7),
          color: uiProvider.state.colorConst.getPrimary(),
          strokeWidth: 1,
          child: SizedBox(
            width: 38.75,
            height: 41,
            child: IconButton(
              onPressed: () async {
                await viewModel.saveContent(createTodoTextFormFieldController.text);
                createTodoTextFormFieldController.text = '';
                focusNode.unfocus();
              },
              icon: SvgPicture.asset(IconPath.todoSubmit.name),
              iconSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  keyboardEvent(BuildContext context, OnMonthlyViewModel viewModel) {
    KeyboardVisibilityController().onChange.listen((event) {
      if (!event) {
        viewModel.updateKeyboardHeight(0);
        return;
      }

      if (!focusNode.hasFocus) {
        return;
      }

      var box = _widgetKey.currentContext?.findRenderObject();
      if (box == null) return;

      RenderBox renderBox = box as RenderBox;
      Offset offset = renderBox.localToGlobal(Offset.zero);
      double widgetHeight = renderBox.size.height;

      Future.delayed(const Duration(milliseconds: 450), () {
        double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

        double y = offset.dy + widgetHeight + 40;
        if (MediaQuery.of(context).size.height - y > keyboardHeight) return;

        updateKeyboardHeight(viewModel, keyboardHeight, keyboardHeight - (MediaQuery.of(context).size.height - y));
      });
    });
  }

  void updateKeyboardHeight(OnMonthlyViewModel viewModel, double keyboardHeight, double upperSize) {
    viewModel.updateKeyboardHeight(keyboardHeight);
    viewModel.state.onMonthlyScreenScrollerController?.animateTo(
      upperSize,
      duration: const Duration(
        milliseconds: 200,
      ),
      curve: Curves.ease,
    );
  }
}
