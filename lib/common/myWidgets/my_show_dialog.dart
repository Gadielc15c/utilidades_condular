import 'package:flutter/material.dart';
import 'package:utilidades_condular/defaul_config.dart';
import 'package:utilidades_condular/pages/historico_de_acciones.dart';

import '../../pages/historico_de_archivos.dart';

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
Future<void> showUpdateArchivoDialog({
  required BuildContext context,
  required String idCode,
  required String areaRefText,
  required String codDeptoText,
  required String tituloText,
  required String personaEntText,
  required String numCopText,
  required String archivoDigText,
  required String fechaInDText,
  required String archivoFiscText,
  required String fechaInFText,
  required String observacionText,
  required String tiempoText,
  required String estadoText,
}) async {
  await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return GestureDetector(
        child: AlertDialog(
          content: SizedBox(
            width: colSpaceWidth(context) * 0.5,
            child: HistoricoDeArchivos(
              contextHeight: colSpaceHeight(context),
              contextWidth: colSpaceWidth(context),
              idCode: idCode,
              areaRefText: areaRefText,
              codDeptoText: codDeptoText,
              tituloText: tituloText,
              personaEntText: personaEntText,
              numCopText: numCopText,
              archivoDigText: archivoDigText,
              fechaInDText: fechaInDText,
              archivoFiscText: archivoFiscText,
              fechaInFText: fechaInFText,
              observacionText: observacionText,
              tiempoText: tiempoText,
              estadoText: estadoText,
              queryType: queryUpdate,
            ),
          ),
        ),
      );
    },
  );
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
    barrierDismissible: false,
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

// Future<void> loadingDialog({
//   required BuildContext context,
// }) async {
//   await showDialog<void>(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       return const AlertDialog(
//         content: CircularProgressIndicator(),
//       );
//     },
//   );
// }
