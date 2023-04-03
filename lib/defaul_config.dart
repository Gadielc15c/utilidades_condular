import 'package:flutter/material.dart';

double colSpaceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double colSpaceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

// For Dates
String dateFormat = "dd-MM-yyyy";
String wrongFormat = "Formato Incorrecto";
String wrongDate = "Fecha Inválida";
String selectedDate = "Fecha Seleccionada";
String writeDate = "Ingresar fecha:";

//
String cancelOption = "CANCELAR";
String confirmOption = "CONFIRMAR";
const String mandatoryText = 'Campo Obligatorio';

// NO TOCAR
const String err = 'error';
const String cnt = 'content';
const String scc = 'success';
const String queryInsert = "insert0";
const String queryUpdate = "update0";
