import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:on_off/di/provider_setup.dart';
import 'package:on_off/routes.dart';
import 'package:on_off/ui/off/monthly/off_monthly_screen.dart';
import 'package:on_off/ui/on/monthly/on_monthly_screen.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:on_off/ui/setting/home/setting_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<SingleChildWidget> providers = await getProviders();

  initializeDateFormatting('ko_KR', null);

  FlutterNativeSplash.remove();

  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    final uiProvider = context.watch<UiProvider>();
    final state = uiProvider.state;

    final SettingViewModel settingViewModel =
        Provider.of<SettingViewModel>(context);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ON & OFF',
        theme: ThemeData(
          primaryColor: state.colorConst.getPrimary(),
          primaryColorLight: state.colorConst.getPrimaryLight(),
          canvasColor: state.colorConst.canvas,
          textTheme: GoogleFonts.notoSansTextTheme(),
        ),
        initialRoute: checkInitScreen(settingViewModel),
        routes: Routes.routes,
        builder: (context, child) => ResponsiveWrapper.builder(
          child,
          // minWidth: 480,
          minWidth: 390,
          defaultScale: true,
          breakpoints: [
            // const ResponsiveBreakpoint.resize(480, name: MOBILE),
            const ResponsiveBreakpoint.resize(390, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ],
          background: Container(color: const Color(0xFFF5F5F5)),
        ),
      ),
    );
  }

  String checkInitScreen(SettingViewModel settingViewModel) {
    if (settingViewModel.state.setting.isOnOffSwitch == 0)
      return OffMonthlyScreen.routeName;
    var switchStartHour = settingViewModel.state.setting.switchStartHour;
    var switchStartMinutes = settingViewModel.state.setting.switchStartMinutes;
    var switchEndHour = settingViewModel.state.setting.switchEndHour;
    var switchEndMinutes = settingViewModel.state.setting.switchEndMinutes;

    DateTime now = DateTime.now();
    if (switchStartHour < now.hour && now.hour < switchEndHour) {
      return OnMonthlyScreen.routeName;
    } else if (switchStartHour == now.hour && switchStartMinutes < now.minute) {
      return OnMonthlyScreen.routeName;
    } else if (switchEndHour == now.hour && now.minute < switchEndMinutes) {
      return OnMonthlyScreen.routeName;
    }
    return OffMonthlyScreen.routeName;
  }
}
