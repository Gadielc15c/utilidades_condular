import 'package:flutter/material.dart';
import 'package:utilidades_condular/defaul_config.dart';
import 'package:utilidades_condular/pages/historico_de_acciones.dart';

Future<bool> showDeleteConfirmationDialog({
  required BuildContext context,
  required String textTitulo,
  required String textContexto,
  String textBotonAceptar = "Aceptar",
  String textBotonCancelar = "Cancelar",
}) async {
  bool result = false;
  await showDialog<bool?>(
    context: context,
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {
          result = false;
        },
        child: AlertDialog(
          title: Text(textTitulo),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(textContexto),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(textBotonAceptar),
              onPressed: () {
                Navigator.of(context).pop();
                result = true;
              },
            ),
            TextButton(
              child: Text(textBotonCancelar),
              onPressed: () {
                Navigator.of(context).pop();
                result = false;
              },
            ),
          ],
        ),
      );
    },
  );
  return result;
}

Future<void> showUpdateHistoricoDeAccionesDialog({
  required BuildContext context,
  required String idCode,
  required String proyectoText,
  required String accionText,
  required String fechaText,
  required String observacionText,
  required String descripcionText,
}) async {
  await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return GestureDetector(
        child: AlertDialog(
          content: SizedBox(
            width: colSpaceWidth(context) * 0.5,
            child: HistoricoDeAcciones(
              contextHeight: colSpaceHeight(context),
              contextWidth: colSpaceWidth(context),
              idCode: idCode,
              proyectoText: proyectoText,
              accionText: accionText,
              fechaText: fechaText,
              observacionText: observacionText,
              descripcionText: descripcionText,
              queryType: queryUpdate,
            ),
          ),
        ),
      );
    },
  );
}

Future<bool> showEditDialog({
  required BuildContext context,
  required String textTitulo,
  required String textContexto,
  String textBotonAceptar = "Aceptar",
  String textBotonCancelar = "Cancelar",
}) async {
  bool result = false;
  await showDialog<bool?>(
    context: context,
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {
          result = false;
        },
        child: AlertDialog(
          title: Text(textTitulo),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(textContexto),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(textBotonAceptar),
              onPressed: () {
                Navigator.of(context).pop();
                result = true;
              },
            ),
            TextButton(
              child: Text(textBotonCancelar),
              onPressed: () {
                Navigator.of(context).pop();
                result = false;
              },
            ),
          ],
        ),
      );
    },
  );
  return result;
}
