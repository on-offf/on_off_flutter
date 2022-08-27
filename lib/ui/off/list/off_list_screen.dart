import 'package:flutter/material.dart';
import 'package:on_off/domain/model/content.dart';
import 'package:on_off/ui/off/list/list_item.dart';

class OffListScreen extends StatefulWidget {
  static const routeName = '/off/list';
  final List<Content> contents = [
    Content(
      id: 1,
      time: DateTime.utc(2022, 8, 2, 12, 33),
      // date: "8월 2일 목요일",
      // time: "오후 12시 33분",
      content:
          "오늘 수영장을 다녀왔다! 오랜만에 친구들을 만나서 즐거운 시간을 보낸 것 같다!! 요즘 친구들 만난지 오래 되었는데 , 옛날처럼 자주 만났으면 좋겠다 흑흑.... 오늘도 즐거운 하루를 보낸거 같다... 방학이 평생 끝나지 않으면 좋겠다 ㅠㅠ",
      imagePaths: [
        "lib/ui/off/list/content1.png",
        "lib/ui/off/list/content1.png",
      ],
    ),
    Content(
      id: 2,
      time: DateTime.utc(2022, 8, 2, 12, 33),
      // date: "8월 4일 목요일",
      // time: "오후 12시 33분",
      content: "오랜만에 가는 공연! 너무 신나는 하루를 보냈다!! ㅎㅎ 언제쯤 공연 보러 자유롭게 갈 수 있으려나 ㅠㅠ ",
      imagePaths: [
        "lib/ui/off/list/content2.png",
        "lib/ui/off/list/content2.png",
      ],
    ),
    Content(
      id: 3,
      time: DateTime.utc(2022, 8, 2, 12, 33),
      // date: "8월 2일 목요일",
      // time: "오후 12시 33분",
      content:
          "내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용",
      imagePaths: [],
    ),
    Content(
      id: 4,
      time: DateTime.utc(2022, 8, 2, 12, 33),
      // date: "8월 2일 목요일",
      // time: "오후 12시 33분",
      content:
          "오늘 수영장을 다녀왔다! 오랜만에 친구들을 만나서 즐거운 시간을 보낸 것 같다!! 요즘 친구들 만난지 오래 되었는데 , 옛날처럼 자주 만났으면 좋겠다 흑흑.... 오늘도 즐거운 하루를 보낸거 같다... 방학이 평생 끝나지 않으면 좋겠다 ㅠㅠ",
      imagePaths: [
        "lib/ui/off/list/content1.png",
        "lib/ui/off/list/content1.png",
      ],
    ),
    Content(
      id: 5,
      time: DateTime.utc(2022, 8, 2, 12, 33),
      // date: "8월 4일 목요일",
      // time: "오후 12시 33분",
      content: "오랜만에 가는 공연! 너무 신나는 하루를 보냈다!! ㅎㅎ 언제쯤 공연 보러 자유롭게 갈 수 있으려나 ㅠㅠ ",
      imagePaths: [
        "lib/ui/off/list/content2.png",
        "lib/ui/off/list/content2.png",
      ],
    ),
    Content(
      id: 6,
      time: DateTime.utc(2022, 8, 2, 12, 33),
      // date: "8월 2일 목요일",
      // time: "오후 12시 33분",
      content:
          "내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용",
      imagePaths: [],
    ),
  ];

  @override
  State<OffListScreen> createState() => _OffListScreenState();
}

class _OffListScreenState extends State<OffListScreen> {
  late List<Content> displayContents;
  // var _loadedInitData = false;

  // @override
  // void didChangeDependencies() {
  //   if (!_loadedInitData) {
  //     // final routeArgs =
  //     //     ModalRoute.of(context).settings.arguments as Map<String, String>;
  //     // categoryTitle = routeArgs['title'];
  //     // final categoryId = routeArgs['id'];
  //     displayContents = widget.contents.where((content) {
  //       return content.date.contains("8월");
  //     }).toList();
  //     _loadedInitData = true;
  //   }
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("앱바자리"),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 37,
        ),
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.builder(
            itemBuilder: ((context, index) {
              return ListItem(content: widget.contents[index]);
            }),
            itemCount: widget.contents.length,
          ),
        ),
      ),
    );
  }
}
