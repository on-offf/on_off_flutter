import 'dart:math' as math;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/entity/off/off_icon_entity.dart';
import 'package:on_off/domain/model/content.dart';
import 'package:on_off/ui/components/build_selected_icons.dart';
import 'package:on_off/ui/components/off_appbar.dart';
import 'package:on_off/ui/off/daily/off_daily_event.dart';
import 'package:on_off/ui/off/daily/off_daily_state.dart';
import 'package:on_off/ui/off/daily/off_daily_view_model.dart';
import 'package:on_off/ui/off/gallery/off_gallery_screen.dart';
import 'package:on_off/ui/off/write/off_write_screen.dart';
import 'package:provider/provider.dart';

class OffDailyScreen extends StatelessWidget {
  static const routeName = '/off/daily';

  const OffDailyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OffDailyViewModel viewModel = context.watch<OffDailyViewModel>();
    OffDailyState state = viewModel.state;
    LayerLink layerLink = LayerLink();

    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object?>;
    final Content content = routeArgs['content']! as Content;
    final OffIconEntity? offIcon = routeArgs['icon'] as OffIconEntity?;

    Future.delayed(Duration.zero,
        () => viewModel.onEvent(OffDailyEvent.getIcon(offIcon)));

    return Scaffold(
      appBar: offAppBar(
        context,
        isPrevButton: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 37,
        ),
        child: Column(
          children: [
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
                if (state.icon != null) buildSelectedIcon(state.icon!.name),
                Expanded(
                  child: Container(
                    height: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 23),
            content.imageList.isEmpty
                ? const SizedBox()
                : SizedBox(
                    width: MediaQuery.of(context).size.width - 74,
                    height: 240,
                    child: Stack(
                      children: [
                        CarouselSlider(
                          carouselController: state.carouselController,
                          options: CarouselOptions(
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration: const Duration(milliseconds: 500),
                            initialPage: 0,
                            enableInfiniteScroll: false,
                            viewportFraction: 1.0,
                            onPageChanged: (index, reason) {
                              viewModel.onEvent(
                                  OffDailyEvent.changeCurrentIndex(index));
                            },
                          ),
                          items: content.imageList.map((offImage) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, OffGalleryScreen.routeName, arguments: {'offImageList': content.imageList});
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.memory(
                                  offImage.imageFile,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width - 74,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
            content.imageList.isEmpty
                ? const SizedBox()
                : const SizedBox(height: 15),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    OffWriteScreen.routeName,
                  );
                },
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 74,
                    child: Text(
                      content.content,
                      softWrap: true,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 41),
          ],
        ),
      ),
    );
  }
}
