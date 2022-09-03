// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:on_off/domain/icon/icon.dart';

// class IconSheet extends StatelessWidget {
//   BuildContext context;
//   LayerLink link;
//   Function actionAfterSelect;

//   IconSheet({
//     Key? key,
//     required this.context,
//     required this.link,
//     required this.actionAfterSelect,
//   }) : super(key: key);

//   //off 화면의 아이콘 리스트
//   List<String> iconPaths = [
//     IconPath.expressionNormal.name,
//     IconPath.expressionSmile.name,
//     IconPath.expressionLittleSad.name,
//     IconPath.expressionSleep.name,
//     IconPath.expressionAngry.name,
//     IconPath.expressionSmallEye.name,
//     IconPath.wineGlass.name,
//     IconPath.star.name,
//     IconPath.rice.name,
//     IconPath.note.name,
//     IconPath.weatherSnow.name,
//     IconPath.weatherSunny.name,
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return OverlayEntry(
//       maintainState: true,
//       builder: (ctx) => Positioned(
//         child: CompositedTransformFollower(
//           link: link,
//           showWhenUnlinked: false,
//           offset: Offset(0, 23),
//           child: Container(
//             width: 314,
//             height: 254,
//             padding: EdgeInsets.all(30),
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Theme.of(context).primaryColor,
//                 width: 3,
//               ),
//               borderRadius: BorderRadius.circular(29),
//               color: Theme.of(context).canvasColor,
//             ),
//             child: GridView(
//               children: _buildIconButtonList(actionAfterSelect),
//               gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                 maxCrossAxisExtent: 60,
//                 crossAxisSpacing: 20,
//                 mainAxisSpacing: 20,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   List<IconButton> _buildIconButtonList(Function actionAfterSelect) {
//     List<IconButton> res = [];
//     for (var i in iconPaths) {
//       res.add(_buildImage(i, actionAfterSelect));
//     }
//     return res;
//   }

//   IconButton _buildImage(String imagePath, Function actionAfterSelect) {
//     return IconButton(
//       onPressed: () => actionAfterSelect(imagePath),
//       padding: EdgeInsets.all(0),
//       icon: Image(
//         image: AssetImage(imagePath),
//         width: 48,
//         height: 48,
//       ),
//     );
//   }
// }
