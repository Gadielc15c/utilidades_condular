import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:utilidades_condular/backend/api_bridge.dart';
import 'package:utilidades_condular/defaul_config.dart';
import 'package:utilidades_condular/main.dart';
import 'package:utilidades_condular/common/myFunctions/auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Duration get loginTime => const Duration(milliseconds: 1050);

  Future<String?> _authUser(LoginData data) async {
    try {
      await Future.delayed(loginTime);
      Map<String, dynamic> result = await verifyLogin(
        email: data.name,
        pwd: data.password,
      );
      if (result[scc]) {
        logInFunc(
          username: result[cnt]["EMAIL"],
          password: result[cnt]["CLAVE"],
        );
        return null;
      } else {
        return result[err];
      }
    } catch (e) {
      return "Ha ocurrido un error: $e";
    }
  }

  Future<String> _recoverPassword(String name) async {
    try {
      await Future.delayed(loginTime);
      return "Funcion deshabilitada";
    } catch (e) {
      return "Ha ocurrido un error: $e";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: '',
      logo: const AssetImage('images/condlogo.jpg'),
      onLogin: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MainPage()));
      },
      onRecoverPassword: _recoverPassword,
      hideForgotPasswordButton: true,
      messages: LoginMessages(
        userHint: 'Usuario',
        passwordHint: 'Contraseña',
        confirmPasswordHint: 'Confirmar',
        loginButton: 'Entrar',
        signupButton: 'Crear Cuenta',
        forgotPasswordButton: 'Olvidé Mi Contraseña',
        goBackButton: 'Regresar',
        recoverPasswordDescription:
            'Te enviaremos un correo para reiniciar tu contraseña',
        confirmPasswordError: 'Las contraseñas no coinciden.',
        recoverPasswordButton: 'Recuperar',
        recoverPasswordIntro: 'Reinicia tu contraseña',
      ),
    );
  }
}
