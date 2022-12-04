// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../provider/ui_state.dart';

class AnimatedSwitch extends StatelessWidget {
  final UiState uiState;
  final bool isLock;
  final VoidCallback onPressed;

  AnimatedSwitch({
    Key? key,
    required this.uiState,
    required this.isLock,
    required this.onPressed,
  }) : super(key: key);

  final animationDuration = const Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed.call();
      },
      child: AnimatedContainer(
        height: 35,
        width: 60,
        duration: animationDuration,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isLock ? uiState.colorConst.getPrimary() : const Color(0xFFD9D9D9),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: AnimatedAlign(
          duration: animationDuration,
          alignment: isLock ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Container(
              width: 25,
              height: 25,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
