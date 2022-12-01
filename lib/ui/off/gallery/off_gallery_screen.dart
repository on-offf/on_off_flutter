import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/ui/off/gallery/off_gallery_view_model.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:provider/provider.dart';

class OffGalleryScreen extends StatelessWidget {
  static const routeName = '/off/gallery';
  bool _isInit = false;

  OffGalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<OffGalleryViewModel>();

    final uiProvider = context.watch<UiProvider>();

    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    double aspectRatioWidth = 3;
    double aspectRatioHeight = 4;

    if (!_isInit) {
      _isInit = true;
      viewModel.initScreen(arguments['offImageList']);
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(77),
        child: AppBar(
          toolbarHeight: 77,
          elevation: 0.0,
          backgroundColor: uiProvider.state.colorConst.canvas,
          leading: Container(),
          title: Center(
            child: Text(
              '${viewModel.state.index + 1} / ${viewModel.state.offImageList.length}',
              style: kTitle1.copyWith(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                size: 25,
                color: uiProvider.state.colorConst.getPrimary(),
              ),
            ),
            const SizedBox(width: 40),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 38,
          right: 38,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: CarouselSlider.builder(
                itemCount: viewModel.state.offImageList.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return Image.memory(
                    viewModel.state.offImageList[viewModel.state.index].imageFile,
                    fit: BoxFit.fitWidth,
                  );
                },
                options: CarouselOptions(
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  viewportFraction: 1.0,
                  aspectRatio: aspectRatioWidth / aspectRatioHeight,
                  onPageChanged: (index, reason) {
                    viewModel.changeIndex(index);
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (ctx, idx) {
                  return Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: idx == viewModel.state.index ? Colors.black : Colors.grey,
                    ),
                  );
                },
                separatorBuilder: (ctx, idx) {
                  return const SizedBox(
                    width: 5,
                  );
                },
                itemCount: viewModel.state.offImageList.length,
              ),
            ),
            Expanded(
              flex: 1,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, idx) {
                    // idx == state.index
                    return SizedBox(
                      width: 70,
                      height: 70,
                      child: GestureDetector(
                        onTap: () =>
                            viewModel.changeIndex(idx),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.memory(
                            viewModel.state.offImageList[idx].imageFile,
                            fit: BoxFit.fill,
                            color: idx == viewModel.state.index
                                ? Colors.transparent
                                : Colors.grey,
                            colorBlendMode: BlendMode.screen,
                            width: 70,
                            height: 70,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, idx) {
                    return const SizedBox(
                      width: 5,
                    );
                  },
                  itemCount: viewModel.state.offImageList.length,
                ),
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
