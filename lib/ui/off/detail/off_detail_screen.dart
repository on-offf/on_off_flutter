import 'dart:math' as math;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/model/content.dart';
import 'package:on_off/ui/components/build_selected_icons.dart';
import 'package:on_off/ui/components/off_appbar.dart';
import 'package:on_off/ui/components/plus_button.dart';
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
    LayerLink layerLink = LayerLink();

    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object?>;
    final Content content = routeArgs['content']! as Content;
    final List<String> iconPaths = routeArgs['iconPaths']! as List<String>;

    viewModel.onEvent(OffDetailEvent.getIconPaths(iconPaths));

    return Scaffold(
      appBar: offAppBar(
        context,
        isPrevButton: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 37,
        ),
        child: Column(children: [
          Row(
            children: [
              CompositedTransformTarget(
                link: layerLink,
                child: Text(
                  DateFormat.MMMMEEEEd('ko_KR').format(content.time),
                  style: kSubtitle2,
                ),
              ),
              const SizedBox(width: 8),
              ...buildSelectedIcons(state.iconPaths),
              SizedBox(
                child: PlusButton(
                  layerLink: layerLink,
                  actionAfterSelect: () {},
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 2,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 23),
          content.imageList.isEmpty
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
                            viewModel.onEvent(
                                OffDetailEvent.changeCurrentIndex(index));
                          },
                        ),
                        items: content.imageList.map((offImage) {
                          return Container(
                            child: Image.memory(
                              offImage.imageFile,
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
                      state.currentIndex < content.imageList.length - 1
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
          content.imageList.isEmpty
              ? const SizedBox()
              : const SizedBox(height: 15),
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
