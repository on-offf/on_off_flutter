import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/icon/icon_path.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:on_off/ui/setting/theme/components/theme_card.dart';
import 'package:provider/provider.dart';

class ThemeSelectScreen extends StatefulWidget {
  const ThemeSelectScreen({Key? key}) : super(key: key);
  static const routeName = '/setting/theme';

  @override
  State<ThemeSelectScreen> createState() => _ThemeSelectScreenState();
}

class _ThemeSelectScreenState extends State<ThemeSelectScreen> {
  final GlobalKey _key = GlobalKey();
  double _themeListheight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_setHeight);
  }

  void _setHeight(_) {
    final renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    setState(() {
      _themeListheight = MediaQuery.of(context).size.height -
          renderBox.localToGlobal(Offset.zero).dy - 6;
    });
  }

  @override
  Widget build(BuildContext context) {
    final uiProvider = context.watch<UiProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: uiProvider.state.colorConst.getPrimary(),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            IconPath.appbarPreviousButton.name,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: const Text(
          '설정',
          style: kBody2,
        ),
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xffebebeb),
            padding: const EdgeInsets.only(
              top: 30,
              bottom: 10,
              left: 40,
              right: 40,
            ),
            child: const Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                '테마변경',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  letterSpacing: .25,
                  height: 1.447,
                  color: Color(0xff686868),
                ),
              ),
            ),
          ),
          SizedBox(
            height: _themeListheight,
            child: SingleChildScrollView(
              key: _key,
              child: Column(
                children: [
                  const SizedBox(height: 29),
                  ThemeCard(
                    colorConst: uiProvider.state.oceanMainColor,
                  ),
                  ThemeCard(
                    colorConst: uiProvider.state.purpleMainColor,
                  ),
                  ThemeCard(
                    colorConst: uiProvider.state.orangeMainColor,
                  ),
                  ThemeCard(
                    colorConst: uiProvider.state.yellowMainColor,
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  EdgeInsets titleEdgeInsets() {
    return const EdgeInsets.only(
      top: 30,
      bottom: 10,
      left: 40,
      right: 40,
    );
  }
}
