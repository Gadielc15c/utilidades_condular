import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  final double contextHeight;
  final double contextWidth;
  const Dashboard({
    Key? key,
    required this.contextHeight,
    required this.contextWidth,
  }) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String _greetingText = "Hola";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          _greetingText,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
