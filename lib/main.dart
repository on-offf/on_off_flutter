import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:on_off/routes.dart';

void main() async {
  initializeDateFormatting('ko_KR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ON & OFF',
        theme: ThemeData(
          primaryColor: Color(0xff219EBC),
          canvasColor: Color(0xffebebeb),
        ),
        initialRoute: '/',
        routes: Routes.routes,
      ),
    );
  }
}
