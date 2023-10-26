import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_off/constants/color_constants.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/icon/icon_path.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:on_off/ui/setting/home/setting_view_model.dart';
import 'package:provider/provider.dart';

class ThemeCard extends StatelessWidget {
  const ThemeCard({
    Key? key,
    required this.colorConst,
    required this.colorName,
  }) : super(key: key);

  final ColorConst colorConst;
  final String colorName;

  @override
  Widget build(BuildContext context) {
    UiProvider uiProvider = context.watch<UiProvider>();
    SettingViewModel viewModel = context.watch<SettingViewModel>();

    return GestureDetector(
      onTap: () {
        uiProvider.changeMainColor(colorConst);
        viewModel.changeThemeColor(colorConst);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 40,
        ),
        decoration: BoxDecoration(
            color: colorConst.getPrimary(),
            borderRadius: BorderRadius.circular(7),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, .25),
                spreadRadius: 0,
                blurRadius: 3,
                offset: Offset(1, -1),
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 21,
                    left: 23,
                    bottom: 0,
                  ),
                  child: Text(
                    colorName,
                    style: kBody2.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 21,
                    right: 23,
                    bottom: 0,
                  ),
                  child: SvgPicture.asset(
                    width: 7.41,
                    IconPath.settingArrowButton.name,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 23,
                bottom: 11,
              ),
              child: SvgPicture.asset(
                width: 90,
                height: 84,
                IconPath.expressionNormal.name,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
