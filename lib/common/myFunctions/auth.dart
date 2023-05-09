// ignore_for_file: use_build_context_synchronously

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class Auth {
  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? expirationTime = prefs.getInt('sessionExpiration');

    // if (expirationTime != null &&
    //     DateTime.now().millisecondsSinceEpoch > expirationTime) {
    //   await logout();
    //   return false;
    // } COMENTADO POR FINES MAMAGUEVISTICOS 
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<void> login({
    required String username,
    required String password,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int expirationTime =
        DateTime.now().add(const Duration(minutes: 20)).millisecondsSinceEpoch;

    await prefs.setString('username', username);
    await prefs.setString('password', password);
    await prefs.setInt('sessionExpiration', expirationTime);
    await prefs.setBool('isLoggedIn', true);
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('password');
    await prefs.remove('sessionExpiration');
    await prefs.setBool('isLoggedIn', false);
  }
}

Future<void> logInFunc({
  required String username,
  required String password,
}) async {
  await Auth.login(
    username: username,
    password: password,
  );
}

Future<void> logOutFunc(BuildContext context) async {
  await Auth.logout();
  Navigator.of(context).pushNamed('/login');
}

Future<String?> getUser(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (await Auth.isLoggedIn()) {
    return prefs.getString('username');
  }
  Navigator.of(context).pushNamed('/login');
  return "";
}
