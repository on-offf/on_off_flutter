import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:on_off/di/provider_setup.dart';
import 'package:on_off/routes.dart';
import 'package:on_off/ui/off/monthly/off_monthly_screen.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';

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
          canvasColor: state.colorConst.canvas,
        ),
        initialRoute: OffMonthlyScreen.routeName,
        routes: Routes.routes,
      ),
    );
  }
}
