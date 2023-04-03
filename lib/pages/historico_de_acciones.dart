import 'package:flutter/material.dart';
import 'package:utilidades_condular/backend/api_bridge.dart';
import 'package:utilidades_condular/common/myWidgets/dropdownbutton.dart';
import 'package:utilidades_condular/common/myWidgets/snack_bar.dart';
import 'package:utilidades_condular/common/myWidgets/text_field.dart';
import 'package:utilidades_condular/common/myWidgets/datepicker.dart';
import 'package:utilidades_condular/common/myWidgets/sized_boxes.dart';
import 'package:utilidades_condular/common/myWidgets/labels.dart';
import 'package:utilidades_condular/common/decoration/dec_outline_input_border.dart';
import 'package:utilidades_condular/common/myWidgets/buttons.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:utilidades_condular/defaul_config.dart';

class HistoricoDeAcciones extends StatefulWidget {
  final double contextHeight;
  final double contextWidth;
  String? idCode;
  String? proyectoText;
  String? accionText;
  String? fechaText;
  String? observacionText;
  String? descripcionText;
  String queryType;
  HistoricoDeAcciones({
    Key? key,
    required this.contextHeight,
    required this.contextWidth,
    this.idCode,
    this.proyectoText,
    this.accionText,
    this.fechaText,
    this.observacionText,
    this.descripcionText,
    this.queryType = queryInsert,
  }) : super(key: key);

  @override
  HistoricoDeAccionesBody createState() => HistoricoDeAccionesBody();
}

class HistoricoDeAccionesBody extends State<HistoricoDeAcciones> {
  double maxHeight = 170;
  double minHeight = 95;
  TextEditingController controllerProyecto = TextEditingController();
  TextEditingController controllerAccion = TextEditingController();
  TextEditingController controllerFecha = TextEditingController();
  TextEditingController controllerObservacion = TextEditingController();
  TextEditingController controllerDescripcion = TextEditingController();
  GlobalKey<DropdownSearchState<String>> keyHDAcc1 =
      GlobalKey<DropdownSearchState<String>>();

  bool boolMFProyecto = false;
  bool boolMFAccion = false;
  bool boolMFFecha = false;
  bool boolMFObservacion = false;
  bool boolMFDescripcion = false;

  Map<String, String> myListValues = {};

  @override
  void dispose() {
    super.dispose();
  }

  Future<List> _getSearchableItems() async {
    var results = await spData(sp: "get_unique_proyectos_name");
    List selectionData = [];
    // Map<String, String> aListValues = {};
    if (results[scc]) {
      for (var aMap in results[cnt].values) {
        myListValues[aMap['NOMBRE']] = aMap['ID_PROYECTO'];
        selectionData.add(aMap['NOMBRE'].toString());
      }
    } else {
      // ignore: use_build_context_synchronously
      mySnackBar(
        context: context,
        success: false,
        successfulText: "",
        unsuccessfulText: results[err],
      );
    }
    return selectionData;
  }

  @override
  Widget build(BuildContext context) {
    double widgetHeight = widget.contextHeight / 5;

    if (widget.proyectoText != null &&
        widget.accionText != null &&
        widget.fechaText != null &&
        widget.observacionText != null &&
        widget.descripcionText != null) {
      controllerProyecto.selection =
          TextSelection.collapsed(offset: controllerProyecto.text.length);

      controllerProyecto.text = widget.proyectoText ?? '';
      controllerAccion.text = widget.accionText ?? '';
      controllerFecha.text = widget.fechaText ?? '';
      controllerObservacion.text = widget.observacionText ?? '';
      controllerDescripcion.text = widget.descripcionText ?? '';
    }

    return sizedBoxPadding(
      contextHeight: widget.contextHeight,
      child: FutureBuilder<List>(
        future: _getSearchableItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return const Text('No data');
          }
          return Column(
            children: [
              Center(
                child: largeLabel1(text: "HISTORICO DE ACCIONES"),
              ),
              const Spacer(),
              Divider(
                color: textFieldBorderColor,
              ),
              const Spacer(),
              Row(
                children: [
                  SearchableDropDown(
                    globalKey: keyHDAcc1,
                    controller: controllerProyecto,
                    textFormFieldOuterLabel: "Proyecto",
                    textFormFieldObligatory: true,
                    items: snapshot.data!,
                    placeholderText: "Seleccione el proyecto",
                    initialvalue: controllerProyecto.text.isNotEmpty
                        ? controllerProyecto.text
                        : '',
                    displayMandatoryField: boolMFProyecto,
                  ),
                  sizedBoxW(),
                  TextField1(
                    controller: controllerAccion,
                    textFormFieldOuterLabel: "Acción",
                    textFormFieldObligatory: true,
                    displayMandatoryField: boolMFAccion,
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  FormDatePicker1(
                    controller: controllerFecha,
                    textFormFieldOuterLabel: "Fecha",
                    textFormFieldObligatory: true,
                    displayMandatoryField: boolMFFecha,
                  ),
                  sizedBoxW(),
                  TextField1(
                    controller: controllerObservacion,
                    textFormFieldOuterLabel: "Observación",
                    textFormFieldObligatory: true,
                    displayMandatoryField: boolMFObservacion,
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  TextField1(
                    controller: controllerDescripcion,
                    textFormFieldOuterLabel: "Descripción",
                    textFormFieldObligatory: true,
                    textFormMaxLines: 3,
                    displayMandatoryField: boolMFDescripcion,
                  )
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Button1(
                    buttonLabel: "Guardar",
                    buttonIcon: const Icon(Icons.save),
                    onPressed: () async {
                      final controllers = [
                        controllerProyecto,
                        controllerAccion,
                        controllerFecha,
                        controllerDescripcion,
                        controllerObservacion,
                      ];
                      final isEmpty = controllers
                          .any((controller) => controller.text.isEmpty);

                      var results = {scc: false};

                      if (!isEmpty) {
                        List<String> valuesList = [];
                        String valueToAdd = "";
                        for (var c in controllers) {
                          valueToAdd = c.text;
                          if (c == controllerProyecto) {
                            valueToAdd = myListValues[c.text]!;
                          }

                          valuesList.add(valueToAdd);
                        }
                        valuesList.add("1");

                        if (widget.queryType == queryInsert) {
                          var results = await insertData(
                            table: "ACTIVIDADES",
                            values: valuesList,
                          );

                          // ignore: use_build_context_synchronously
                          mySnackBar(
                            context: context,
                            success: results[scc],
                            successfulText: "Se introdujeron los datos",
                            unsuccessfulText: results[err],
                          );
                        } else {
                          var results = await updateData(
                            table: "ACTIVIDADES",
                            columns: [],
                            values: valuesList,
                            whr: "ID",
                            whrval: widget.idCode ?? "",
                          );

                          // ignore: use_build_context_synchronously
                          mySnackBar(
                            context: context,
                            success: results[scc],
                            successfulText: "Se actualizaron los datos",
                            unsuccessfulText: results[err],
                          );
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        }
                      } else {
                        if (widget.queryType == queryInsert) {
                          setState(() {
                            boolMFProyecto = controllerProyecto.text.isEmpty;
                            boolMFAccion = controllerAccion.text.isEmpty;
                            boolMFFecha = controllerFecha.text.isEmpty;
                            boolMFObservacion =
                                controllerDescripcion.text.isEmpty;
                            boolMFDescripcion =
                                controllerObservacion.text.isEmpty;
                          });

                          mySnackBar(
                            context: context,
                            success: false,
                            successfulText: "",
                            unsuccessfulText:
                                "Debes llenar los campos obligatorios que son aquellos con asterisco *",
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
