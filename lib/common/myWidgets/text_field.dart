import 'package:flutter/material.dart';
import 'package:utilidades_condular/common/decoration/dec_outline_input_border.dart';
import 'package:utilidades_condular/common/myWidgets/my_text.dart';
import 'package:utilidades_condular/defaul_config.dart';
import 'labels.dart';

class SearchTextField extends StatefulWidget {
  final String textFormFieldOuterLabel;
  final bool textFormFieldObligatory;
  final String hintText;
  final int textFormMaxLines;
  final Color uniformColor;
  final TextEditingController searchController;
  final List<List> orders;
  final Function(List<List>) onUpdateSearch;
  const SearchTextField({
    Key? key,
    required this.textFormFieldOuterLabel,
    required this.textFormFieldObligatory,
    this.hintText = "",
    this.textFormMaxLines = 1,
    this.uniformColor = const Color.fromARGB(255, 242, 242, 242),
    required this.searchController,
    this.orders = const [[]],
    required this.onUpdateSearch,
  }) : super(key: key);

  @override
  ASearchTextField createState() => ASearchTextField();
}

class ASearchTextField extends State<SearchTextField> {
  List<List> filteredData = [];

  @override
  void initState() {
    filteredData = widget.orders;
    super.initState();
  }

  @override
  void dispose() {
    widget.searchController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged(String text) {
    setState(() {
      if (text.isEmpty) {
        filteredData = widget.orders;
      } else {
        filteredData = widget.orders
            .where((e) =>
                e.any((s) => s.toLowerCase().contains(text.toLowerCase())))
            .toList();
      }
      widget.onUpdateSearch(filteredData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: _onSearchTextChanged,
      maxLines: widget.textFormMaxLines,
      style: const TextStyle(
        height: 1.5,
      ),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        focusedBorder: textOutlineBorder(
          borderColor: widget.uniformColor,
        ),
        enabledBorder: textOutlineBorder(
          borderColor: widget.uniformColor,
        ),
        hintText: widget.hintText,
        filled: true,
        fillColor: widget.uniformColor,
        suffixIcon: const Padding(
          padding: EdgeInsets.only(bottom: 2),
          child: Icon(
            color: Colors.black,
            Icons.search,
          ),
        ),
      ),
    );
  }
}

class TextField1 extends StatefulWidget {
  final String textFormFieldOuterLabel;
  final bool textFormFieldObligatory;
  final TextEditingController controller;
  final int textFormMaxLines;
  bool displayMandatoryField;
  TextField1({
    Key? key,
    required this.textFormFieldOuterLabel,
    required this.textFormFieldObligatory,
    required this.controller,
    this.textFormMaxLines = 1,
    required this.displayMandatoryField,
  }) : super(key: key);

  @override
  TextField1Body createState() => TextField1Body();
}

class TextField1Body extends State<TextField1> {
  String displayMsg = "";
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelWMandatory(
            textFormFieldOuterLabel: widget.textFormFieldOuterLabel,
            textFormFieldObligatory: widget.textFormFieldObligatory,
          ),
          TextField(
            onChanged: (value) {
              setState(() {
                if (value.isEmpty) {
                  widget.displayMandatoryField = true;
                } else {
                  widget.displayMandatoryField = false;
                }
              });
            },
            controller: widget.controller,
            maxLines: widget.textFormMaxLines,
            style: const TextStyle(
              height: 1.5,
            ),
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              focusedBorder: textOutlineBorder(),
              enabledBorder: textOutlineBorder(),
            ),
          ),
          mandatoryTextWidget(
            displayMandatoryField: widget.displayMandatoryField,
          ),
        ],
      ),
    );
  }
}
