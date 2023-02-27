import 'package:flutter/material.dart';
import 'package:on_off/domain/icon/icon_path.dart';
import 'package:on_off/ui/components/simple_dialog.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';

class OffFloatingActionButton extends StatelessWidget {
  const OffFloatingActionButton({
    Key? key,
    required this.montlyListButtonNavigator,
    required this.onOffButtonNavigator,
  }) : super(key: key);

  final VoidCallback montlyListButtonNavigator;
  final VoidCallback onOffButtonNavigator;

  @override
  Widget build(BuildContext context) {
    final uiProvier = context.watch<UiProvider>();
    return uiProvier.state.floatingActionButtonSwitch
        ? FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            heroTag: 'showFloatingActionButtons',
            onPressed: () {
              uiProvier.changeFloatingActionButtonSwitch(null);
            },
            child: const Icon(Icons.add),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: 'moveMonthlyWeeklyScreen',
                onPressed: () {
                  uiProvier.changeFloatingActionButtonSwitch(null);
                  montlyListButtonNavigator.call();
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
                  // simpleHighlightTextDialog(
                  //   context,
                  //   primaryColor: uiProvier.state.colorConst.getPrimary(),
                  //   canvasColor: Colors.white,
                  //   text: TextSpan(
                  //     style: const TextStyle(
                  //       color: Colors.black,
                  //     ),
                  //     children: [
                  //       const TextSpan(text: '아직 준비 중인 기능이에요.\n'),
                  //       TextSpan(
                  //         text: 'ON ',
                  //         style: TextStyle(
                  //           color: uiProvier.state.colorConst.getPrimary(),
                  //           fontWeight: FontWeight.w700,
                  //         ),
                  //       ),
                  //       const TextSpan(text: '페이지 많이 기대해주세요!'),
                  //     ],
                  //   ),
                  // );
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
                backgroundColor: Theme.of(context).primaryColorLight,
                heroTag: 'hideFloatingActionButtons',
                onPressed: () {
                  uiProvier.changeFloatingActionButtonSwitch(null);
                },
                child: const Icon(Icons.remove),
              ),
            ],
          );
  }
}

class OnFloatingActionButton extends StatelessWidget {
  const OnFloatingActionButton({
    Key? key,
    required this.onOffButtonNavigator,
  }) : super(key: key);

  final VoidCallback onOffButtonNavigator;

  @override
  Widget build(BuildContext context) {
    final uiProvier = context.watch<UiProvider>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: 'moveOnOffScreen',
          onPressed: () {
            // simpleHighlightTextDialog(
            //   context,
            //   primaryColor: uiProvier.state.colorConst.getPrimary(),
            //   canvasColor: Colors.white,
            //   text: TextSpan(
            //     style: const TextStyle(
            //       color: Colors.black,
            //     ),
            //     children: [
            //       const TextSpan(text: '아직 준비 중인 기능이에요.\n'),
            //       TextSpan(
            //         text: 'ON ',
            //         style: TextStyle(
            //           color: uiProvier.state.colorConst.getPrimary(),
            //           fontWeight: FontWeight.w700,
            //         ),
            //       ),
            //       const TextSpan(text: '페이지 많이 기대해주세요!'),
            //     ],
            //   ),
            // );
            onOffButtonNavigator.call();
          },
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          child: Image(
            image: AssetImage(
              IconPath.floatingActionButtonOnOff.name,
            ),
            width: 55,
            height: 55,
          ),
        ),
      ],
    );
  }
}
