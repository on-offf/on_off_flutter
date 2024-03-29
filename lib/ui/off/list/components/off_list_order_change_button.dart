import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_off/domain/icon/icon_path.dart';
import 'package:on_off/ui/off/list/off_list_view_model.dart';
import 'package:provider/provider.dart';

class OffListOrderChangeButton extends StatelessWidget {
  const OffListOrderChangeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OffListViewModel viewModel = context.watch<OffListViewModel>();

    return Padding(
      padding: const EdgeInsets.only(bottom: 17),
      child: GestureDetector(
        onTap: () {
          viewModel.changeDiaryOrderType();
        },
        child: Row(
          children: [
            Text(viewModel.state.isAscending ? '오름차순' : '내림차순'),
            const SizedBox(
              width: 6.38,
            ),
            SvgPicture.asset(
              IconPath.downArrow.name,
              width: 4.29,
              height: 6.32,
            ),
          ],
        ),
      ),
    );
  }
}
