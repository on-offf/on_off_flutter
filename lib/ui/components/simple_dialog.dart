import 'package:flutter/material.dart';
import 'package:on_off/constants/constants_text_style.dart';

void simpleTextDialog(
  BuildContext context, {
  required Color primaryColor,
  required Color canvasColor,
  required String message,
  double width = 200,
  double height = 100,
}) {
  showDialog(
    barrierColor: Colors.transparent,
    context: context,
    builder: (_) => Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(35.0),
        ),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.0),
          border: Border.all(
            width: 1,
            color: primaryColor,
          ),
          color: canvasColor,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(message),
        ),
      ),
    ),
  );
}

Future<dynamic> simpleConfirmButtonDialog(
  BuildContext context, {
  required Color primaryColor,
  required Color canvasColor,
  required String message,
  double width = 200,
  double height = 100,
}) {
  return showDialog(
    barrierColor: Colors.transparent,
    context: context,
    builder: (_) => Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(35.0),
        ),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        width: 288,
        height: 129,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.0),
          border: Border.all(
            width: 1,
            color: primaryColor,
          ),
          color: canvasColor,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 18,
            ),
            Text(
              message,
              style: kSubtitle3.copyWith(
                color: primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                      side: BorderSide(
                        color: primaryColor,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  child: Text(
                    '예',
                    style: kSubtitle3.copyWith(
                      color: primaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop(false);
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                      side: BorderSide(
                        color: primaryColor,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  child: Text(
                    '아니요',
                    style: kSubtitle3.copyWith(
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Future<dynamic> simpleInputDialog(
  BuildContext context, {
  required Color primaryColor,
  required Color canvasColor,
  required String message,
  double width = 200,
  double height = 150,
  String? initMessage,
}) {
  TextEditingController controller = TextEditingController();

  if (initMessage != null) {
    controller.text = initMessage;
  }

  return showDialog(
    barrierColor: Colors.transparent,
    context: context,
    builder: (_) => Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(35.0),
        ),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.0),
          border: Border.all(
            width: 1,
            color: primaryColor,
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 18,
            ),
            Text(
              message,
              style: kSubtitle3.copyWith(
                color: primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: width - 25,
              height: 30,
              child: TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: '일과 일상을 분리해보세요.',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  filled: true,
                  fillColor: Color(0xffe5e5e5),
                ),
                style: kBody2,

              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(controller.text);
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                      side: BorderSide(
                        color: primaryColor,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  child: Text(
                    '예',
                    style: kSubtitle3.copyWith(
                      color: primaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                      side: BorderSide(
                        color: primaryColor,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  child: Text(
                    '아니요',
                    style: kSubtitle3.copyWith(
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
