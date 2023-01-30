import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(body: MyFlexiableTest()),
    ),
  );
}

class MyFlexiableTest extends StatefulWidget {
  const MyFlexiableTest({super.key});

  @override
  State<MyFlexiableTest> createState() => _MyFlexiableTestState();
}

class _MyFlexiableTestState extends State<MyFlexiableTest> {
  var width1 = 600.0;
  var width2 = 600.0;
  var width3 = 600.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: LayoutBuilder(
        builder: (context, constraint) {
          final maxWidth = constraint.maxWidth;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Slider(
                max: maxWidth,
                min: 0,
                value: width1,
                onChanged: (v) => setState(() => width1 = v),
              ),
              const SizedBox(height: 10),
              Container(
                width: width1,
                height: 100,
                color: Colors.grey.shade200,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Flexible(flex: 1, child: _textWidget('Flex:1')),
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                        width: 300,
                        child: _textWidget('Flex: 1, max: 300'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Slider(
                max: maxWidth,
                min: 0,
                value: width2,
                onChanged: (v) => setState(() => width2 = v),
              ),
              const SizedBox(height: 10),
              Container(
                width: width2,
                height: 100,
                color: Colors.grey.shade200,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Flexible(flex: 1, child: _textWidget('Flex:1')),
                    SizedBox(
                      width: (width2 / 3).clamp(200, 300),
                      child: _textWidget('Flex:1, min: 200, max: 300'),
                    ),
                    SizedBox(
                      width: (width2 / 3).clamp(200, 300),
                      child: _textWidget('Flex:1, min: 200, max: 300'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Slider(
                max: maxWidth,
                min: 0,
                value: width3,
                onChanged: (v) => setState(() => width3 = v),
              ),
              const SizedBox(height: 10),
              Container(
                width: width3,
                height: 100,
                color: Colors.grey.shade200,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Flexible(flex: 1, child: _textWidget('Flex:1')),
                    SizedBox(
                      width: (width3 / 2).clamp(100, 300),
                      child: _textWidget('Flex:3, min: 100, max: 300'),
                    ),
                    SizedBox(
                      width: (width3 / 3).clamp(100, 300),
                      child: _textWidget('Flex:2, min: 100, max: 300'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _textWidget(String text) {
    return LayoutBuilder(
      builder: (_, constraint) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(border: Border.all()),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  constraint.maxWidth.toStringAsFixed(0),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(text),
              ],
            ),
          ),
        );
      },
    );
  }
}
