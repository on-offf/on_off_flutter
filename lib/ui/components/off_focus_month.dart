import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/ui/off/home/off_home_event.dart';
import 'package:on_off/ui/off/home/off_home_state.dart';
import 'package:on_off/ui/off/home/off_home_view_model.dart';
import 'package:on_off/ui/provider/ui_event.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:on_off/ui/provider/ui_state.dart';
import 'package:provider/provider.dart';

class OffFocusMonth extends StatefulWidget {
  const OffFocusMonth({Key? key}) : super(key: key);

  @override
  State<OffFocusMonth> createState() => _OffFocusMonthState();
}

class _OffFocusMonthState extends State<OffFocusMonth> {
  final LayerLink layerLink = LayerLink();
  late OffHomeViewModel? viewModel;
  late OffHomeState? state;
  late UiProvider? uiProvider;
  late UiState? uiState;

  @override
  Widget build(BuildContext context) {
    uiProvider = context.watch<UiProvider>();
    uiState = uiProvider!.state;

    viewModel = context.watch<OffHomeViewModel>();
    state = viewModel!.state;

    return Padding(
      padding: const EdgeInsets.only(left: 5, bottom: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              viewModel!.onEvent(const OffHomeEvent.offFocusMonthSelected());
              if (state!.offFocusMonthSelected) {
                OverlayEntry overlayEntry = _createOverlay();
                Navigator.of(context).overlay?.insert(overlayEntry);
                viewModel!
                    .onEvent(OffHomeEvent.showOverlay(context, overlayEntry));
              } else {
                viewModel!.onEvent(const OffHomeEvent.removeOverlay());
              }
            },
            child: Row(
              children: [
                CompositedTransformTarget(
                  link: layerLink,
                  child: Text(
                    DateFormat('yyyy년 MM월', 'ko_KR')
                        .format(uiState!.changeCalendarPage),
                    style: kTitle2,
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
        return Positioned(
          width: 101,
          height: 132,
          child: CompositedTransformFollower(
            followerAnchor: Alignment.topLeft,
            targetAnchor: Alignment.bottomLeft,
            link: layerLink,
            child: Material(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5,
                      )
                    ]),
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: 12,
                    padding: const EdgeInsets.only(top: 0),
                    itemBuilder: (context, index) {
                      int month = index + 1;
                      return GestureDetector(
                        onTap: () {
                          DateTime date = DateTime(uiState!.changeCalendarPage.year, month, 1);
                          uiProvider?.onEvent(UiEvent.changeCalendarPage(date));
                          uiProvider?.onEvent(UiEvent.changeFocusedDay(date));
                          viewModel!.onEvent(const OffHomeEvent.removeOverlay());
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1.0,
                                color: Colors.grey.withOpacity(0.08),
                              ),
                            ),
                          ),
                          child: Text(
                            "$month 월",
                            style: kMonth,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() async {
    Future.delayed(Duration.zero, () {
      viewModel!.onEvent(const OffHomeEvent.removeOverlay());
    });
    super.dispose();
  }
}
