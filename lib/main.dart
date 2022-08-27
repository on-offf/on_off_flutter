import 'package:flutter/material.dart';
import 'package:on_off/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ON & OFF',
      theme: ThemeData(
        primaryColor: Color(0xffebebeb),
        canvasColor: Color(0xffebebeb),
      ),
      initialRoute: '/',
      routes: Routes.routes,
    );
  }
}
