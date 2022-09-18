import 'dart:math' as math;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/ui/components/build_selected_icons.dart';
import 'package:on_off/ui/components/plus_button.dart';
import 'package:on_off/ui/off/home/off_home_event.dart';
import 'package:on_off/ui/off/home/off_home_state.dart';
import 'package:on_off/ui/off/home/off_home_view_model.dart';
import 'package:on_off/ui/off/write/off_write_screen.dart';
import 'package:provider/provider.dart';

class OffHomeItem extends StatelessWidget {
  CarouselController carouselController = CarouselController();
  OffHomeItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OffHomeViewModel viewModel = context.watch<OffHomeViewModel>();
    OffHomeState state = viewModel.state;
    LayerLink layerLink = LayerLink();

    return state.content == null ?
      TextButton(
        onPressed: () => Navigator.pushNamed(context, OffWriteScreen.routeName),
        child: Text('다이어리 추가'),
      ) :
      Column(
      children: [
        Row(
          children: [
            CompositedTransformTarget(
              link: layerLink,
              child: Text(
                DateFormat.MMMMEEEEd('ko_KR').format(state.content!.time),
                style: kSubtitle2,
              ),
            ),
            const SizedBox(width: 8),
            ...buildSelectedIcons(state.iconPaths),
            SizedBox(
              child: PlusButton(
                  layerLink: layerLink,
                  actionAfterSelect: (path) => viewModel.onEvent(OffHomeEvent.addSelectedIconPaths(path))
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 2,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 23),
        state.content!.imagePaths.isEmpty
            ? SizedBox()
            : SizedBox(
          width: 313,
          height: 240,
          child: Stack(
            children: [
              CarouselSlider(
                carouselController: carouselController,
                options: CarouselOptions(
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  viewportFraction: 1.0,
                  aspectRatio: 313 / 240,
                ),
                items: state.content!.imagePaths.map((img) {
                  return Container(
                    child: Image.asset(
                      img,
                      fit: BoxFit.fill,
                    ),
                  );
                }).toList(),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    // Use the controller to change the current page
                    carouselController.previousPage();
                  },
                  icon: Transform.rotate(
                    angle: 180 * math.pi / 180,
                    child: const Icon(
                      Icons.double_arrow_sharp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    // Use the controller to change the current page
                    carouselController.nextPage();
                  },
                  icon: const Icon(
                    Icons.double_arrow_sharp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        state.content!.imagePaths.isEmpty ? SizedBox() : SizedBox(height: 15),
        Row(
          children: [
            const Text(
              "오늘의 일기",
              style: kSubtitle2,
            ),
            const SizedBox(
              width: 40.5,
            ),
            Expanded(
              child: Container(
                height: 2,
                decoration: const BoxDecoration(
                  color: Color(0xff219EBC),
                  borderRadius: BorderRadius.all(
                    Radius.circular(2.0),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              DateFormat('오후 HH:MM', 'ko_KR').format(state.content!.time),
              style: kSubtitle3,
            ),
          ],
        ),
        const SizedBox(height: 7),
        SizedBox(
          width: MediaQuery.of(context).size.width - 74,
          child: Text(
            state.content!.content,
            textAlign: TextAlign.start,
            softWrap: true,
            style: kBody1,
          ),
        ),
      ],
    );
  }
}
