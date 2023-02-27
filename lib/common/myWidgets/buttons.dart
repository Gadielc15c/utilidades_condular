import 'package:flutter/material.dart';

class Button1 extends StatefulWidget {
  final String buttonLabel;
  final Icon buttonIcon;
  final bool disableButtonIcon;
  final double buttonSize;
  final VoidCallback onPressed;
  const Button1({
    Key? key,
    required this.buttonLabel,
    this.buttonIcon = const Icon(Icons.abc),
    this.disableButtonIcon = false,
    this.buttonSize = 50,
    required this.onPressed,
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
        fixedSize: Size.fromHeight(widget.buttonSize),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: widget.onPressed,
      child: Row(
        children: [
          Text(widget.buttonLabel),
          placeIconOrNot(
            someBool: widget.disableButtonIcon,
            buttonIcon: widget.buttonIcon,
          ),
        ],
      ),
    );
  }
}

placeIconOrNot({
  required bool someBool,
  required Icon buttonIcon,
}) {
  if (!someBool) {
    return Row(
      children: [
        const SizedBox(
          width: 5,
        ),
        buttonIcon,
      ],
    );
  } else {
    return const SizedBox(
      width: 0,
    );
  }
}
