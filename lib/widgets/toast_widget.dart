import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:pitchmatter_assignment/utils/colors.dart';


class ToastService {
  static sendScaffoldAlert(
      {required String msg,
      required String toastStatus,
      required BuildContext context}) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    showToastWidget(
      Container(
        margin: EdgeInsets.symmetric(
          vertical: height * 0.01,
          horizontal: width * 0.05
                  ,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.03,
          vertical: height * 0.02,
        ),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: greyShade3,
          ),
        ),
        child: Row(
          children: [
            Icon(
              toastStatus == 'SUCCESS'
                  ? Icons.check_circle
                  : toastStatus == 'ERROR'
                      ? Icons.warning_rounded
                      : Icons.warning_rounded,
              color: toastStatus == 'SUCCESS'
                  ? success
                  : toastStatus == 'ERROR'
                      ? error
                      : Colors.amber,
              // color: widget.color,
            ),
            // const SizedBox(width: 8),
            Expanded(
              child: Text(
                msg,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            // const Spacer(),
          ],
        ),
      ),
      animation: StyledToastAnimation.slideFromTop,
      reverseAnimation: StyledToastAnimation.slideFromTop,
      context: context,
      duration: const Duration(seconds: 5),
      position: StyledToastPosition.top,
    );
  }
}