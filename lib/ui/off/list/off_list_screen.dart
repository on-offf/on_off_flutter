import 'package:flutter/material.dart';

class OffListScreen extends StatelessWidget {
  static const routeName = '/off/list';
  const OffListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('list'),
      ),
    );
  }
}
