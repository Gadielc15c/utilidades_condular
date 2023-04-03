import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:utilidades_condular/pages/home_page.dart';
import 'package:utilidades_condular/pages/login.dart';
import 'package:utilidades_condular/common/myFunctions/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Construcciones Modulares',
      home: const MainPage(),
      routes: {
        '/login': (context) => const LoginScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.red,
        dialogTheme: const DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        SfGlobalLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("es", "MX"),
      ],
      locale: const Locale("es", "MX"),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  double borderRadius = 20;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Auth.isLoggedIn(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data == true) {
            return const HomePage();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}

// TODO

// The selects for each page and login
// if textfield isn't mandatory, remove the onChange condition
// edit cells on consulta historico de acciones

// DB logs
// implement login

// Test if the mandatory text is displayed correctly under dates
// Test everything new from historico de archivo like the mandatory text, the insert
// Update database in consulta historico whenever it edits
// only show those with status of 1
// fix borders in consulta historico
// make sure the sql calls aren't double calling

//FK_PROYECTO is suppose to be a reference to PROYECTOS NOMBRE, example: La Vega


