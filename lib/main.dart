import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:on_off/di/provider_setup.dart';
import 'package:on_off/routes.dart';
import 'package:on_off/ui/off/monthly/off_monthly_screen.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  final providers = await getProviders();

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
        initialRoute: state.startRoute,
        routes: Routes.routes,
        builder: (context, child) => ResponsiveWrapper.builder(
          child,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(480, name: MOBILE),
          ],
          background: Container(color: const Color(0xFFF5F5F5)),
        ),
      ),
    );
  }
}
