// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:utilidades_condular/backend/api_bridge.dart';
import 'package:utilidades_condular/common/myFunctions/auth.dart';
import 'package:utilidades_condular/common/myFunctions/format_logs.dart';
import 'package:utilidades_condular/common/myFunctions/get_datetime_utc.dart';
import 'package:utilidades_condular/common/myFunctions/spacing_calc.dart';
import 'package:utilidades_condular/common/myWidgets/dropdownbutton.dart';
import 'package:utilidades_condular/common/myWidgets/my_show_dialog.dart';
import 'package:utilidades_condular/common/myWidgets/snack_bar.dart';
import 'package:utilidades_condular/common/myWidgets/text_field.dart';
import 'package:utilidades_condular/common/myWidgets/datepicker.dart';
import 'package:utilidades_condular/common/myWidgets/sized_boxes.dart';
import 'package:utilidades_condular/common/myWidgets/labels.dart';
import 'package:utilidades_condular/common/decoration/dec_outline_input_border.dart';
import 'package:utilidades_condular/common/myWidgets/buttons.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:utilidades_condular/common/myWidgets/waiting_screen.dart';
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

  bool loadingScreen = false;

  Map<String, String> myListValues = {};
  List selectItems = [];

  @override
  void initState() {
    populateSelectField();

    super.initState();
  }

  Future<void> populateSelectField() async {
    List tempData = await _getSearchableItems();
    if (mounted) {
      setState(() {
        selectItems = tempData;
      });
    }
  }

  Future<List> _getSearchableItems() async {
    var results = await spData(sp: "get_unique_proyectos_name");
    List selectionData = [];
    if (results[scc]) {
      for (var aMap in results[cnt].values) {
        myListValues[aMap['NOMBRE']] = aMap['ID_PROYECTO'];
        selectionData.add(aMap['NOMBRE'].toString());
      }
    } else {
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

    String oProyecto = widget.proyectoText ?? '';
    String oAccion = widget.accionText ?? '';
    String oFecha = widget.fechaText ?? '';
    String oObservacion = widget.observacionText ?? '';
    String oDescripcion = widget.descripcionText ?? '';

    String oDataEdit = stringForLogs([
      "ID: ${widget.idCode ?? ''}",
      "PROYECTO: $oProyecto",
      "ACCION: $oAccion",
      "FECHA: $oFecha",
      "DESCRIPCION: $oDescripcion",
      "OBSERVACION: $oObservacion",
    ]);

    double maxSpacing = widget.queryType == queryInsert ? 43.47 : 60;
    double maxContextHeightSize = widget.queryType == queryInsert ? 807.5 : 969;
    double minContextHeightSize = widget.queryType == queryInsert ? 600 : 700;
    double sizedBoxHeight = spacingHeight(
      contextHeight: widget.contextHeight,
      minContextHeightSize: minContextHeightSize,
      maxContextHeightSize: maxContextHeightSize,
      maxSpacing: maxSpacing,
    );

    return sizedBoxPadding(
      contextHeight: widget.contextHeight,
      child: Stack(
        children: [
          ListView(
            children: [
              Column(
                children: [
                  Center(
                    child: largeLabel1(text: "HISTORICO DE ACCIONES"),
                  ),
                  Divider(
                    color: textFieldBorderColor,
                  ),
                  sizedBoxH(height: sizedBoxHeight),
                  Row(
                    children: [
                      SearchableDropDown(
                        globalKey: keyHDAcc1,
                        controller: controllerProyecto,
                        textFormFieldOuterLabel: "Proyecto",
                        textFormFieldObligatory: true,
                        items: selectItems,
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
                  sizedBoxH(height: sizedBoxHeight),
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
                  sizedBoxH(height: sizedBoxHeight),
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
                  sizedBoxH(height: sizedBoxHeight),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Button1(
                        buttonLabel: "Guardar",
                        buttonIcon: const Icon(Icons.save),
                        onPressed: () async {
                          if (mounted) {
                            setState(() {
                              loadingScreen = true;
                            });
                          }
                          final controllers = [
                            controllerProyecto,
                            controllerAccion,
                            controllerFecha,
                            controllerDescripcion,
                            controllerObservacion,
                          ];
                          final isEmpty = controllers
                              .any((controller) => controller.text.isEmpty);

                          if (!isEmpty) {
                            List<String> valuesList = [
                              myListValues[controllerProyecto.text] ?? "",
                              controllerAccion.text,
                              controllerFecha.text,
                              controllerDescripcion.text,
                              controllerObservacion.text,
                              "1", //ESTADO
                            ];

                            if (widget.queryType == queryInsert) {
                              var results = await insertData(
                                table: "ACTIVIDADES",
                                values: valuesList,
                              );
                              if (results[scc]) {
                                await insertData(
                                  table: "LOGS",
                                  values: [
                                    await getUser(context) ?? "",
                                    typeInsert,
                                    "ACTIVIDADES",
                                    "",
                                    stringForLogs([
                                      "ID: ${widget.idCode ?? notProvided}",
                                      "PROYECTO: ${valuesList[0]}",
                                      "ACCION: ${valuesList[1]}",
                                      "FECHA: ${valuesList[2]}",
                                      "DESCRIPCION: ${valuesList[3]}",
                                      "OBSERVACION: ${valuesList[4]}",
                                      "ESTADO: ${1}",
                                    ]),
                                    getDateTime(),
                                  ],
                                );
                              }

                              mySnackBar(
                                context: context,
                                success: results[scc],
                                successfulText: "Se introdujeron los datos",
                                unsuccessfulText: results[err],
                              );
                            } else {
                              if (widget.idCode != null) {
                                var results = await updateData(
                                  table: "ACTIVIDADES",
                                  columns: [],
                                  values: valuesList,
                                  whr: "ID",
                                  whrval: widget.idCode!,
                                );
                                if (results[scc]) {
                                  await insertData(
                                    table: "LOGS",
                                    values: [
                                      await getUser(context) ?? "",
                                      typeEdit,
                                      "ACTIVIDADES",
                                      oDataEdit,
                                      stringForLogs([
                                        "ID: ${widget.idCode ?? notProvided}",
                                        "PROYECTO: ${controllerProyecto.text}",
                                        "ACCION: ${valuesList[1]}",
                                        "FECHA: ${valuesList[2]}",
                                        "DESCRIPCION: ${valuesList[3]}",
                                        "OBSERVACION: ${valuesList[4]}",
                                        "ESTADO: ${1}",
                                      ]),
                                      getDateTime(),
                                    ],
                                  );
                                }

                                mySnackBar(
                                  context: context,
                                  success: results[scc],
                                  successfulText: "Se actualizaron los datos",
                                  unsuccessfulText: results[err],
                                );
                              } else {
                                mySnackBar(
                                  context: context,
                                  success: false,
                                  successfulText: "",
                                  unsuccessfulText: "Error 100034",
                                );
                              }
                              Navigator.of(context).pop();
                            }
                          } else {
                            if (mounted && widget.queryType == queryInsert) {
                              setState(() {
                                boolMFProyecto =
                                    controllerProyecto.text.isEmpty;
                                boolMFAccion = controllerAccion.text.isEmpty;
                                boolMFFecha = controllerFecha.text.isEmpty;
                                boolMFDescripcion =
                                    controllerDescripcion.text.isEmpty;
                                boolMFObservacion =
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
                          if (mounted) {
                            setState(() {
                              loadingScreen = false;
                            });
                          }
                        },
                      ),
                      if (widget.queryType == queryUpdate) sizedBoxW(width: 10),
                      if (widget.queryType == queryUpdate)
                        Button1(
                          buttonLabel: "Cancelar",
                          buttonIcon: const Icon(Icons.cancel_outlined),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          if (loadingScreen) loadScreen(context: context)
        ],
      ),
    );
  }
}
