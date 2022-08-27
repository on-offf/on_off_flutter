import 'package:flutter/material.dart';
import 'package:on_off/domain/model/content.dart';
import 'package:on_off/ui/off/list/list_item.dart';

class OffListScreen extends StatefulWidget {
  static const routeName = '/off/list';

  // final List<Content> contents;

  @override
  State<OffListScreen> createState() => _OffListScreenState();
}

class _OffListScreenState extends State<OffListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("앱바자리"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 77,
          horizontal: 37,
        ),
        child: ListView.builder(
          itemBuilder: ((context, index) {
            return ListItem();
          }),
        ),
      ),
    );
  }
}
