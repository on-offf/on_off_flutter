import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/icon/icon_path.dart';
import 'package:on_off/ui/on/monthly/components/todo/on_todo_component_container.dart';
import 'package:on_off/ui/on/monthly/components/todo_bottom_sheet.dart';
import 'package:on_off/ui/on/monthly/on_monthly_view_model.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';

class OnMonthlyItem extends StatelessWidget {
  OnMonthlyItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OnMonthlyViewModel viewModel = context.watch<OnMonthlyViewModel>();
    UiProvider uiProvider = context.watch<UiProvider>();
    LayerLink layerLink = LayerLink();

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
              onPressed: () => _buildBottomSheet(context, uiProvider),
              icon: SvgPicture.asset(
                IconPath.menu.name,
              ),
              iconSize: 5,
            ),
          ],
        ),
        Column(
          children: [
            OnTodoComponentContainer(),
            if (viewModel.state.multiDeleteStatus)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      viewModel.updateMultiDeleteStatus();
                    },
                    child: Container(
                      height: 40,
                      width: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[500],
                      ),
                      child: const Text('취소'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      viewModel.deleteMultiOnTodo();
                    },
                    child: Container(
                      height: 40,
                      width: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[500],
                      ),
                      child: const Text('전체 삭제'),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }

  Future<dynamic> _buildBottomSheet(
      BuildContext context, UiProvider uiProvider) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(25),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Container(
            decoration: BoxDecoration(
              color: uiProvider.state.colorConst.getPrimary(),
            ),
            padding: const EdgeInsets.only(
              top: 1,
            ),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
                color: Colors.white,
              ),
              child: const TodoBottomSheetMenu(),
            ),
          ),
        );
      },
    );
  }
}
