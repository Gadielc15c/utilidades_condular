import 'package:flutter/material.dart';
import 'package:utilidades_condular/common/decoration/dec_outline_input_border.dart';
import 'form_label_1.dart';

class FormDropDown1 extends StatefulWidget {
  final String initialValue;
  final List<String> items;
  final String textFormFieldOuterLabel;
  final bool textFormFieldObligatory;
  const FormDropDown1({
    Key? key,
    required this.initialValue,
    required this.items,
    required this.textFormFieldOuterLabel,
    required this.textFormFieldObligatory,
  }) : super(key: key);

  @override
  DropDown1 createState() => DropDown1();
}

class DropDown1 extends State<FormDropDown1> {
  late String dropdownvalue = widget.initialValue;

  @override
  void initState() {
    super.initState();
    dropdownvalue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          formLabel1(
            textFormFieldOuterLabel: widget.textFormFieldOuterLabel,
            textFormFieldObligatory: widget.textFormFieldObligatory,
          ),
          DropdownButtonFormField(
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              focusedBorder: textOutlineBorder,
              enabledBorder: textOutlineBorder,
            ),
            value: dropdownvalue,
            icon: const Icon(Icons.arrow_drop_down_sharp),
            items: widget.items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue!;
              });
            },
          ),
        ],
      ),
    );
  }
}
