import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:on_off/di/provider_setup.dart';
import 'package:on_off/main_view_model/main_view_model.dart';
import 'package:on_off/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final providers = await getProviders();

  initializeDateFormatting('ko_KR', null);

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
    final viewModel = context.watch<MainViewModel>();
    final state = viewModel.state;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ON & OFF',
        theme: ThemeData(
          primaryColor: state.colorConst.getPrimary(),
          canvasColor: Color(0xffebebeb),
        ),
        initialRoute: '/',
        routes: Routes.routes,
      ),
    );
  }
}
