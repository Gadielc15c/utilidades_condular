import 'package:flutter/material.dart';

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

// Needs work
Future<bool?> showDeleteConfirmationBottomSheet({
  required BuildContext context,
  required String textTitulo,
  required String textContexto,
  String textBotonAceptar = "Aceptar",
  String textBotonCancelar = "Cancelar",
}) async {
  return showModalBottomSheet<bool>(
    context: context,
    builder: (BuildContext context) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(textTitulo),
              subtitle: Text(textContexto),
            ),
            ButtonBar(
              children: <Widget>[
                TextButton(
                  child: Text(textBotonAceptar),
                  onPressed: () {
                    Navigator.pop(context, true); // Return false to cancel
                  },
                ),
                TextButton(
                  child: Text(textBotonCancelar),
                  onPressed: () {
                    Navigator.pop(context, false); // Return true to confirm
                  },
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
