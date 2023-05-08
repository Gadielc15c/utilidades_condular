import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import '../../backend/api_bridge.dart';
import '../../defaul_config.dart';

String username = "astabotia@gmail.com";
String password = "mbqwlkitzndhczfg";

List<String> recipientsList = [
   'enlace.adm.cond@gmail.com',
   'jesuscondular@gmail.com',
  'ingenieria_condular@outlook.com',
  'gadielcascante152001@gmail.com',
];

Future<String> generateHtmlEmail(List<String> valuesList) async {
  String projectName = await _getProjectNameById(int.parse(valuesList[0]));
  String action = valuesList[1];
  String date = valuesList[2];
  String description = valuesList[3];
  String observation = valuesList[4];
  String status = valuesList[5];

  while (projectName.isEmpty) {
    await Future.delayed(Duration(milliseconds: 100));
    projectName = await _getProjectNameById(int.parse(valuesList[0]));
  }

  if (projectName.isNotEmpty) {
    return '''<html>

<head>
    <title>HISTÓRICO DE ACCIONES</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

</head>

<body style="
      background-color: #f4f4f4;
      margin: 0 !important;
      padding: 0 !important;
    ">
    <!-- HIDDEN PREHEADER TEXT -->
    <div style="
        display: none;
        font-size: 1px;
        color: #fefefe;
        line-height: 1px;
        font-family: 'Lato', Helvetica, Arial, sans-serif;
        max-height: 0px;
        max-width: 0px;
        opacity: 0;
        overflow: hidden;
      ">Hey!!, Se han agregado acciones al Histórico
    </div>

    <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <!-- LOGO -->
        <tr>
            <td bgcolor="#ff3b3b" align="center">
                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 600px">
                    <tr>
                        <td align="center" valign="top" style="padding: 40px 10px 40px 10px">
                            <a href=" " target="_blank"> </a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td bgcolor="#ff3b3b" align="center" style="padding: 0px 10px 0px 10px">
                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 600px">
                    <tr>
                        <td bgcolor="#ffffff" align="center" valign="top" style="
                  padding: 40px 20px 20px 20px;
                  border-radius: 4px 4px 0px 0px;
                  color: #111111;
                  font-family: 'Lato', Helvetica, Arial, sans-serif;
                  font-size: 48px;
                  font-weight: 400;
                  letter-spacing: 4px;
                  line-height: 48px;
                ">
                            <img src="https://constructoracondular.com/wp-content/uploads/2021/10/Animacion-LOGO-COND.png"
                                alt="" width="150" height="150" />

                            <h1 style="font-size: 28px; font-weight: 400; margin: 0">
                            HISTÓRICO DE ACCIONES
                        </h1>
                        <h1 style="font-size: 10px; font-weight: 400; margin: 0">
                            REPORTE AUTOMÁTICO
                        </h1>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td bgcolor="#f4f4f4" align="center" style="padding: 0px 10px 0px 10px">
                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 600px">
              
                    <tr>
                        <td bgcolor="#ffffff" align="left">
                            <table style="width: 100%; border-collapse: separate; border-spacing: 0 10px; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);">
                                <tr style="margin-bottom: 10px;">
                                    <td style="background-color:#f80000; color: white; font-weight: bold; padding: 4px;">PROYECTO: $projectName</td>
                                </tr>
                                 
                                <tr style="margin-bottom: 10px;">
                                    <td style="background-color: #f80000; color: white; font-weight: bold; padding: 4px;">ACCION: $action
                                </td>
                                </tr>
                              
                                <tr style="margin-bottom: 30px;">
                                    <td style="background-color: #f80000; color: white; font-weight: bold; padding: 4px;">FECHA: $date</td>
                                </tr>

                                <tr style="margin-bottom: 10px;" align="center">
                                    <td style="background-color: #f80000; color: white; font-weight: bold; padding: 4px;">DESCRIPCIÓN</td>
                                </tr> 
                                <tr style="margin-bottom: 10px;">
                                    <td style="background-color: white; padding: 4px; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);">$description</td>
                                </tr>
                                                              <tr style="margin-bottom: 10px;" align="center">
                                    <td style="background-color: #f80000; color: white; font-weight: bold; padding: 4px;">OBSERVACIÓN</td>
                                </tr> 
                                <tr style="margin-bottom: 10px;">
                                <tr style="margin-bottom: 10px;">
                                    <td style="background-color: white; padding: 4px; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);">$observation</td>
                                </tr>
                            </table>
                            
                        </td>
                    </tr>

                </table>
            </td>
        </tr>
        <!-- COPY -->

        <tr>
            <td bgcolor="#ffffff" align="left" style="
                  padding: 0px 30px 40px 30px;
                  border-radius: 0px 0px 4px 4px;
                  color: #f80000;
                  font-family: 'Lato', Helvetica, Arial, sans-serif;
                  font-size: 15px;
                  font-weight: 400;
                  line-height: 25px;
                ">
                <br />
                <p style="margin: 0">💖 Con Mucho amor: AstaBot </p>
                <a href="mailto:gadielcascante152001@gmail.com">Contactar Soporte</a>
            </td>
        </tr>
    </table>
    </td>
    </tr>
    </table>
</body>

</html>
''';
  } else {
    throw Exception('Project name not available');
  }
}

Future<void> generateHtmlAndSendEmail(List<String> valuesList) async {
  String htmlEmail = await generateHtmlEmail(valuesList);

  // Configura el correo
  final smtpServer = gmail(username, password);

  final message = Message()
    ..from = Address(username, 'Departamento de Ingeniería')
    ..recipients.addAll(recipientsList)
    ..subject = 'Histórico de Actividad'
    ..html = htmlEmail;

  // Envía el correo
  try {
    // Enviar el mensaje usando el servidor SMTP
    final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
  } catch (e) {
    print('Message not sent: ' + e.toString());
  }
}

Future<String> _getProjectNameById(int projectId) async {
  var results = await spData(sp: "get_unique_proyectos_name");
  String projectName = '';
  if (results[scc]) {
    for (var aMap in results[cnt].values) {
      if (int.parse(aMap['ID_PROYECTO'].toString()) == projectId) {
        projectName = aMap['NOMBRE'];
        print("Found projectName: $projectName");
        break;
      }
    }
  } else {
    print("ERROR");
  }
  return projectName;
}
