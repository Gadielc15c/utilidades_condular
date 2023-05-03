import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:utilidades_condular/defaul_config.dart';

const String endp = "endpoint";

Future<Map<String, dynamic>> postData({
  required Map<String, dynamic> body,
}) async {
  final headers = {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'Content-Type',
    'Referrer-Policy': 'no-referrer-when-downgrade',
  };
  final response = await http.post(
    Uri.parse(
        'https://constructoracondular-spazz.pythonanywhere.com/$endpoint'),
    headers: headers,
    body: jsonEncode(body),
  );
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    return {
      scc: false,
      err: 'Error: Response code ${response.statusCode}',
      cnt: '',
    };
  }
}

Future<Map<String, dynamic>> sendData({
  required Map<String, dynamic> toSend,
}) async {
  try {
    return await postData(
      body: toSend,
    );
  } catch (_) {
    return {
      scc: false,
      err: 'Error: No hay conección al API.',
      cnt: '',
    };
  }
}

Future<Map<String, dynamic>> verifyLogin({
  required String email,
  required String pwd,
}) async {
  final Map<String, dynamic> data = {'email': email, 'pwd': pwd, endp: 'login'};
  return sendData(toSend: data);
}

Future<Map<String, dynamic>> insertData({
  required String table,
  required List<String> values,
}) async {
  final Map<String, dynamic> data = {
    'table': table,
    'values': values,
    endp: 'insertdb'
  };
  return sendData(toSend: data);
}

Future<Map<String, dynamic>> updateData({
  required String table,
  required List<String> columns,
  required List<String> values,
  required String whr,
  required String whrval,
}) async {
  final Map<String, dynamic> data = {
    'table': table,
    'col': columns,
    'values': values,
    'whr': whr,
    'whrval': whrval,
    endp: 'updatedb'
  };
  return sendData(toSend: data);
}

Future<Map<String, dynamic>> selectData({
  required String table,
}) async {
  final Map<String, dynamic> data = {'table': table, endp: 'selectdb'};
  return sendData(toSend: data);
}

Future<Map<String, dynamic>> deleteData({
  required String table,
  required String id,
}) async {
  final Map<String, dynamic> data = {
    'table': table,
    'id': id,
    endp: 'deletedb'
  };
  return sendData(toSend: data);
}

Future<Map<String, dynamic>> spData({
  required String sp,
}) async {
  final Map<String, dynamic> data = {'sp': sp, endp: 'spdb'};
  return sendData(toSend: data);
}
