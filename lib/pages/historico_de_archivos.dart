// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:utilidades_condular/backend/api_bridge.dart';
import 'package:utilidades_condular/common/myFunctions/format_logs.dart';
import 'package:utilidades_condular/common/myFunctions/get_datetime_utc.dart';
import 'package:utilidades_condular/common/myWidgets/snack_bar.dart';
import 'package:utilidades_condular/common/myWidgets/text_field.dart';
import 'package:utilidades_condular/common/myWidgets/dropdownbutton.dart';
import 'package:utilidades_condular/common/myWidgets/datepicker.dart';
import 'package:utilidades_condular/common/myWidgets/sized_boxes.dart';
import 'package:utilidades_condular/common/myWidgets/labels.dart';
import 'package:utilidades_condular/common/decoration/dec_outline_input_border.dart';
import 'package:utilidades_condular/common/myWidgets/buttons.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:utilidades_condular/common/myWidgets/waiting_screen.dart';
import 'package:utilidades_condular/defaul_config.dart';

// Proyectos
class HistoricoDeArchivos extends StatefulWidget {
  final double contextHeight;
  final double contextWidth;
  const HistoricoDeArchivos({
    Key? key,
    required this.contextHeight,
    required this.contextWidth,
  }) : super(key: key);

  @override
  HistoricoDeArchivosBody createState() => HistoricoDeArchivosBody();
}

class HistoricoDeArchivosBody extends State<HistoricoDeArchivos> {
  double maxHeight = 165;
  double minHeight = 95;
  TextEditingController controllerArea = TextEditingController();
  TextEditingController controllerCodDepto = TextEditingController();
  TextEditingController controllerTitulo = TextEditingController();
  TextEditingController controllerEntrega = TextEditingController();
  TextEditingController controllerNumCopias = TextEditingController();
  TextEditingController controllerArchDigital = TextEditingController();
  TextEditingController controllerFechaDigital = TextEditingController();
  TextEditingController controllerArchFisico = TextEditingController();
  TextEditingController controllerFechaFisico = TextEditingController();
  TextEditingController controllerObservacion = TextEditingController();
  TextEditingController controllerTiempo = TextEditingController();

  GlobalKey<DropdownSearchState<String>> keyHDarch1 =
      GlobalKey<DropdownSearchState<String>>();

  bool boolMFArea = false;
  bool boolMFCodDepto = false;
  bool boolMFTitulo = false;
  bool boolMFEntrega = false;
  bool boolMFNumCopias = false;
  bool boolMFArchDigital = false;
  bool boolMFFechaDigital = false;
  bool boolMFArchFisico = false;
  bool boolMFFechaFisico = false;
  bool boolMFObservacion = false;
  bool boolMFTiempo = false;

  bool loadingScreen = false;

  Map<String, String> defaultSelectionOptions = {
    "1": defaultYes,
    "0": defaultNo,
  };

