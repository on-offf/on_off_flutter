import 'package:flutter/material.dart';

class OnListScreen extends StatelessWidget {
  static const routeName = '/on/list';
  const OnListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('list'),
      ),
    );
  }
}
