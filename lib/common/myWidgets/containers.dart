import 'package:flutter/material.dart';

Container containerVerticalExpanded() {
  return Container(
    child: IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    ),
  );
}
