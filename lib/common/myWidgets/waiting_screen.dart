import 'package:flutter/material.dart';

Stack loadScreen({
  required BuildContext context,
}) {
  return Stack(
    children: [
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white.withOpacity(0.5),
      ),
      const Center(
        child: CircularProgressIndicator(),
      ),
    ],
  );
}
