import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/ui/components/build_selected_icons.dart';
import 'package:on_off/ui/components/focus_month.dart';
import 'package:on_off/ui/components/off_appbar.dart';
import 'package:on_off/ui/components/sticker_button.dart';
import 'package:on_off/ui/components/transform_daily_weekly.dart';
import 'package:on_off/ui/off/daily/off_daily_view_model.dart';
import 'package:on_off/ui/off/gallery/off_gallery_screen.dart';
import 'package:on_off/ui/off/write/off_write_screen.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';

class OffDailyScreen extends StatefulWidget {
  static const routeName = '/off/daily';

  OffDailyScreen({Key? key}) : super(key: key);

  @override
  State<OffDailyScreen> createState() => _OffDailyScreenState();
}

class _OffDailyScreenState extends State<OffDailyScreen> {
  bool initScreen = true;
  final GlobalKey key = GlobalKey();
  double height = 300;
  final LayerLink selectIconSheetLink = LayerLink();
  late OffDailyViewModel viewModel;
  late UiProvider uiProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setHeight());
  }

  void setHeight() {
    final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    setState(
      () => height = MediaQuery.of(context).size.height -
          renderBox.localToGlobal(Offset.zero).dy -
          46,
    );
  }

  @override
  Widget build(BuildContext context) {
    viewModel = context.watch<OffDailyViewModel>();
    uiProvider = context.watch<UiProvider>();

    return Scaffold(
      appBar: offAppBar(
        context,
        isPrevButton: true,
        settingButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 37,
          right: 37,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FocusMonth(
                  showOverlay: false,
                ),
                TransformDailyWeekly(key: GlobalKey()),
              ],
            ),
            const SizedBox(height: 3),
            Container(
              key: key,
              height: height,
              decoration: BoxDecoration(
                color: uiProvider.state.colorConst.getPrimaryPlus(),
                borderRadius: BorderRadius.circular(7),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, .25),
                    spreadRadius: 0,
                    blurRadius: 3,
                    offset: Offset(1, -1),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.MMMMEEEEd('ko_KR')
                          .format(viewModel.state.content!.time),
                      style: kBody2,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      viewModel.state.content!.title,
                      style: kOffTitle.copyWith(
                        color: uiProvider.state.colorConst.darkGray,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 74,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CarouselSlider(
                          carouselController:
                              viewModel.state.carouselController,
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
                          items: viewModel.state.content!.imageList
                              .map((offImage) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, OffGalleryScreen.routeName,
                                    arguments: {
                                      'offImageList':
                                          viewModel.state.content!.imageList
                                    });
                              },
                              child: Image.memory(
                                offImage.imageFile,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width - 74,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: viewModel.state.content!.imageList
                          .map(
                            (e) => Container(
                              width: 10,
                              height: 10,
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                color: uiProvider.state.colorConst.getPrimary(),
                                borderRadius: BorderRadius.circular(99),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    Row(
                      children: [
                        StickerButton(
                          layerLink: selectIconSheetLink,
                          actionAfterSelect: (path) => viewModel.addIcon(path),
                        ),
                        if (viewModel.state.icon != null) _buildRemovableIcon(),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: const Color.fromRGBO(230, 247, 252, 0.3),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          uiProvider
                              .changeFocusedDay(viewModel.state.content!.time);
                          Navigator.pushNamed(
                            context,
                            OffWriteScreen.routeName,
                          );
                        },
                        child: SingleChildScrollView(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 74,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              viewModel.state.content!.content,
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
          ],
        ),
      ),
    );
  }

  Widget _buildRemovableIcon() {
    return GestureDetector(
        child: buildSelectedIcon(viewModel.state.icon!.name, uiProvider),
        onTap: () => viewModel.removeIcon(uiProvider.state.focusedDay));
  }
}
