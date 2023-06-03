import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:on_off/domain/icon/icon_path.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';

import '../off/monthly/off_monthly_screen.dart';
import '../on/monthly/on_monthly_screen.dart';

class OffFloatingActionButton extends StatelessWidget {
  const OffFloatingActionButton({
    Key? key,
    required this.montlyListButtonNavigator,
  }) : super(key: key);

  final VoidCallback montlyListButtonNavigator;

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
                child: SvgPicture.asset(
                  IconPath.floatingActionButtonMonthlyWeekly.name,
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
                  // onOffButtonNavigator.call();
                  Navigator.pushReplacement(
                      context, _FadeRoute(page: const OnMonthlyScreen()));
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: SvgPicture.asset(
                  IconPath.floatingActionButtonOnOff.name,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = context.watch<UiProvider>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: 'moveOnOffScreen',
          onPressed: () {
            Navigator.pushReplacement(
                context, _FadeRoute(page: const OffMonthlyScreen()));
          },
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          child: CircleAvatar(
            backgroundColor: uiProvider.state.colorConst.getPrimary(),
            child: SvgPicture.asset(
              IconPath.floatingActionButtonChange.name,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              width: 30,
              height: 30,
            ),
          ),
        ),
      ],
    );
  }
}

class _FadeRoute extends PageRouteBuilder {
  final Widget page;
  _FadeRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
