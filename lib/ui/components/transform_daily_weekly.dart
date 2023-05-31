import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:on_off/domain/icon/icon_path.dart';
import 'package:on_off/ui/off/daily/off_daily_screen.dart';
import 'package:on_off/ui/off/daily/off_daily_view_model.dart';
import 'package:on_off/ui/off/list/off_list_screen.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';

class TransformDailyWeekly extends StatelessWidget {
  TransformDailyWeekly({GlobalKey? key, this.text = 'Daily', this.isOverlay = true}) : super(key: key);

  late OverlayEntry overlayEntry;
  late UiProvider uiProvider;
  String text;
  bool isOverlay;

  @override
  Widget build(BuildContext context) {
    uiProvider = context.watch<UiProvider>();
    OffDailyViewModel viewModel = context.watch<OffDailyViewModel>();
    if (viewModel.state.content == null) {
      isOverlay = false;
    }

    return GestureDetector(
      onTap: () {
        if (isOverlay) {
          overlayEntry = _createOverlay();
          Navigator.of(context).overlay?.insert(overlayEntry);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 5, bottom: 17),
        child: Row(
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              width: 6.38,
            ),
            SvgPicture.asset(
              IconPath.downArrow.name,
              colorFilter: ColorFilter.mode(
                  uiProvider.state.colorConst.getPrimary(), BlendMode.srcIn),
              width: 12,
            ),
          ],
        ),
      ),
    );
  }

  OverlayEntry _createOverlay() {
    RenderBox renderBox =
        (key as GlobalKey).currentContext?.findRenderObject() as RenderBox;
    Offset offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () => overlayEntry.remove(),
            ),
            Positioned(
              top: offset.dy + 20,
              left: offset.dx + 10,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 50,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1,
                        color: uiProvider.state.colorConst.getPrimary(),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          overlayEntry.remove();
                          if (text == 'Daily') return;

                          while (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                          Navigator.pushNamed(
                              context, OffDailyScreen.routeName);
                        },
                        child: const Text(
                          'Daily',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          overlayEntry.remove();
                          if (text == 'Weekly') return;

                          while (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                          Navigator.pushNamed(
                              context, OffListScreen.routeName);
                        },
                        child: const Text(
                          'Weekly',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
