import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:utilidades_condular/defaul_config.dart';

Future<Map<String, dynamic>> postData({
  required String endpoint,
  required Map<String, dynamic> body,
}) async {
  final headers = {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'Content-Type',
    'Referrer-Policy': 'no-referrer-when-downgrade',
  };
  final response = await http.post(
    Uri.parse('http://127.0.0.1:5000/$endpoint'),
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
  required String endpoint,
  required Map<String, dynamic> toSend,
}) async {
  try {
    return await postData(
      endpoint: endpoint,
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
  final Map<String, dynamic> data = {'email': email, 'pwd': pwd};
  return sendData(endpoint: 'login', toSend: data);
}

Future<Map<String, dynamic>> insertData({
  required String table,
  required List<String> values,
}) async {
  final Map<String, dynamic> data = {'table': table, 'values': values};
  return sendData(endpoint: 'insertdb', toSend: data);
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
  };
  return sendData(endpoint: 'updatedb', toSend: data);
}

Future<Map<String, dynamic>> selectData({
  required String table,
}) async {
  final Map<String, dynamic> data = {'table': table};
  return sendData(endpoint: 'selectdb', toSend: data);
}

Future<Map<String, dynamic>> deleteData({
  required String table,
  required String id,
}) async {
  final Map<String, dynamic> data = {
    'table': table,
    'id': id,
  };
  return sendData(endpoint: 'deletedb', toSend: data);
}

Future<Map<String, dynamic>> spData({
  required String sp,
}) async {
  final Map<String, dynamic> data = {'sp': sp};
  return sendData(endpoint: 'spdb', toSend: data);
}
