import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'consulta_historico_de_acciones.dart';
import 'historico_de_acciones.dart';
import 'historico_de_archivos.dart';
import 'defaul_config.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adaptive App',
      home: const HomePage(),
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  double borderRadius = 20;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double myWidth = colSpaceWidth(context) / 1.2;
    double myHeight = colSpaceHeight(context) / 1.2;

    void drawerSelectedIndex(int index) {
      setState(() {
        selectedIndex = index;
      });
    }

    void changeState({required var toChange, required var value}) {
      setState(() {
        toChange = value;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("title"),
        backgroundColor: Colors.red,
      ),
      body: Container(
        color: const Color.fromARGB(255, 220, 220, 220),
        alignment: Alignment.center,
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
            width: myWidth,
            height: myHeight.clamp(570, 760),
            child: selectedIndex == 2
                ? historicoDeAcciones(
                    context: context,
                    stateChange: changeState,
                    contextHeight: myHeight,
                    contextWidth: myWidth,
                  )
                : selectedIndex == 1
                    ? historicoDeArchivos(
                        context: context,
                        stateChange: changeState,
                        contextHeight: myHeight,
                        contextWidth: myWidth,
                      )
                    : selectedIndex == 0
                        ? LayoutBuilder(
                            builder: (context, constraint) {
                              return consultaHistoricoDeAccionesTab(
                                context: context,
                                stateChange: changeState,
                                widgetHeight: constraint.maxHeight,
                                widgetWidth: constraint.maxWidth,
                              );
                            },
                          )
                        : const Text('Empty'),
          ),
        ),
      ),
      drawer: Container(
        width: 200,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const UserAccountsDrawerHeader(
                accountName: Text("Account name"),
                accountEmail: Text("Accountemail@aaaa.com"),
                decoration: BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                    image: AssetImage("images/ph.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Search'),
                onTap: () {
                  drawerSelectedIndex(0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  drawerSelectedIndex(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.label),
                title: const Text('Item 1'),
                onTap: () {
                  drawerSelectedIndex(2);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.library_books),
                title: const Text('Item 2'),
                onTap: () {
                  drawerSelectedIndex(3);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.chat),
                title: const Text('Item 3'),
                onTap: () {
                  drawerSelectedIndex(4);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
