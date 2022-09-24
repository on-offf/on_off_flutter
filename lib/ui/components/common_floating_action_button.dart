import 'package:flutter/material.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/icon/icon_path.dart';
import 'package:on_off/ui/provider/ui_event.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';

class CommonFloatingActionButton extends StatelessWidget {
  CommonFloatingActionButton({
    Key? key,
    required this.montlyWeeklyButtonNavigator,
    required this.onOffButtonNavigator,
  }) : super(key: key);

  final VoidCallback montlyWeeklyButtonNavigator;
  final VoidCallback onOffButtonNavigator;

  @override
  Widget build(BuildContext context) {
    final uiProvier = context.watch<UiProvider>();
    final state = uiProvier.state;
    return state.floatingActionButtonSwitch
        ? FloatingActionButton(
            heroTag: 'showFloatingActionButtons',
            onPressed: () {
              uiProvier
                  .onEvent(const UiEvent.changeFloatingActionButtonSwitch(null));
            },
            child: const Icon(Icons.add),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: 'moveMonthlyWeeklyScreen',
                onPressed: () {
                  uiProvier.onEvent(
                      const UiEvent.changeFloatingActionButtonSwitch(null));
                  montlyWeeklyButtonNavigator.call();
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Image(
                  image: AssetImage(
                    IconPath.floatingActionButtonMonthlyWeekly.name,
                  ),
                  width: 55,
                  height: 55,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                heroTag: 'moveOnOffScreen',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => const AlertDialog(
                      title: Text(
                        '불편을 드려 죄송합니다.\non 화면은 업데이트 예정입니다.',
                        style: kBody1,
                      ),
                    ),
                  );
                  onOffButtonNavigator.call();
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Image(
                  image: AssetImage(
                    IconPath.floatingActionButtonOnOff.name,
                  ),
                  width: 55,
                  height: 55,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                heroTag: 'hideFloatingActionButtons',
                onPressed: () {
                  uiProvier.onEvent(
                      const UiEvent.changeFloatingActionButtonSwitch(null));
                },
                child: const Icon(Icons.remove),
              ),
            ],
          );
  }
}
