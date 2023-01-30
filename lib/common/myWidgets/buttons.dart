import 'package:flutter/material.dart';

class Button1 extends StatefulWidget {
  final String buttonLabel;
  final Icon buttonIcon;
  const Button1({
    Key? key,
    required this.buttonLabel,
    required this.buttonIcon,
  }) : super(key: key);

  @override
  AButton createState() => AButton();
}

class AButton extends State<Button1> {
  // @override
  // void initState() {
  //   super.initState();
  //   dropdownvalue = widget.initialValue;
  // }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {},
      child: Row(
        children: [
          Text(widget.buttonLabel),
          const SizedBox(
            width: 5,
          ),
          widget.buttonIcon,
        ],
      ),
    );
  }
}