  @override
  Widget build(BuildContext context) {
    controllerFechaDigital.clear();
    controllerFechaFisico.clear();
    return sizedBoxPadding(
      contextHeight: widget.contextHeight,
      child: Stack(
        children: [
          ListView(
            children: [
              Center(
                child: largeLabel1(text: "HISTORICO DE ARCHIVOS"),
              ),
              Divider(
                color: textFieldBorderColor,
              ),
              Row(
                children: [
                  TextField1(
                    controller: controllerTitulo,
                    textFormFieldOuterLabel: "TITULO",
                    textFormFieldObligatory: true,
                    displayMandatoryField: boolMFTitulo,
                  ),
                ],
              ),
              Row(
                children: [
                  TextField1(
                    controller: controllerArea,
                    textFormFieldOuterLabel: "AREA DE REFERENCIA",
                    textFormFieldObligatory: false,
                    displayMandatoryField: boolMFArea,
                  ),
                  sizedBoxW(),
                  TextField1(
                    controller: controllerEntrega,
                    textFormFieldOuterLabel: "Persona quien entrega",
                    textFormFieldObligatory: true,
                    displayMandatoryField: boolMFEntrega,
                  ),
                ],
              ),
              Row(
                children: [
                  FormDropDown1(
                    initialValue: defaultSelectionOptions.values.toList()[0],
                    items: defaultSelectionOptions,
                    textFormFieldOuterLabel: "Archivo Digital",
                    textFormFieldObligatory: true,
                    controller: controllerArchDigital,
                  ),
                  sizedBoxW(),
                  FormDropDown1(
                    initialValue: defaultSelectionOptions.values.toList()[0],
                    items: defaultSelectionOptions,
                    textFormFieldOuterLabel: "Archivo Físico",
                    textFormFieldObligatory: true,
                    controller: controllerArchFisico,
                  ),
                ],
              ),
              Row(
                children: [
                  FormDatePicker1(
                    controller: controllerFechaDigital,
                    textFormFieldOuterLabel: "FECHA INGRESO DIGITAL",
                    textFormFieldObligatory: false,
                    displayMandatoryField: boolMFFechaDigital,
                  ),
                  sizedBoxW(),
                  FormDatePicker1(
                    controller: controllerFechaFisico,
                    textFormFieldOuterLabel: "FECHA INGRESO FISICO",
                    textFormFieldObligatory: false,
                    displayMandatoryField: boolMFFechaFisico,
                  ),
                ],
              ),
              Row(
                children: [
                  TextField1(
                    controller: controllerNumCopias,
                    textFormFieldOuterLabel: "Número de Copias",
                    textFormFieldObligatory: true,
                    displayMandatoryField: boolMFNumCopias,
                    onlyDigits: true,
                  ),
                  sizedBoxW(),
                  TextField1(
                    controller: controllerTiempo,
                    textFormFieldOuterLabel: "TIEMPO",
                    textFormFieldObligatory: false,
                    displayMandatoryField: boolMFTiempo,
                  ),
                ],
              ),
              Row(
                children: [
                  TextField1(
                    controller: controllerObservacion,
                    textFormFieldOuterLabel: "OBSERVACION",
                    textFormFieldObligatory: false,
                    displayMandatoryField: boolMFObservacion,
                  ),
                ],
              ),
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
                        controllerArea,
                        controllerCodDepto,
                        controllerTitulo,
                        controllerEntrega,
                        controllerNumCopias,
                        controllerArchDigital,
                        controllerFechaDigital,
                        controllerArchFisico,
                        controllerFechaFisico,
                        controllerObservacion,
                        controllerTiempo,
                      ];
                      bool isEmpty = false;
                      List<TextEditingController> onlyCheck = [
                        controllerTitulo,
                        controllerEntrega,
                        controllerNumCopias,
                        controllerArchDigital,
                        controllerFechaDigital,
                      ];
                      for (TextEditingController c in controllers) {
                        if (onlyCheck.contains(c)) {
                          isEmpty = c.text.isEmpty;
                          if (isEmpty) {
                            break;
                          }
                        }
                      }

                      if (!isEmpty) {
                        List<String> valuesList = [];
                        String value = "";
                        for (TextEditingController c in controllers) {
                          value = c.text;
                          if (c == controllerTiempo && c.text == '') {
                            value = "INDEFINIDO";
                          }
                          valuesList.add(value);
                        }

                        valuesList.add("1"); //estado
                        var results = await insertData(
                          table: "ARCHIVOS",
                          values: valuesList,
                        );

                        mySnackBar(
                          context: context,
                          success: results[scc],
                          successfulText: "Se introdujeron los datos",
                          unsuccessfulText: results[err],
                        );

                        if (results[scc]) {
                          // for (var controller in controllers) {
                          //   controller.clear();
                          // }

                          await insertData(
                            table: "LOGS",
                            values: [
                              "a user",
                              typeInsert,
                              "ARCHIOS",
                              "",
                              stringForLogs([
                                "ID: $notProvided",
                                "AREA_REF: ${valuesList[0]}",
                                "COD_DEPTO: ${valuesList[1]}",
                                "TITULO: ${valuesList[2]}",
                                "PERSONA_ENT: ${valuesList[3]}",
                                "NUM_COP: ${valuesList[4]}",
                                "ARCHIVO_DIG: ${valuesList[5]}",
                                "FECHA_IN_D: ${valuesList[6]}",
                                "ARCHIVO_FISC: ${valuesList[7]}",
                                "FECHA_IN_F: ${valuesList[8]}",
                                "OBSERVACION: ${valuesList[9]}",
                                "TIEMPO: ${valuesList[10]}",
                                "ESTADO: ${1}",
                              ]),
                              getDateTime(),
                            ],
                          );
                        }
                      } else {
                        if (mounted) {
                          setState(() {
                            // boolMFArea = controllerArea.text.isEmpty;
                            // boolMFCodDepto = controllerCodDepto.text.isEmpty;
                            boolMFTitulo = controllerTitulo.text.isEmpty;
                            boolMFEntrega = controllerEntrega.text.isEmpty;
                            boolMFNumCopias = controllerNumCopias.text.isEmpty;
                            boolMFArchDigital =
                                controllerArchDigital.text.isEmpty;
                            boolMFFechaDigital =
                                controllerFechaDigital.text.isEmpty;
                            // boolMFArchFisico = controllerArchFisico.text.isEmpty;
                            // boolMFFechaFisico = controllerFechaFisico.text.isEmpty;
                            // boolMFObservacion = controllerObservacion.text.isEmpty;
                            // boolMFTiempo = controllerTiempo.text.isEmpty;
                          });
                        }

                        mySnackBar(
                          context: context,
                          success: false,
                          successfulText: "Se introdujeron los datos",
                          unsuccessfulText:
                              "Debes llenar los campos obligatorios que son aquellos con asterisco *",
                        );
                      }
                      if (mounted) {
                        setState(() {
                          loadingScreen = false;
                        });
                      }
                    },
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
