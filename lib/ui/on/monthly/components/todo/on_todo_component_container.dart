import 'package:flutter/material.dart';
import 'package:on_off/ui/on/monthly/components/todo/on_todo_components.dart';
import 'package:on_off/ui/on/monthly/components/todo/on_todo_input_component.dart';
import 'package:on_off/ui/on/monthly/on_monthly_view_model.dart';
import 'package:provider/provider.dart';

class OnTodoComponentContainer extends StatelessWidget {
  const OnTodoComponentContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OnMonthlyViewModel viewModel = context.watch<OnMonthlyViewModel>();
    return Column(
      children: [
        if (!viewModel.state.multiDeleteStatus)
          const SizedBox(height: 15),
        if (!viewModel.state.multiDeleteStatus)
          const OnTodoInputComponent(),
        if (!viewModel.state.multiDeleteStatus)
          const SizedBox(height: 10),
        OnTodoComponents(key: GlobalKey()),
      ],
    );
  }
}
