// ignore_for_file: must_be_immutable

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:utilidades_condular/common/decoration/dec_outline_input_border.dart';
import 'package:utilidades_condular/common/myFunctions/map_search.dart';
import 'package:utilidades_condular/common/myWidgets/labels.dart';
import 'package:utilidades_condular/common/myWidgets/my_text.dart';
import 'package:utilidades_condular/defaul_config.dart';

class FormDropDown1 extends StatefulWidget {
  final String initialValue;
  final Map<String, String> items;
  final String textFormFieldOuterLabel;
  final bool textFormFieldObligatory;
  final TextEditingController controller;
  const FormDropDown1({
    Key? key,
    required this.initialValue,
    required this.items,
    required this.textFormFieldOuterLabel,
    required this.textFormFieldObligatory,
    required this.controller,
  }) : super(key: key);

  @override
  DropDown1 createState() => DropDown1();
}

class DropDown1 extends State<FormDropDown1> {
  late String dropdownvalue = widget.initialValue;

  @override
  void initState() {
    widget.controller.text =
        searchValueReturnKey(theMap: widget.items, value: dropdownvalue)!;
    dropdownvalue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          labelWMandatory(
            textFormFieldOuterLabel: widget.textFormFieldOuterLabel,
            textFormFieldObligatory: widget.textFormFieldObligatory,
          ),
          DropdownButtonFormField(
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              focusedBorder: textOutlineBorder(),
              enabledBorder: textOutlineBorder(),
            ),
            value: dropdownvalue,
            icon: const Icon(Icons.arrow_drop_down_sharp),
            items: widget.items.values.map((String v) {
              return DropdownMenuItem(
                value: v,
                child: Text(v),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (mounted) {
                setState(() {
                  widget.controller.text = searchValueReturnKey(
                      theMap: widget.items, value: newValue!)!;
                });
              }
            },
          ),
          mandatoryTextWidget(displayMandatoryField: false),
        ],
      ),
    );
  }
}

class SearchableDropDown extends StatefulWidget {
  final String textFormFieldOuterLabel;
  final bool textFormFieldObligatory;
  final List items;
  final String placeholderText;
  final TextEditingController controller;
  final GlobalKey<DropdownSearchState<String>> globalKey;
  final String initialvalue;
  bool displayMandatoryField;

  SearchableDropDown({
    Key? key,
    required this.textFormFieldOuterLabel,
    required this.textFormFieldObligatory,
    required this.items,
    required this.placeholderText,
    required this.controller,
    required this.globalKey,
    this.initialvalue = "",
    required this.displayMandatoryField,
  }) : super(key: key);

  @override
  SearchableDropDownBody createState() => SearchableDropDownBody();
}

class SearchableDropDownBody extends State<SearchableDropDown> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelWMandatory(
            textFormFieldOuterLabel: widget.textFormFieldOuterLabel,
            textFormFieldObligatory: widget.textFormFieldObligatory,
          ),
          DropdownSearch(
            selectedItem: widget.initialvalue,
            key: widget.globalKey,
            items: widget.items,
            popupProps: PopupPropsMultiSelection.menu(
              emptyBuilder: (context, searchEntry) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    searchEntry.isEmpty
                        ? 'No se encontraron resultados.'
                        : 'No se encontraron resultados para: "$searchEntry"',
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              },
              searchDelay: const Duration(milliseconds: 0),
              showSearchBox: true,
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              baseStyle: const TextStyle(
                height: 1.5,
              ),
              dropdownSearchDecoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                focusedBorder: textOutlineBorder(),
                enabledBorder: textOutlineBorder(),
                labelText: widget.placeholderText,
              ),
            ),
            onChanged: (value) {
              widget.controller.text = value.toString();
              if (mounted) {
                setState(() {
                  widget.controller.text.isEmpty
                      ? widget.displayMandatoryField = true
                      : widget.displayMandatoryField = false;
                });
              }
            },
          ),
          mandatoryTextWidget(
            displayMandatoryField: widget.displayMandatoryField,
          ),
        ],
      ),
    );
  }
}

// Expanded searchableDropDown({
//   required String textFormFieldOuterLabel,
//   required bool textFormFieldObligatory,
//   required List items,
//   required String placeholderText,
//   required TextEditingController controller,
//   required GlobalKey<DropdownSearchState<String>> key,
//   required bool displayMandatoryField,
// }) {
//   return Expanded(
//     child: Column(
//       children: [
//         labelWMandatory(
//           textFormFieldOuterLabel: textFormFieldOuterLabel,
//           textFormFieldObligatory: textFormFieldObligatory,
//         ),
//         DropdownSearch(
//           key: key,
//           items: items,
//           popupProps: PopupPropsMultiSelection.menu(
//             emptyBuilder: (context, searchEntry) {
//               return Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Text(
//                   'No se encontraron resultados para: "$searchEntry"',
//                   style: const TextStyle(fontSize: 16),
//                 ),
//               );
//             },
//             searchDelay: const Duration(milliseconds: 0),
//             showSearchBox: true,
//           ),
//           dropdownDecoratorProps: DropDownDecoratorProps(
//             baseStyle: const TextStyle(
//               height: 1.5,
//             ),
//             dropdownSearchDecoration: InputDecoration(
//               floatingLabelBehavior: FloatingLabelBehavior.auto,
//               focusedBorder: textOutlineBorder(),
//               enabledBorder: textOutlineBorder(),
//               labelText: placeholderText,
//             ),
//           ),
//           onChanged: (value) {
//             controller.text = value.toString();
//           },
//         ),
//         Text(
//           displayMandatoryField ? mandatoryText : "",
//           textAlign: TextAlign.left,
//           style: const TextStyle(
//             color: Colors.red,
//           ),
//         ),
//       ],
//     ),
//   );
// }
