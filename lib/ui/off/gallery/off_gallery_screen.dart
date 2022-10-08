import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:on_off/ui/components/off_appbar.dart';
import 'package:on_off/ui/off/gallery/off_gallery_event.dart';
import 'package:on_off/ui/off/gallery/off_gallery_view_model.dart';
import 'package:provider/provider.dart';

class OffGalleryScreen extends StatelessWidget {
  static const routeName = '/off/gallery';
  bool _isInit = false;

  OffGalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<OffGalleryViewModel>();
    final state = viewModel.state;

    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;


    if (!_isInit) {
      _isInit = true;
      Future.delayed(Duration.zero, () => viewModel.onEvent(OffGalleryEvent.init(arguments['offImageList'])));
    }

    return Scaffold(
      appBar: offAppBar(
        context,
        isPrevButton: true,
        settingButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 38,
          right: 38,
          bottom: 41,
        ),
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: state.offImageList.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.memory(
                    state.offImageList[state.index].imageFile,
                    fit: BoxFit.fill,
                  ),
                );
              },
              options: CarouselOptions(
                  initialPage: 0,
                  viewportFraction: 1.0,
                  aspectRatio: 3 / 4,
                  onPageChanged: (index, reason) {
                    viewModel.onEvent(OffGalleryEvent.changeIndex(index));
                  }),
            ),
            SizedBox(
              height: 60,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (ctx, idx) {
                  return Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: idx == state.index ? Colors.black : Colors.grey,
                    ),
                  );
                },
                separatorBuilder: (ctx, idx) {
                  return const SizedBox(
                    width: 5,
                  );
                },
                itemCount: state.offImageList.length,
              ),
            ),
            SizedBox(
              height: 70,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, idx) {
                  return idx == state.index ? Container() :
                  GestureDetector(
                    onTap: () => viewModel.onEvent(OffGalleryEvent.changeIndex(idx)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.memory(
                        state.offImageList[idx].imageFile,
                        fit: BoxFit.fill,
                        width: 70,
                        height: 70,
                      ),
                    ),
                  );
                },
                separatorBuilder: (ctx, idx) {
                  return const SizedBox(
                    width: 5,
                  );
                },
                itemCount: state.offImageList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
