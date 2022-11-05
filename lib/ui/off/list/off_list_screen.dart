import 'package:flutter/material.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/icon/icon_path.dart';
import 'package:on_off/ui/off/daily/off_daily_screen.dart';
import 'package:on_off/ui/components/focus_month.dart';
import 'package:on_off/ui/components/off_appbar.dart';
import 'package:on_off/ui/off/list/components/off_list_order_change_button.dart';
import 'package:on_off/ui/off/list/components/list_item.dart';
import 'package:on_off/ui/off/list/off_list_state.dart';
import 'package:on_off/ui/off/list/off_list_view_model.dart';
import 'package:on_off/ui/off/write/off_write_screen.dart';
import 'package:on_off/ui/provider/ui_event.dart';
import 'package:on_off/ui/provider/ui_provider.dart';
import 'package:on_off/ui/provider/ui_state.dart';
import 'package:provider/provider.dart';

class OffListScreen extends StatelessWidget {
  static const routeName = '/off/list';

  const OffListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OffListViewModel viewModel = context.watch<OffListViewModel>();
    OffListState state = viewModel.state;

    UiProvider uiProvider = context.watch<UiProvider>();
    UiState uiState = uiProvider.state;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            left: 37,
            right: 37,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FocusMonth(
                      isAccent: true,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 173,
                child: ListView.builder(
                  itemBuilder: ((context, index) {
                    if (index == 0 && state.contents.isEmpty) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FocusMonth(
                                isAccent: true,
                              ),
                              const OffListOrderChangeButton(),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 5,
                          ),
                          Image(
                            image: AssetImage(IconPath.noHaveContent.name),
                            width: 130,
                            height: 130,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            '이번 달은 아직 \n게시글이 없습니다!',
                            style: kSubtitle3.copyWith(
                              color: uiState.colorConst.getPrimary(),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  uiProvider.onEvent(const UiEvent
                                      .changeFloatingActionButtonSwitch(true));
                                  Navigator.pushNamed(
                                      context, OffWriteScreen.routeName);
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        18.0,
                                      ),
                                      side: BorderSide(
                                        color: uiState.colorConst.getPrimary(),
                                      ),
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  '글쓰러가기',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    letterSpacing: 0.1,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              TextButton(
                                onPressed: () {
                                  uiProvider.onEvent(const UiEvent
                                      .changeFloatingActionButtonSwitch(true));
                                  Navigator.pop(context);
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        18.0,
                                      ),
                                      side: BorderSide(
                                        color: uiState.colorConst.getPrimary(),
                                      ),
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  '뒤로 가기',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    letterSpacing: 0.1,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      );
                    } else if (index == 0) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          OffListOrderChangeButton(),
                        ],
                      );
                    } else {
                      return GestureDetector(
                        child: ListItem(content: state.contents[index - 1]),
                        onTap: () {
                          //daily 스크린으로 이동
                          uiProvider.onEvent(UiEvent.changeSelectedDay(
                              state.contents[index - 1].time));
                          uiProvider.onEvent(UiEvent.changeFocusedDay(
                              state.contents[index - 1].time));
                          Navigator.pushNamed(
                              context, OffDailyScreen.routeName);
                        },
                      );
                    }
                  }),
                  itemCount: state.contents.length + 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
