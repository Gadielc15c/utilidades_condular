import 'package:flutter/material.dart';

double colSpaceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double colSpaceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

// For Dates
const String dateFormat = "dd-MM-yyyy";
const String wrongFormat = "Formato Incorrecto";
const String wrongDate = "Fecha Inválida";
const String selectedDate = "Fecha Seleccionada";
const String writeDate = "Ingresar fecha:";

//
const String cancelOption = "CANCELAR";
const String confirmOption = "CONFIRMAR";
const String mandatoryText = 'Campo Obligatorio';

// NO TOCAR
const String err = 'error';
const String cnt = 'content';
const String scc = 'success';
const String queryInsert = "insert0";
const String queryUpdate = "update0";

const String typeInsert = "Inserta";
const String typeEdit = "Actualiza";
const String typeDelete = "Elimina";
const String notProvided = "None Provided";

const String defaultYes = "Si";
const String defaultNo = "No";
