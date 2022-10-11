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
