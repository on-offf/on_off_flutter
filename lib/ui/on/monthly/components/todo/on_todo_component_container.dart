import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:on_off/ui/on/monthly/components/todo/on_todo_components.dart';
import 'package:on_off/ui/on/monthly/components/todo/on_todo_input_component.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';

class OnTodoComponentContainer extends StatelessWidget {
  const OnTodoComponentContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UiProvider uiProvider = context.watch<UiProvider>();

    return Column(
      children: [
        const SizedBox(height: 15),
        DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(7),
          color: uiProvider.state.colorConst.getPrimary(),
          strokeWidth: 1,
          child: Container(
            height: 50,
            color: const Color(0xfff8f8f8),
            child: Row(
              children: [
                const SizedBox(
                  height: 50,
                  width: 40,
                ),
                Expanded(child: OnTodoInputComponent()),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        const OnTodoComponents(),
      ],
    );
  }
}
