import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'form_label_1.dart';
import 'package:utilidades_condular/defaul_config.dart';
import 'package:utilidades_condular/common/decoration/dec_outline_input_border.dart';

class FormDatePicker1 extends StatefulWidget {
  final String textFormFieldOuterLabel;
  final bool textFormFieldObligatory;
  const FormDatePicker1({
    Key? key,
    required this.textFormFieldOuterLabel,
    required this.textFormFieldObligatory,
  }) : super(key: key);

  @override
  DatePicker1 createState() => DatePicker1();
}

class DatePicker1 extends State<FormDatePicker1> {
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = DateFormat(dateFormat).format(DateTime.now());
    super.initState();
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
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            controller: dateInput,
            style: const TextStyle(
              height: 1.5,
            ),
            decoration: InputDecoration(
              prefixIcon: const Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Icon(
                  color: Colors.black,
                  Icons.calendar_month,
                ),
              ),
              focusedBorder: textOutlineBorder(),
              enabledBorder: textOutlineBorder(),
            ),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialEntryMode: DatePickerEntryMode.input,
                // locale: const Locale("es", "MX"),
                initialDate: DateTime.now(),
                firstDate: DateTime(DateTime.now().year - 100),
                lastDate: DateTime(DateTime.now().year + 100),
                helpText: selectedDate,
                // fieldHintText: dateFormat.toLowerCase(),
                // fieldLabelText: writeDate,
                // errorFormatText: wrongFormat,
                // errorInvalidText: wrongDate,
                // cancelText: cancelOption,
                // confirmText: confirmOption,
              );
              if (pickedDate != null) {
                String formattedDate =
                    DateFormat(dateFormat).format(pickedDate);
                setState(() {
                  dateInput.text = formattedDate;
                });
              } else {}
            },
          ),
        ],
      ),
    );
  }
}
