import 'package:flutter/material.dart';
import 'package:utilidades_condular/backend/api_bridge.dart';
import 'package:utilidades_condular/common/myWidgets/snack_bar.dart';
import 'package:utilidades_condular/common/myWidgets/text_field.dart';
import 'package:utilidades_condular/common/myWidgets/dropdownbutton.dart';
import 'package:utilidades_condular/common/myWidgets/datepicker.dart';
import 'package:utilidades_condular/common/myWidgets/sized_boxes.dart';
import 'package:utilidades_condular/common/myWidgets/labels.dart';
import 'package:utilidades_condular/common/decoration/dec_outline_input_border.dart';
import 'package:utilidades_condular/common/myWidgets/buttons.dart';
import 'package:dropdown_search/dropdown_search.dart';
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
  TextEditingController controllerCOD = TextEditingController();
  TextEditingController controllerEntrega = TextEditingController();
  TextEditingController controllerArea = TextEditingController();
  TextEditingController controllerNumCopias = TextEditingController();
  TextEditingController controllerTitulo = TextEditingController();
  TextEditingController controllerArchDigital = TextEditingController();
  TextEditingController controllerTiempo = TextEditingController();
  TextEditingController controllerObservacion = TextEditingController();
  TextEditingController controllerFechaDigital = TextEditingController();
  TextEditingController controllerFechaFisico = TextEditingController();
  GlobalKey<DropdownSearchState<String>> keyHDarch1 =
      GlobalKey<DropdownSearchState<String>>();

  bool boolMFCOD = false;
  bool boolMFEntrega = false;
  bool boolMFArea = false;
  bool boolMFNumCopias = false;
  bool boolMFTitulo = false;
  bool boolMFArchDigital = false;
  bool boolMFTiempo = false;
  bool boolMFObservacion = false;
  bool boolMFFechaDigital = false;
  bool boolMFFechaFisico = false;

  @override
  Widget build(BuildContext context) {
    double widgetHeight = widget.contextHeight / 7;

    return sizedBoxPadding(
      contextHeight: widget.contextHeight,
      child: ListView(
        children: [
          Center(
            child: largeLabel1(text: "HISTORICO DE ARCHIVOS"),
          ),
          Divider(
            color: textFieldBorderColor,
          ),
          Row(
            children: [
              SearchableDropDown(
                globalKey: keyHDarch1,
                controller: controllerCOD,
                textFormFieldOuterLabel: "COD",
                textFormFieldObligatory: true,
                items: [
                  "001",
                  "002",
                ],
                placeholderText: "Seleccione el Código",
                displayMandatoryField: boolMFCOD,
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
              TextField1(
                controller: controllerArea,
                textFormFieldOuterLabel: "AREA DE REFERENCIA",
                textFormFieldObligatory: true,
                displayMandatoryField: boolMFArea,
              ),
              sizedBoxW(),
              TextField1(
                controller: controllerNumCopias,
                textFormFieldOuterLabel: "Númeor de Copias",
                textFormFieldObligatory: true,
                displayMandatoryField: boolMFNumCopias,
              ),
            ],
          ),
          Row(
            children: [
              TextField1(
                controller: controllerTitulo,
                textFormFieldOuterLabel: "TITULO",
                textFormFieldObligatory: true,
                displayMandatoryField: boolMFTitulo,
              ),
              sizedBoxW(),
              TextField1(
                controller: controllerArchDigital,
                textFormFieldOuterLabel: "Archivo Digital",
                textFormFieldObligatory: true,
                displayMandatoryField: boolMFArchDigital,
              ),
            ],
          ),
          Row(
            children: [
              FormDatePicker1(
                controller: controllerFechaDigital,
                textFormFieldOuterLabel: "FECHA INGRESO DIGITAL",
                textFormFieldObligatory: true,
                displayMandatoryField: boolMFFechaDigital,
              ),
              sizedBoxW(),
              FormDatePicker1(
                controller: controllerFechaFisico,
                textFormFieldOuterLabel: "FECHA INGRESO FISICO",
                textFormFieldObligatory: true,
                displayMandatoryField: boolMFFechaFisico,
              ),
            ],
          ),
          Row(
            children: [
              TextField1(
                controller: controllerTiempo,
                textFormFieldOuterLabel: "TIEMPO",
                textFormFieldObligatory: true,
                displayMandatoryField: boolMFTiempo,
              ),
              sizedBoxW(),
              TextField1(
                controller: controllerObservacion,
                textFormFieldOuterLabel: "OBSERVACION",
                textFormFieldObligatory: true,
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
                  final controllers = [
                    controllerCOD,
                    controllerEntrega,
                    controllerArea,
                    controllerNumCopias,
                    controllerTitulo,
                    controllerArchDigital,
                    controllerTiempo,
                    controllerObservacion,
                    controllerFechaDigital,
                    controllerFechaFisico,
                  ];

                  final isEmpty =
                      controllers.any((controller) => controller.text.isEmpty);

                  if (!isEmpty) {
                    List<String> valuesList = controllers
                        .map((controller) => controller.text)
                        .toList();
                    valuesList.add("1"); //estado
                    var results = await insertData(
                      table: "ARCHIVOS",
                      values: valuesList,
                    );

                    // ignore: use_build_context_synchronously
                    mySnackBar(
                      context: context,
                      success: results[scc],
                      successfulText: "Se introdujeron los datos",
                      unsuccessfulText: results[err],
                    );

                    if (results[scc]) {
                      for (var controller in controllers) {
                        controller.clear();
                      }
                    }
                  } else {
                    setState(() {
                      boolMFCOD = controllerCOD.text.isEmpty;
                      boolMFEntrega = controllerEntrega.text.isEmpty;
                      boolMFArea = controllerArea.text.isEmpty;
                      boolMFNumCopias = controllerNumCopias.text.isEmpty;
                      boolMFTitulo = controllerTitulo.text.isEmpty;
                      boolMFArchDigital = controllerArchDigital.text.isEmpty;
                      boolMFTiempo = controllerTiempo.text.isEmpty;
                      boolMFObservacion = controllerObservacion.text.isEmpty;
                      boolMFFechaDigital = controllerFechaDigital.text.isEmpty;
                      boolMFFechaFisico = controllerFechaFisico.text.isEmpty;
                    });

                    mySnackBar(
                      context: context,
                      success: false,
                      successfulText: "Se introdujeron los datos",
                      unsuccessfulText:
                          "Debes llenar los campos obligatorios que son aquellos con asterisco *",
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
