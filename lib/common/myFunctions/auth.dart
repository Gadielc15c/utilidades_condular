// ignore_for_file: use_build_context_synchronously

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class Auth {
  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<void> login(
      {required String username, required String password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
    await prefs.setBool('isLoggedIn', true);
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('password');
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

Future<String?> getUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('username');
}
