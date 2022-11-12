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
import 'package:on_off/ui/provider/ui_event.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:on_off/ui/provider/ui_state.dart';
import 'package:provider/provider.dart';

class OffDailyScreen extends StatelessWidget {
  static const routeName = '/off/daily';
  bool initScreen = true;

  OffDailyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OffDailyViewModel viewModel = context.watch<OffDailyViewModel>();
    OffDailyState state = viewModel.state;
    LayerLink layerLink = LayerLink();

    UiProvider uiProvider = context.watch<UiProvider>();

    UiState uiState = uiProvider.state;

    return Scaffold(
      appBar: offAppBar(
        context,
        isPrevButton: true,
        settingButton: false,
      ),
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          //down
          if (details.primaryVelocity! > 0) {
            print("아래로 드래그");
            viewModel.onEvent(const OffDailyEvent.changeDay(true));
            Future.delayed(Duration(seconds: 2), () {
              uiProvider
                  .onEvent(UiEvent.changeSelectedDay(state.content!.time));
              uiProvider.onEvent(UiEvent.changeFocusedDay(state.content!.time));
            });
          }
          //up
          else if (details.primaryVelocity! < 0) {
            print("위로 드래그");
            viewModel.onEvent(const OffDailyEvent.changeDay(false));
            Future.delayed(Duration(seconds: 2), () {
              uiProvider
                  .onEvent(UiEvent.changeSelectedDay(state.content!.time));
              uiProvider.onEvent(UiEvent.changeFocusedDay(state.content!.time));
            });
          }
        },
        child: Container(
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
                      DateFormat.MMMMEEEEd('ko_KR').format(state.content!.time),
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
              state.content!.imageList.isEmpty
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
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 500),
                              initialPage: 0,
                              enableInfiniteScroll: false,
                              viewportFraction: 1.0,
                              onPageChanged: (index, reason) {
                                viewModel.onEvent(
                                    OffDailyEvent.changeCurrentIndex(index));
                              },
                            ),
                            items: state.content!.imageList.map((offImage) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, OffGalleryScreen.routeName,
                                      arguments: {
                                        'offImageList': state.content!.imageList
                                      });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.memory(
                                    offImage.imageFile,
                                    fit: BoxFit.cover,
                                    width:
                                        MediaQuery.of(context).size.width - 74,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
              state.content!.imageList.isEmpty
                  ? const SizedBox()
                  : const SizedBox(height: 15),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    uiProvider
                        .onEvent(UiEvent.changeFocusedDay(state.content!.time));
                    Navigator.pushNamed(
                      context,
                      OffWriteScreen.routeName,
                    );
                  },
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 74,
                      child: Text(
                        state.content!.content,
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
      ),
    );
  }
}
