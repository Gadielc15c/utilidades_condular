import 'package:flutter/material.dart';
import 'package:utilidades_condular/common/decoration/dec_outline_input_border.dart';
import 'labels.dart';

// required BuildContext context,
//   required String textFormFieldOuterLabel,
//   required bool textFormFieldObligatory,
//   String hintText = "",
//   int textFormMaxLines = 1,
//   Color uniformColor = const Color.fromARGB(255, 242, 242, 242),
//   TextEditingController test = TextEditingController(),

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

// Widget searchTextField({
//   required BuildContext context,
//   required String textFormFieldOuterLabel,
//   required bool textFormFieldObligatory,
//   String hintText = "",
//   int textFormMaxLines = 1,
//   Color uniformColor = const Color.fromARGB(255, 242, 242, 242),
//   TextEditingController test = TextEditingController(),
//   // maybe put the fill color
// }) {
//   //

//   return TextField(
//     maxLines: textFormMaxLines,
//     style: const TextStyle(
//       height: 1.5,
//     ),
//     decoration: InputDecoration(
//       floatingLabelBehavior: FloatingLabelBehavior.auto,
//       focusedBorder: textOutlineBorder(
//         borderColor: uniformColor,
//       ),
//       enabledBorder: textOutlineBorder(
//         borderColor: uniformColor,
//       ),
//       hintText: hintText,
//       filled: true,
//       fillColor: uniformColor,
//       suffixIcon: const Padding(
//         padding: EdgeInsets.only(bottom: 2),
//         child: Icon(
//           color: Colors.black,
//           Icons.search,
//         ),
//       ),
//     ),
//   );
// }
