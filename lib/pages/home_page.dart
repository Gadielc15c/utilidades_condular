import 'package:flutter/material.dart';
import 'package:utilidades_condular/pages/consulta_historico_de_acciones.dart';
import 'package:utilidades_condular/pages/historico_de_acciones.dart';
import 'package:utilidades_condular/pages/historico_de_archivos.dart';
import 'package:utilidades_condular/defaul_config.dart';
import 'package:utilidades_condular/common/myFunctions/auth.dart';

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
        title: const Text("Construcciones Modulares"),
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
                ? HistoricoDeAcciones(
                    contextHeight: myHeight,
                    contextWidth: myWidth,
                  )
                : selectedIndex == 1
                    ? HistoricoDeArchivos(
                        contextHeight: myHeight,
                        contextWidth: myWidth,
                      )
                    : selectedIndex == 2
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
                future: getUser(),
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
                leading: const Icon(Icons.label),
                title: const Text('Historico de Acciones'),
                onTap: () {
                  drawerSelectedIndex(0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.label),
                title: const Text('Historico de Archivos'),
                onTap: () {
                  drawerSelectedIndex(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.label),
                title: const Text('Consulta de Historico'),
                onTap: () {
                  drawerSelectedIndex(2);
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Log out'),
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
