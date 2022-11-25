import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/ui/components/build_selected_icons.dart';
import 'package:on_off/ui/components/off_appbar.dart';
import 'package:on_off/ui/off/daily/off_daily_state.dart';
import 'package:on_off/ui/off/daily/off_daily_view_model.dart';
import 'package:on_off/ui/off/gallery/off_gallery_screen.dart';
import 'package:on_off/ui/off/write/off_write_screen.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';

class OffDailyScreen extends StatelessWidget {
  static const routeName = '/off/daily';
  bool initScreen = true;

  OffDailyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OffDailyViewModel viewModel = context.watch<OffDailyViewModel>();
    LayerLink layerLink = LayerLink();

    UiProvider uiProvider = context.watch<UiProvider>();

    return Scaffold(
      appBar: offAppBar(
        context,
        isPrevButton: true,
        settingButton: false,
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
                    DateFormat.MMMMEEEEd('ko_KR')
                        .format(viewModel.state.content!.time),
                    style: kSubtitle2,
                  ),
                ),
                const SizedBox(width: 8),
                if (viewModel.state.icon != null)
                  buildSelectedIcon(viewModel.state.icon!.name),
                Expanded(
                  child: Container(
                    height: 2,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 23),
            Container(
              height: 41,
              padding: const EdgeInsets.only(left: 8),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: const Color.fromRGBO(18, 112, 176, 0.24),
              ),
              child: Text(
                viewModel.state.content!.title,
                style: kSubtitle3,
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: MediaQuery.of(context).size.width - 74,
              // height: 240,
              child: Stack(
                children: [
                  CarouselSlider(
                    carouselController: viewModel.state.carouselController,
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 500),
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        viewModel.changeCurrentIndex(index);
                      },
                    ),
                    items: viewModel.state.content!.imageList.map((offImage) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, OffGalleryScreen.routeName, arguments: {
                            'offImageList': viewModel.state.content!.imageList
                          });
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
            const SizedBox(height: 14),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: const Color.fromRGBO(230, 247, 252, 0.3),
                ),
                child: GestureDetector(
                  onTap: () {
                    uiProvider.changeFocusedDay(viewModel.state.content!.time);
                    Navigator.pushNamed(
                      context,
                      OffWriteScreen.routeName,
                    );
                  },
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 74,
                      child: Text(
                        viewModel.state.content!.content,
                        softWrap: true,
                        textAlign: TextAlign.start,
                      ),
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
