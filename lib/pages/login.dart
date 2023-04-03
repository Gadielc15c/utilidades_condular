import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:utilidades_condular/main.dart';
import 'package:utilidades_condular/common/myFunctions/auth.dart';

int nivelAcceso = 0;
var users = const {
  'F@gmail.com': '1515',
  'Guev@gmail.com': '1515',
};

String defaultIncorrectInput = "Usuario y/o Contraseña incorrecta.";

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Duration get loginTime => const Duration(milliseconds: 1050);

  Future<String?> _authUser(LoginData data) async {
    try {
      await Future.delayed(loginTime);
      if (!users.containsKey(data.name)) {
        return defaultIncorrectInput;
      }
      if (users[data.name] != data.password) {
        return defaultIncorrectInput;
      }
      logInFunc(
        username: data.name,
        password: data.password,
      );
      return null;
    } catch (e) {
      return "Ha ocurrido un error: $e";
    }
  }

  Future<String> _recoverPassword(String name) async {
    try {
      await Future.delayed(loginTime);
      if (!users.containsKey(name)) {
        return "El correo no existe";
      }
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
