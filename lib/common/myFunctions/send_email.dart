import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

String username = "astabotia@gmail.com";
String password = "mbqwlkitzndhczfg";
List<String> recipientsList = [
    'gadielcascante152001@gmail.com',
    'ingenieria_condular@outlook.com',
    'enlace.adm.cond@gmail.com',
  ];

String generateHtmlEmail(List<String> valuesList) {
  String id = valuesList[0];
  String action = valuesList[1];
  String date = valuesList[2];
  String description = valuesList[3];
  String observation = valuesList[4];
  String status = valuesList[5];

  return '''
<html>
  <head>
    <title>HISTÓRICO DE ACCIONES</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    
  </head>
  <body
    style="
      background-color: #f4f4f4;
      margin: 0 !important;
      padding: 0 !important;
    "
  >
    <!-- HIDDEN PREHEADER TEXT -->
    <div
      style="
        display: none;
        font-size: 1px;
        color: #fefefe;
        line-height: 1px;
        font-family: 'Lato', Helvetica, Arial, sans-serif;
        max-height: 0px;
        max-width: 0px;
        opacity: 0;
        overflow: hidden;
      "
    >Hey!!, Se han agregado acciones al Histórico
    </div>

    <table border="0" cellpadding="0" cellspacing="0" width="100%">
      <!-- LOGO -->
      <tr>
        <td bgcolor="#ff3b3b" align="center">
          <table
            border="0"
            cellpadding="0"
            cellspacing="0"
            width="100%"
            style="max-width: 600px"
          >
            <tr>
              <td
                align="center"
                valign="top"
                style="padding: 40px 10px 40px 10px"
              >
                <a href=" " target="_blank"> </a>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td bgcolor="#ff3b3b" align="center" style="padding: 0px 10px 0px 10px">
          <table
            border="0"
            cellpadding="0"
            cellspacing="0"
            width="100%"
            style="max-width: 600px"
          >
            <tr>
              <td
                bgcolor="#ffffff"
                align="center"
                valign="top"
                style="
                  padding: 40px 20px 20px 20px;
                  border-radius: 4px 4px 0px 0px;
                  color: #111111;
                  font-family: 'Lato', Helvetica, Arial, sans-serif;
                  font-size: 48px;
                  font-weight: 400;
                  letter-spacing: 4px;
                  line-height: 48px;
                "
              >
                <img
                  src="https://constructoracondular.com/wp-content/uploads/2021/10/Animacion-LOGO-COND.png"
                  alt=""
                  width="150"
                  height="150"
                />

                <h1 style="font-size: 28px; font-weight: 400; margin: 0">
                 Histórico de acciones
                </h1>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td bgcolor="#f4f4f4" align="center" style="padding: 0px 10px 0px 10px">
          <table
            border="0"
            cellpadding="0"
            cellspacing="0"
            width="100%"
            style="max-width: 600px"
          >
            <tr>
              <td
                bgcolor="#ffffff"
                align="left"
                style="
                  padding: 20px 30px 40px 30px;
                  color: #666666;
                  font-family: 'Lato', Helvetica, Arial, sans-serif;
                  font-size: 18px;
                  font-weight: 400;
                  line-height: 25px;
                "
              >
                <p style="margin: 0">
                  Hola, Hemos Creado un Correo  automaticamente.
                </p>

                <p style="margin: 0">
                  Si crees que esto no debería ser:
                  <a href="mailto:gadielcascante152001@gmail.com">Contactar soporte</a>

                </p>

              </td>
            </tr>

            <tr>
              <td bgcolor="#ffffff" align="left">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td
                      bgcolor="#ffffff"
                      align="center"
                      style="padding: 20px 30px 60px 30px"
                    >
                      <table border="0" cellspacing="0" cellpadding="0">
                        <tr>
                             <p style="margin: 0">ACCION: $action</p>
                           <p style="margin: 0">ID: $id</p>
    <p style="margin: 0">FECHA: $date</p>
    <p style="margin: 0">DESCRIPCION: $description</p>
    <p style="margin: 0">OBSERVACION: $observation</p>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <!-- COPY -->

            <tr>
              <td
                bgcolor="#ffffff"
                align="left"
                style="
                  padding: 0px 30px 40px 30px;
                  border-radius: 0px 0px 4px 4px;
                  color: #f80000;
                  font-family: 'Lato', Helvetica, Arial, sans-serif;
                  font-size: 15px;
                  font-weight: 400;
                  line-height: 25px;
                "
              >
                <br />
                <p style="margin: 0">💖 Con Mucho amor: AstaBot</p>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </body>
</html>

''';
}

Future<void> generateHtmlAndSendEmail(List<String> valuesList) async {
  String htmlEmail = generateHtmlEmail(valuesList);

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
