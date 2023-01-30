import 'package:flutter/material.dart';

Text largeLabel1({required String text}) {
  return Text(
    text,
    style: const TextStyle(fontSize: 40),
  );
}

Text normalLabel1({required String text}) {
  return Text(
    text,
    style: const TextStyle(fontSize: 18),
  );
}
