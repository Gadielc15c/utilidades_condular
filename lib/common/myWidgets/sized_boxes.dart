import 'package:flutter/material.dart';

double defaultTopPaddingSubtract = 460;
double defaultTopPaddingSubtractmin = 0;
double defaultTopPaddingSubtractmax = 40;

SizedBox sizedBoxW({double width = 50.0}) {
  return SizedBox(
    width: width,
  );
}

SizedBox sizedBoxH({double height = 10.0}) {
  return SizedBox(
    height: height,
  );
}

SizedBox sizedBoxPadding({
  required var child,
  double? contextHeight,
  double top = 50,
  double left = 50,
  double right = 50,
  double bottom = 50,
}) {
  //
  double topValue;
  if (contextHeight == null) {
    topValue = top;
  } else {
    topValue = (contextHeight - defaultTopPaddingSubtract)
        .clamp(defaultTopPaddingSubtractmin, defaultTopPaddingSubtractmax);
  }

  return SizedBox(
    child: Padding(
      padding: EdgeInsets.only(
        left: left,
        right: right,
        top: topValue,
        bottom: bottom,
      ),
      child: child,
    ),
  );
}

double counterBottomPadding(
    {required double widgetHeight, required double customHeight}) {
  //
  double toAdd = defaultTopPaddingSubtractmax -
      (widgetHeight - defaultTopPaddingSubtract)
          .clamp(defaultTopPaddingSubtractmin, defaultTopPaddingSubtractmax);

  double value =
      widgetHeight - defaultTopPaddingSubtract > defaultTopPaddingSubtractmax
          ? customHeight
          : customHeight + toAdd;
  return value;
}
