import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 228, 228, 228),
          elevation: 0,
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
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('images/ph.png', fit: BoxFit.contain),
        shadowColor: Colors.white,
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            groupAlignment: -1.0,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: ImageIcon(
                  AssetImage('images/ph.png'),
                  size: 50,
                ),
                label: Text(''),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.search_outlined),
                selectedIcon: Icon(Icons.search),
                label: Text('Search'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: Text('First'),
                padding: EdgeInsets.fromLTRB(0, 150, 0, 0),
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
          const VerticalDivider(thickness: 1, width: 1),
        ],
      ),
    );
  }
}
