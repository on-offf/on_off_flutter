import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/ui/provider/ui_event.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:on_off/ui/provider/ui_state.dart';
import 'package:provider/provider.dart';

class OffFocusMonth extends StatelessWidget {
  OffFocusMonth({Key? key}) : super(key: key);
  final GlobalKey _globalKey = GlobalKey();
  late UiProvider uiProvider;
  late UiState uiState;

  @override
  Widget build(BuildContext context) {
    uiProvider = context.watch<UiProvider>();
    uiState = uiProvider.state;

    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              uiProvider.onEvent(const UiEvent.focusMonthSelected());
              if (uiState.focusMonthSelected) {
                OverlayEntry overlayEntry = _createOverlay();
                Navigator.of(context).overlay?.insert(overlayEntry);
                uiProvider.onEvent(UiEvent.showOverlay(context, overlayEntry));
              } else {
                uiProvider.onEvent(const UiEvent.removeOverlay());
              }
            },
            child: Row(
              children: [
                Container(
                  key: _globalKey,
                  child: Text(
                    DateFormat('yyyy년 MM월', 'ko_KR')
                        .format(uiState.changeCalendarPage),
                    style: kSubtitle2,
                  ),
                ),
                const SizedBox(
                  width: 6.38,
                ),
                const Image(
                  image: AssetImage("assets/icons/down_arrow.png"),
                  width: 4.29,
                  height: 6.32,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  OverlayEntry _createOverlay() {
    return OverlayEntry(
      builder: (context) {
        final RenderBox renderBox = _globalKey.currentContext?.findRenderObject() as RenderBox;
        final Size size = renderBox.size;
        final Offset offset = renderBox.localToGlobal(Offset.zero);

        return Stack(
          children: [
            GestureDetector(
              onTap: () => uiProvider.onEvent(const UiEvent.removeOverlay()),
            ),
            Positioned(
              left: offset.dx,
              top: offset.dy + size.height,
              width: 162,
              height: 171,
              child: Material(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 5,
                        )
                      ]),
                  // child: Column(
                  //   children: [
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //
                  //
                  //       ],
                  //     )
                  //   ],
                  // ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
