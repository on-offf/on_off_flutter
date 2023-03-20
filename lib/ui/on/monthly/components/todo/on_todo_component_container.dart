import 'package:flutter/material.dart';
import 'package:on_off/ui/on/monthly/components/todo/on_todo_components.dart';
import 'package:on_off/ui/on/monthly/components/todo/on_todo_input_component.dart';

class OnTodoComponentContainer extends StatelessWidget {
  const OnTodoComponentContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 15),
        OnTodoInputComponent(),
        SizedBox(height: 10),
        OnTodoComponents(),
      ],
    );
  }
}
