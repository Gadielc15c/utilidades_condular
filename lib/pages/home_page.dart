import 'package:flutter/material.dart';
import 'package:utilidades_condular/pages/consulta_archivos.dart';
import 'package:utilidades_condular/pages/consulta_historico_de_acciones.dart';
import 'package:utilidades_condular/pages/historico_de_archivos.dart';
import 'package:utilidades_condular/pages/historico_de_acciones.dart';
import 'package:utilidades_condular/pages/historico_de_archivos.dart';
import 'package:utilidades_condular/defaul_config.dart';
import 'package:utilidades_condular/common/myFunctions/auth.dart';

import 'dashboard.dart';

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
      if (mounted) {
        setState(() {
          selectedIndex = index;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("CONDULAR"),
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
            child: selectedIndex == 0
                ? Dashboard(
                    contextHeight: myHeight,
                    contextWidth: myWidth,
                  )
                : selectedIndex == 1
                    ? HistoricoDeAcciones(
                        contextHeight: myHeight,
                        contextWidth: myWidth,
                      )
                    : selectedIndex == 2
                        ? HistoricoDeArchivos(
                            contextHeight: myHeight,
                            contextWidth: myWidth,
                          )
                        : selectedIndex == 3
                            ? LayoutBuilder(
                                builder: (context, constraint) {
                                  return ConsultaArchv(
                                    widgetHeight: constraint.maxHeight,
                                    widgetWidth: constraint.maxWidth,
                                  );
                                },
                              )
                            : selectedIndex == 4
                                ? LayoutBuilder(
                                    builder: (context, constraint) {
                                      return ConsultaHistDeAcciones(
                                        widgetHeight: constraint.maxHeight,
                                        widgetWidth: constraint.maxWidth,
                                      );
                                    },
                                  )
                                : const Text('Empty'),
          ),
        ),
      ),
      drawer: SizedBox(
        width: 200,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              FutureBuilder(
                future: getUser(context),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return UserAccountsDrawerHeader(
                      accountName: const Text(""),
                      accountEmail: Text(
                        snapshot.data!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        image: DecorationImage(
                          image: AssetImage("images/condlogo.jpg"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.dashboard),
                title: const Text('Dashboard'),
                onTap: () {
                  drawerSelectedIndex(0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.access_time_outlined),
                title: const Text('Histórico de Acciones'),
                onTap: () {
                  drawerSelectedIndex(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Consulta de Histórico'),
                onTap: () {
                  drawerSelectedIndex(4);
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.create_new_folder),
                title: const Text('Histórico de Archivos'),
                onTap: () {
                  drawerSelectedIndex(2);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.folder_open),
                title: const Text('Consulta de Archivos'),
                onTap: () {
                  drawerSelectedIndex(3);
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Salir'),
                onTap: () {
                  logOutFunc(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
