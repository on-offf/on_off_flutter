// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:on_off/constants/constants_text_style.dart';
import 'package:on_off/domain/model/content.dart';

class ListItem extends StatelessWidget {
  final Content content;

  const ListItem({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 177,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                DateFormat.MMMMEEEEd('ko_KR').format(content.time),
                style: kSubtitle2,
              ),
              SizedBox(width: 14),
              Image(
                image: AssetImage("assets/icons/plus.png"),
                width: 14,
                height: 14,
              ),
              SizedBox(width: 14),
              Expanded(
                child: Container(
                  height: 2,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                DateFormat('오후 HH:MM', 'ko_KR').format(content.time),
                style: kSubtitle2,
              ),
              Expanded(
                child: SizedBox(),
              ),
            ],
          ),
          SizedBox(height: 3),
          content.imagePaths.isNotEmpty
              ? SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: content.imagePaths.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.0,
                        ),
                        child: Image.file(
                          File(content.imagePaths[index]),
                          height: 40,
                        ),
                      );
                    },
                  ),
                )
              : Container(),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 74,
            child: Text(
              content.content,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              textAlign: TextAlign.start,
            ),
          ),
          // Expanded(
          //   child: SingleChildScrollView(
          //     scrollDirection: Axis.horizontal,
          //     child: Row(
          //       // mainAxisAlignment: MainAxisAlignment.start,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         content.imagePaths.isEmpty
          //             ? SizedBox()
          //             : Image.asset(
          //                 content.imagePaths[0],
          //                 width: 96,
          //                 height: 81,
          //               ),
          //         content.imagePaths.isEmpty ? SizedBox() : SizedBox(width: 23),
          //         Expanded(
          //           child: Text(
          //             content.content,
          //             softWrap: true,
          //             maxLines: 4,
          //             overflow: TextOverflow.ellipsis,
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
