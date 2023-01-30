import 'package:flutter/material.dart';
import 'historial.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive App',
      theme: ThemeData(
        navigationRailTheme: const NavigationRailThemeData(
          elevation: 20,
          useIndicator: true,
          indicatorColor: Colors.green,
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double colSpaceHeight = MediaQuery.of(context).size.height / 1.5;
    double colSpaceWidth = MediaQuery.of(context).size.width / 1.5;
    double borderRadius = 20;

    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 220, 220, 220),
        child: Row(
          children: [
            NavigationRail(
              leading: Image.asset(
                "images/ph.png",
                scale: 10,
              ),
              labelType: NavigationRailLabelType.all,
              selectedIndex: selectedIndex,
              groupAlignment: -1.0,
              onDestinationSelected: (int index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.search_outlined),
                  selectedIcon: Icon(Icons.search),
                  label: Text('Search'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: Text('First'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.label_outline),
                  selectedIcon: Icon(Icons.label),
                  label: Text('Second'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.library_books_outlined),
                  selectedIcon: Icon(Icons.library_books),
                  label: Text('Third'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.chat_outlined),
                  selectedIcon: Icon(Icons.chat),
                  label: Text('Fourth'),
                ),
              ],
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.all(Radius.circular(borderRadius))),
                    width: colSpaceWidth,
                    height: colSpaceHeight,
                    child: selectedIndex == 2
                        ? historialTab(context)
                        : const Text('Group alignment'),
                  ),
                ),
              ),
            ),
            // Container(
            //   child: selectedIndex == 2
            //       ? historialTab
            //       : const Text('Group alignment'),
            // ),
          ],
        ),
      ),
    );
  }
}
