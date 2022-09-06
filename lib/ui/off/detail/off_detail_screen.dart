import 'dart:math' as math;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/model/content.dart';
import 'package:on_off/ui/components/off_appbar.dart';
import 'package:on_off/ui/off/detail/off_detail_event.dart';
import 'package:on_off/ui/off/detail/off_detail_state.dart';
import 'package:on_off/ui/off/detail/off_detail_view_model.dart';
import 'package:provider/provider.dart';

class OffDetailScreen extends StatelessWidget {
  static const routeName = '/off/detail';

  const OffDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OffDetailViewModel viewModel = context.watch<OffDetailViewModel>();
    OffDetailState state = viewModel.state;

    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, Content>;
    final Content content = routeArgs['content']!;

    return Scaffold(
      appBar: offAppBar(context),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 37,
        ),
        child: Column(children: [
          Row(
            children: [
              Text(
                DateFormat.MMMMEEEEd('ko_KR').format(content.time),
                style: kSubtitle2,
              ),
              SizedBox(width: 14),
              Image(
                image: AssetImage("assets/icons/plus.png"),
                width: 14,
                height: 14,
              ),
              SizedBox(width: 14),
              Expanded(
                child: Container(
                  height: 2,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 23),
          content.imagePaths.isEmpty
              ? SizedBox()
              : SizedBox(
                  width: 313,
                  height: 240,
                  child: Stack(
                    children: [
                      CarouselSlider(
                        carouselController: state.carouselController,
                        options: CarouselOptions(
                          initialPage: 0,
                          enableInfiniteScroll: false,
                          viewportFraction: 1.0,
                          aspectRatio: 313 / 240,
                          onPageChanged: (index, reason) {
                            viewModel.onEvent(OffDetailEvent.changeCurrentIndex(index));
                          },
                        ),
                        items: content.imagePaths.map((img) {
                          return Container(
                            child: Image.asset(
                              img,
                              fit: BoxFit.fill,
                            ),
                          );
                        }).toList(),
                      ),
                      state.currentIndex > 0
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                onPressed: () {
                                  state.carouselController.previousPage();
                                },
                                icon: Transform.rotate(
                                  angle: 180 * math.pi / 180,
                                  child: Icon(
                                    Icons.double_arrow_sharp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                      state.currentIndex < content.imagePaths.length - 1
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () {
                                  state.carouselController.nextPage();
                                },
                                icon: Icon(
                                  Icons.double_arrow_sharp,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
          content.imagePaths.isEmpty ? SizedBox() : SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 10),
              Text(
                DateFormat('오후 HH:MM', 'ko_KR').format(content.time),
                style: kSubtitle2,
              ),
            ],
          ),
          SizedBox(height: 7),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                content.content,
                softWrap: true,
              ),
            ),
          ),
          SizedBox(height: 41),
        ]),
      ),
    );
  }
}
